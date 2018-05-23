enum Operand : Tokenable, Equatable {
  case number(Int)

  func value() -> Int {
    switch self {
    case .number(let value):
      return value
    }
  }

  static func +(left: Operand, right: Operand) throws -> Operand {
    let leftValue = left.value()
    let rightValue = right.value()
    let (result, isOverflow) = leftValue.addingReportingOverflow(rightValue)

    if isOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func /(left: Operand, right: Operand) throws -> Operand {
    let rightValue = right.value()

    if rightValue == 0 {
      throw ExpressionError.divisionByZero
    }

    let leftValue = left.value()
    let (result, isOverflow) = leftValue.dividedReportingOverflow(by: rightValue)

    if isOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func *(left: Operand, right: Operand) throws -> Operand {
    let leftValue = left.value()
    let rightValue = right.value()
    let (result, isOverflow) = leftValue.multipliedReportingOverflow(by: rightValue)

    if isOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }

  static func -(left: Operand, right: Operand) throws -> Operand {
    let leftValue = left.value()
    let rightValue = right.value()
    let (result, isOverflow) = leftValue.subtractingReportingOverflow(rightValue)

    if isOverflow {
      throw ExpressionError.operationOverflow
    }

    return Operand.number(result)
  }
}
