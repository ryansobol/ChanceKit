protocol Operand2: Tokenable {
  // MARK: - Initialization
  
  init?(rawLexeme: String)

  // MARK: - Inclusion

  func combined(_ other: Constant) throws -> Operand2
  func combined(_ other: Roll) throws -> Operand2
  func combined(_ other: RollNegativeSides) throws -> Operand2
  func combined(_ other: RollPositiveSides) throws -> Operand2

  // MARK: - Exclusion

  func dropped() -> Tokenable?

  // MARK: - Evaluation

  func value() throws -> Int

  // MARK: - Operation

  func negated() throws -> Operand2
}

// MARK: - Operation

extension Operand2 {
  func added(_ other: Operand2) throws -> Constant {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.addingReportingOverflow(otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Constant(term: result)
  }

  func divided(_ other: Operand2) throws -> Constant {
    let otherValue = try other.value()

    if otherValue == 0 {
      throw ExpressionError.divisionByZero
    }

    let selfValue = try self.value()
    let (result, didOverflow) = selfValue.dividedReportingOverflow(by: otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Constant(term: result)
  }

  func multiplied(_ other: Operand2) throws -> Constant {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.multipliedReportingOverflow(by: otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Constant(term: result)
  }

  func subtracted(_ other: Operand2) throws -> Constant {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.subtractingReportingOverflow(otherValue)

    if didOverflow {
      throw ExpressionError.operationOverflow
    }

    return Constant(term: result)
  }
}
