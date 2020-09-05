import GameplayKit

enum Operand: Equatable {
  case constant(Int)
  case roll(Int, Int)
  case rollNegativeSides(Int)
  case rollPositiveSides(Int)
}

// MARK: - Initialization

// Because enums can't have stored properties
private let timesSidesRegex = NSRegularExpression(#"\A(-?\d+)d(-?\d*)\Z"#)

extension Operand {
  init?(rawLexeme: String) {
    if let term = Int(rawLexeme) {
      self = .constant(term)
      return
    }

    guard let result = timesSidesRegex.firstMatch(in: rawLexeme) else {
      return nil
    }

    guard let rawTimes = result.substring(at: 1, in: rawLexeme) else {
      return nil
    }

    guard let times = Int(rawTimes) else {
      return nil
    }

    guard let rawSides = result.substring(at: 2, in: rawLexeme) else {
      return nil
    }

    if rawSides == "-" {
      self = .rollNegativeSides(times)
      return
    }

    guard let sides = Int(rawSides) else {
      self = .rollPositiveSides(times)
      return
    }

    self = .roll(times, sides)
  }
}

// MARK: - Tokenable

extension Operand: Tokenable {
  var description: String {
    switch self {
    case let .constant(term):
      return String(term)

    case let .roll(times, sides):
      return "\(times)d\(sides)"

    case let .rollNegativeSides(times):
      return "\(times)d-"

    case let .rollPositiveSides(times):
      return "\(times)d"
    }
  }
}

// MARK: - Inclusion

extension Operand {
  func combined(_ other: Operand) throws -> Operand {
    let lexemeSelf = String(describing: self)
    let lexemeOther = String(describing: other)

    switch self {
    case .constant:
      switch other {
      case .constant:
        guard let termResult = Int(lexemeSelf + lexemeOther) else {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        return .constant(termResult)

      default:
        throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
      }

    case let .roll(timesSelf, sidesSelf):
      switch other {
      case .constant:
        guard let sidesResult = Int(String(sidesSelf) + lexemeOther) else {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        return .roll(timesSelf, sidesResult)

      case let .roll(timesOther, sidesOther):
        if sidesSelf != sidesOther {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        let (timesResult, didOverflow) = timesSelf.addingReportingOverflow(timesOther)

        if didOverflow {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        return .roll(timesResult, sidesSelf)

      default:
        throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
      }

    case let .rollNegativeSides(timesSelf):
      switch other {
      case let .constant(termOther):
        // Because -Int.min > Int.max
        if termOther == Int.min {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        return .roll(timesSelf, -termOther)

      case let .rollNegativeSides(timesOther):
        let (timesResult, didOverflow) = timesSelf.addingReportingOverflow(timesOther)

        if didOverflow {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        return .rollNegativeSides(timesResult)

      default:
        throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
      }

    case let .rollPositiveSides(timesSelf):
      switch other {
      case let .constant(termOther):
        return .roll(timesSelf, termOther)

      case let .rollPositiveSides(timesOther):
        let (timesResult, didOverflow) = timesSelf.addingReportingOverflow(timesOther)

        if didOverflow {
          throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
        }

        return .rollPositiveSides(timesResult)

      default:
        throw ExpressionError.invalidCombinationOperands(lexemeSelf, lexemeOther)
      }
    }
  }
}

// MARK: - Exclusion

extension Operand {
  func dropped() -> Tokenable? {
    switch self {
    case let .constant(term):
      let quotient = term / 10

      if quotient != 0 {
        return Operand.constant(quotient)
      }

      let remainder = term % 10

      if remainder < 0 {
        return Operator.subtraction
      }

      return nil

    case let .roll(times, sides):
      let quotient = sides / 10

      if quotient != 0 {
        return Operand.roll(times, quotient)
      }

      let remainder = sides % 10

      if remainder < 0 {
        return Operand.rollNegativeSides(times)
      }

      return Operand.rollPositiveSides(times)

    case let .rollNegativeSides(times):
      return Operand.rollPositiveSides(times)

    case let .rollPositiveSides(times):
      return Operand.constant(times)
    }
  }
}

// MARK: - Evaluation

extension Operand {
  func value() throws -> Int {
    switch self {
    case let .constant(term):
      return term

    case let .roll(times, sides):
      if times == 0 || sides == 0 {
        return 0
      }

      // Because abs(Int.min) > Int.max
      if times == Int.min || sides == Int.min {
        throw ExpressionError.operationOverflow
      }

      var result = 0

      // TODO: Allow users to cancel long-running loops (i.e. large times)
      // Idea 1:
      //  - A concurrent, userInitiated dispatch queue
      //  - A concurrentPerform(iterations:) block within queue.sync(execute:)
      //  - A semaphore to protect the shared state
      // Compile Error:
      //  - queue.sync(execute:) can't cancel blocks
      //  - concurrentPerform(iterations:) doesn't accept an error throwing block
      //
      // Idea 2:
      //  - A serial, userInitiated dispatch queue
      //  - A single, cancelable work item block passed to queue.sync(execute:)
      //  - A single for...in loop within the work item's block
      // Compile Error:
      //  - DispatchWorkItem(block:) doesn't accept an error throwing block
      //
      // Idea 3:
      //  - A serial, userInitiated dispatch queue
      //  - A single for...in loop within try queue.sync(execute:)
      // Runtime Error:
      //  - queue.sync(execute:) can't cancel blocks
      //
      // Idea 4:
      //  - Async execution of expression.interpret(completion: (result: Int?, error: Error?) -> Void) -> DispatchWorkItem
      //  - Inside expression.interpret, create a serial, userInitiated dispatch queue
      //  - A single, cancelable work item block passed to queue.async(execute:)
      //  - Return a reference to the DispatchWorkItem
      //  - The final result is passed to the completion handler as an argument
      //  - Any error is caught and passed to the completion handler as an argument
      //  - Perhaps periodically check if the work item isCanceled in this method and throw an error
      for _ in 1...abs(times) {
        // Each iteration instantiates a new object because each die is an independent source of
        // random numbers. That is, the sequence of numbers generated by one die has no effect on
        // the sequence generated by another.
        let randomDistribution = GKRandomDistribution(forDieWithSideCount: abs(sides))

        let nextInt = randomDistribution.nextInt()

        let (newResult, didOverflow) = result.addingReportingOverflow(nextInt)

        if didOverflow {
          throw ExpressionError.operationOverflow
        }

        result = newResult
      }

      if times < 0 && sides < 0 || times > 0 && sides > 0 {
        return result
      }

      // Because Int.min.negate() > Int.max
      if result == Int.min {
        throw ExpressionError.operationOverflow
      }

      result.negate()

      return result

    case .rollNegativeSides:
      throw ExpressionError.missingOperandRollSides

    case .rollPositiveSides:
      throw ExpressionError.missingOperandRollSides
    }
  }
}

// MARK: - Operation

extension Operand {
  func added(_ other: Operand) throws -> Operand {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.addingReportingOverflow(otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.constant(result)
  }

  func divided(_ other: Operand) throws -> Operand {
    let otherValue = try other.value()

    if otherValue == 0 {
      throw ExpressionError.divisionByZero
    }

    let selfValue = try self.value()
    let (result, didOverflow) = selfValue.dividedReportingOverflow(by: otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.constant(result)
  }

  func multiplied(_ other: Operand) throws -> Operand {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.multipliedReportingOverflow(by: otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.constant(result)
  }

  func subtracted(_ other: Operand) throws -> Operand {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.subtractingReportingOverflow(otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.constant(result)
  }

  func negated() throws -> Operand {
    switch self {
    case let .constant(term):
      // Because -Int.min > Int.max
      if term == Int.min {
        throw ExpressionError.operationOverflow
      }

      return .constant(-term)

    case let .roll(times, sides):
      // Because -Int.min > Int.max
      if sides == Int.min {
        throw ExpressionError.operationOverflow
      }

      return .roll(times, -sides)

    case let .rollNegativeSides(times):
      return .rollPositiveSides(times)

    case let .rollPositiveSides(times):
      return .rollNegativeSides(times)
    }
  }
}
