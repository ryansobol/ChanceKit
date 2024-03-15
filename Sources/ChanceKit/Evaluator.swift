func evaluate(postfixTokens: [any Tokenable]) throws -> Int {
	if postfixTokens.isEmpty {
		return 0
	}

	var operands = [any Operand]()

	for currentToken in postfixTokens {
		switch currentToken {
		case let currentOperand as any Operand:
			operands.append(currentOperand)

		case let currentOperator as Operator:
			guard let operand2 = operands.popLast() else {
				throw Expression.InterpretError.missingOperand
			}

			guard let operand1 = operands.popLast() else {
				throw Expression.InterpretError.missingOperand
			}

			let newOperand = try currentOperator.evaluate(operand1, operand2)

			operands.append(newOperand)

		default:
			preconditionFailure()
		}
	}

	if operands.count > 1 {
		throw Expression.InterpretError.missingOperator
	}

	return try operands[0].value()
}
