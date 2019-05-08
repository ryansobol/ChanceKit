import GameplayKit

enum Operand: Equatable {
  case number(Int)
  case roll(Int, Int)
  case rollNegativeSides(Int)
  case rollPositiveSides(Int)
}

// MARK: - Initialization

// Because enums can't have stored properties
private let timesSidesRegex = NSRegularExpression(#"\A(-?\d+)d(-?\d*)\Z"#)

extension Operand {
  init?(rawLexeme: String) {
    if let integer = Int(rawLexeme) {
      self = .number(integer)
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
    case let .number(value):
      return String(value)

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
  func pushed(_ suffix: Int) throws -> Operand {
    let lexeme = String(suffix)

    if suffix < 0 {
      throw ExpressionError.invalidLexeme(lexeme)
    }

    switch self {
    case let .number(value):
      guard let nextValue = Int(String(value) + lexeme) else {
        throw ExpressionError.invalidLexeme(lexeme)
      }

      return .number(nextValue)

    case let .roll(times, sides):
      guard let nextSides = Int(String(sides) + lexeme) else {
        throw ExpressionError.invalidLexeme(lexeme)
      }

      return .roll(times, nextSides)

    case let .rollNegativeSides(times):
      return .roll(times, suffix * -1)

    case let .rollPositiveSides(times):
      return .roll(times, suffix)
    }
  }
}

// MARK: - Exclusion

extension Operand {
  func dropped() -> Tokenable? {
    switch self {
    case let .number(value):
      let quotient = value / 10

      if quotient != 0 {
        return Operand.number(quotient)
      }

      let remainder = value % 10

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
      return Operand.number(times)
    }
  }
}

// MARK: - Evaluation

extension Operand {
  func value() throws -> Int {
    switch self {
    case let .number(value):
      return value

    case let .roll(times, sides):
      if times == 0 || sides == 0 {
        return 0
      }

      // Because abs(Int.min) > Int.max
      if times == Int.min || sides == Int.min {
        throw ExpressionError.operationOverflow
      }

      var result = 0

      // TODO - Allow users to cancel long-running loops (i.e. large times)
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
      //  - Async execution of expression.evaluate(completion: (result: Int?, error: Error?) -> Void) -> DispatchWorkItem
      //  - Inside expression.evaluate, create a serial, userInitiated dispatch queue
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
  static func + (left: Operand, right: Operand) throws -> Operand {
    let leftValue = try left.value()
    let rightValue = try right.value()
    let (result, didOverflow) = leftValue.addingReportingOverflow(rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func / (left: Operand, right: Operand) throws -> Operand {
    let rightValue = try right.value()

    if rightValue == 0 {
      throw ExpressionError.divisionByZero
    }

    let leftValue = try left.value()
    let (result, didOverflow) = leftValue.dividedReportingOverflow(by: rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func * (left: Operand, right: Operand) throws -> Operand {
    let leftValue = try left.value()
    let rightValue = try right.value()
    let (result, didOverflow) = leftValue.multipliedReportingOverflow(by: rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func - (left: Operand, right: Operand) throws -> Operand {
    let leftValue = try left.value()
    let rightValue = try right.value()
    let (result, didOverflow) = leftValue.subtractingReportingOverflow(rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }
}