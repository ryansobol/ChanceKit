import GameplayKit

enum Operand: Tokenable, Equatable {
  case number(Int)
  case roll(Int, Int)

  // MARK: - Presentation

  var description: String {
    switch self {
    case let .number(value):
      return String(value)

    case let .roll(times, sides):
      return "\(times)d\(sides)"
    }
  }

  // MARK: - Evaluation

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

      // TODO: - Allow users to cancel long-running loops (i.e. large times)
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
      //  - Async execution of expression.evaluate(completion: (result: Int, error: Error) -> Void)
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
    }
  }

  // MARK: - Operation

  static func +(left: Operand, right: Operand) throws -> Operand {
    let leftValue = try left.value()
    let rightValue = try right.value()
    let (result, didOverflow) = leftValue.addingReportingOverflow(rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func /(left: Operand, right: Operand) throws -> Operand {
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

  static func *(left: Operand, right: Operand) throws -> Operand {
    let leftValue = try left.value()
    let rightValue = try right.value()
    let (result, didOverflow) = leftValue.multipliedReportingOverflow(by: rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func -(left: Operand, right: Operand) throws -> Operand {
    let leftValue = try left.value()
    let rightValue = try right.value()
    let (result, didOverflow) = leftValue.subtractingReportingOverflow(rightValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }
}

// MARK: - Mutation

extension Operand {
  mutating func append(_ digit: String) throws {
    guard let digitValue = Int(digit) else {
      throw ExpressionError.invalidToken(digit)
    }

    if digitValue < 0 {
      throw ExpressionError.invalidToken(digit)
    }

    switch self {
    case let .number(value):
      guard let nextValue = Int(String(value) + digit) else {
        throw ExpressionError.invalidToken(digit)
      }

      self = .number(nextValue)

    case let .roll(times, side):
      guard let nextSide = Int(String(side) + digit) else {
        throw ExpressionError.invalidToken(digit)
      }

      self = .roll(times, nextSide)
    }
  }
}
