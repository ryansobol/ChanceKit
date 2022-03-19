protocol Operand: Tokenable {
  // MARK: - Initialization

  init?(rawLexeme: String)

  // MARK: - Inclusion

  func combined(_ other: Constant) throws -> any Operand
  func combined(_ other: Roll) throws -> any Operand
  func combined(_ other: RollNegativeSides) throws -> any Operand
  func combined(_ other: RollPositiveSides) throws -> any Operand

  // MARK: - Exclusion

  func dropped() -> (any Tokenable)?

  // MARK: - Evaluation

  func value() throws -> Int

  // MARK: - Operation

  func negated() throws -> any Operand
}

// MARK: - Operation

extension Operand {
  func added(_ other: any Operand) throws -> Constant {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.addingReportingOverflow(otherValue)

    if didOverflow {
      throw Expression.InterpretError.overflowAddition(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return Constant(term: result)
  }

  func divided(_ other: any Operand) throws -> Constant {
    let otherValue = try other.value()

    if otherValue == 0 {
      throw Expression.InterpretError.divisionByZero(operandLeft: String(describing: self))
    }

    let selfValue = try self.value()
    let (result, didOverflow) = selfValue.dividedReportingOverflow(by: otherValue)

    if didOverflow {
      throw Expression.InterpretError.overflowDivision(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return Constant(term: result)
  }

  func multiplied(_ other: any Operand) throws -> Constant {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.multipliedReportingOverflow(by: otherValue)

    if didOverflow {
      throw Expression.InterpretError.overflowMultiplication(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return Constant(term: result)
  }

  func subtracted(_ other: any Operand) throws -> Constant {
    let selfValue = try self.value()
    let otherValue = try other.value()
    let (result, didOverflow) = selfValue.subtractingReportingOverflow(otherValue)

    if didOverflow {
      throw Expression.InterpretError.overflowSubtraction(
        operandLeft: String(describing: self),
        operandRight: String(describing: other)
      )
    }

    return Constant(term: result)
  }
}
