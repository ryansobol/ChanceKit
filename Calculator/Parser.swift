func parse(infixTokens: [Tokenable]) throws -> [Tokenable] {
  var markables = [Markable]()
  var postfixTokens = [Tokenable]()

  for currentToken in infixTokens {
    switch currentToken {
    case is Operand:
      postfixTokens.append(currentToken)

    case let currentParenthesis as Parenthesis:
      switch currentParenthesis {
      case .open:
        markables.append(currentParenthesis)

      case .close:
        while true {
          guard let topMarkable = markables.popLast() else {
            throw ExpressionError.missingParenthesisOpen
          }

          if let topParenthesis = topMarkable as? Parenthesis, topParenthesis == Parenthesis.open {
            break
          }

          postfixTokens.append(topMarkable)
        }
      }

    case let currentOperator as Operator:
      while let topMarkable = markables.last {
        if let topParenthesis = topMarkable as? Parenthesis, topParenthesis == .open {
          break
        }

        guard let topOperator = topMarkable as? Operator else {
          preconditionFailure()
        }


        if currentOperator.hasPrecedence(topOperator) {
          break
        }

        postfixTokens.append(topOperator)
        markables.removeLast()
      }

      markables.append(currentOperator)

    default:
      preconditionFailure()
    }
  }

  if markables.isEmpty {
    return postfixTokens
  }

  while let topMarkable = markables.popLast() {
    if let topParenthesis = topMarkable as? Parenthesis, topParenthesis == .open {
      throw ExpressionError.missingParenthesisClose
    }

    guard let topOperator = topMarkable as? Operator else {
      preconditionFailure()
    }

    postfixTokens.append(topOperator)
  }

  return postfixTokens
}
