import Foundation

struct RollNegativeSides {
  let times: Int
}

// MARK: - Operand, Equatable

extension RollNegativeSides: Operand, Equatable {
  // MARK: - Tokenable

  var description: String {
    return "\(self.times)d-"
  }

  // MARK: - Initialization

  private static let regex = NSRegularExpression(#"\A(-?\d+)d-\Z"#)

  init?(rawLexeme: String) {
    guard let result = Self.regex.firstMatch(in: rawLexeme) else {
      return nil
    }

    guard let rawTimes = result.substring(at: 1, in: rawLexeme) else {
      return nil
    }

    guard let times = Int(rawTimes) else {
      return nil
    }

    self.times = times
  }

  // MARK: - Inclusion

  func combined(_ other: Constant) throws -> any Operand {
    // Because -Int.min > Int.max
    if other.term == Int.min {
      throw Expression.PushedError.invalidCombination(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return Roll(times: self.times, sides: -other.term)
  }

  func combined(_ other: Roll) throws -> any Operand {
    throw Expression.PushedError.invalidCombination(
      operandLeft: String(describing: self),
      operandRight: String(describing: other)
    )
  }

  func combined(_ other: RollNegativeSides) throws -> any Operand {
    let (timesResult, didOverflow) = self.times.addingReportingOverflow(other.times)

    if didOverflow {
      throw Expression.PushedError.invalidCombination(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return RollNegativeSides(times: timesResult)
  }

  func combined(_ other: RollPositiveSides) throws -> any Operand {
    throw Expression.PushedError.invalidCombination(
      operandLeft: String(describing: self),
      operandRight: String(describing: other)
    )
  }

  // MARK: - Exclusion

  func dropped() -> (any Tokenable)? {
    return RollPositiveSides(times: self.times)
  }

  // MARK: - Evaluation

  func value() throws -> Int {
    throw Expression.InterpretError.missingSides(operand: String(describing: self))
  }

  // MARK: - Operation

  func negated() throws -> any Operand {
    return RollPositiveSides(times: self.times)
  }
}
