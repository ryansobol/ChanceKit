func evaluate(postfixTokens: [Tokenable]) throws -> Int {
  if postfixTokens.isEmpty {
    return 0
  }

  var operands = [Operand2]()

  for currentToken in postfixTokens {
    switch currentToken {
    case let currentOperand as Operand2:
      operands.append(currentOperand)

    case let currentOperator as Operator:
      guard let operand2 = operands.popLast() else {
        throw ExpressionError.missingOperand
      }

      guard let operand1 = operands.popLast() else {
        throw ExpressionError.missingOperand
      }

      let newOperand = try currentOperator.evaluate(operand1, operand2)

      operands.append(newOperand)

    default:
      preconditionFailure()
    }
  }

  if operands.count > 1 {
    throw ExpressionError.missingOperator
  }

  return try operands[0].value()
}
