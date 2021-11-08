import Foundation

struct RollPositiveSides {
  let times: Int
}

// MARK: - Operand, Equatable

extension RollPositiveSides: Operand, Equatable {
  // MARK: - Tokenable

  var description: String {
    return "\(self.times)d"
  }

  // MARK: - Initialization

  private static let regex = NSRegularExpression(#"\A(-?\d+)d\Z"#)

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

  func combined(_ other: Constant) throws -> Operand {
    return Roll(times: self.times, sides: other.term)
  }

  func combined(_ other: Roll) throws -> Operand {
    throw ExpressionError.invalidCombination(
      operandLeft: String(describing: self),
      operandRight: String(describing: other)
    )
  }

  func combined(_ other: RollNegativeSides) throws -> Operand {
    throw ExpressionError.invalidCombination(
      operandLeft: String(describing: self),
      operandRight: String(describing: other)
    )
  }

  func combined(_ other: RollPositiveSides) throws -> Operand {
    let (timesResult, didOverflow) = self.times.addingReportingOverflow(other.times)

    if didOverflow {
      throw ExpressionError.invalidCombination(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return RollPositiveSides(times: timesResult)
  }

  // MARK: - Exclusion

  func dropped() -> Tokenable? {
    return Constant(term: self.times)
  }

  // MARK: - Evaluation

  func value() throws -> Int {
    throw ExpressionError.missingSides(operand: String(describing: self))
  }

  // MARK: - Operation

  func negated() throws -> Operand {
    return RollNegativeSides(times: self.times)
  }
}
