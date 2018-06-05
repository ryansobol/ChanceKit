// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
public struct Expression {
  let infixTokens: [Tokenable]

  // MARK: - Initialization

  public init(_ infixTokens: [String]) throws {
    self.infixTokens = try infixTokens.map { infixToken in
      if let parenthesis = Parenthesis(rawValue: infixToken) {
        return parenthesis
      }

      if let operation = Operator(rawValue: infixToken) {
        return operation
      }

      if let number = Int(infixToken) {
        return Operand.number(number)
      }

      throw ExpressionError.invalidToken(infixToken)
    }
  }

  // MARK: - Evaluation

  func toPostfixTokens() throws -> [Tokenable] {
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
            throw ExpressionError.internalError(#line, #function, #file)
          }


          if currentOperator.hasPrecedence(topOperator) {
            break
          }

          postfixTokens.append(topOperator)
          markables.removeLast()
        }

        markables.append(currentOperator)

      default:
        throw ExpressionError.internalError(#line, #function, #file)
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
        throw ExpressionError.internalError(#line, #function, #file)
      }

      postfixTokens.append(topOperator)
    }

    return postfixTokens
  }

  public func evaluate() throws -> Int {
    var operands = [Operand]()

    let postfixTokens = try toPostfixTokens()

    for currentToken in postfixTokens {
      switch currentToken {
      case let currentOperand as Operand:
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
        throw ExpressionError.internalError(#line, #function, #file)
      }
    }

    if operands.isEmpty {
      return 0
    }

    if operands.count > 1 {
      throw ExpressionError.missingOperator
    }

    return try operands[0].value()
  }
}
