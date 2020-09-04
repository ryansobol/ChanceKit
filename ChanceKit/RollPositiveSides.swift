import Foundation

struct RollPositiveSides {
  let times: Int
}

// MARK: - Operand2, Equatable

extension RollPositiveSides: Operand2, Equatable {
  // MARK: - Tokenable

  var description: String {
    return "\(self.times)d"
  }

  // MARK: - Initialization

  static private let regex = NSRegularExpression(#"\A(-?\d+)d\Z"#)

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

  func combined(_ other: Constant) throws -> Operand2 {
    return Roll(times: self.times, sides: other.term)
  }

  func combined(_ other: Roll) throws -> Operand2 {
    throw ExpressionError.invalidCombinationOperands(
      String(describing: self),
      String(describing: other)
    )
  }

  func combined(_ other: RollNegativeSides) throws -> Operand2 {
    throw ExpressionError.invalidCombinationOperands(
      String(describing: self),
      String(describing: other)
    )
  }

  func combined(_ other: RollPositiveSides) throws -> Operand2 {
    let (timesResult, didOverflow) = self.times.addingReportingOverflow(other.times)

    if didOverflow {
      throw ExpressionError.invalidCombinationOperands(
        String(describing: self),
        String(describing: other)
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
    throw ExpressionError.missingOperandRollSides
  }

  // MARK: - Operation

  func negated() throws -> Operand2 {
    return RollNegativeSides(times: self.times)
  }
}
