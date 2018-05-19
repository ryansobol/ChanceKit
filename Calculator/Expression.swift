// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
public struct Expression {
  let infixTokens: [Tokenable]

  // MARK: - Initialization

  // TODO: - What about testing the error cases?
  public init(_ infixTokens: [String]) throws {
    self.infixTokens = try infixTokens.map { infixToken in
      if let token = Operator(rawValue: infixToken) {
        return token
      }

      if let number = Int(infixToken) {
        return Operand.number(number)
      }

      throw ExpressionError.invalidToken
    }
  }

//  public init(_ infixTokens: String...) throws {
//    try self.init(infixTokens)
//  }

  // TODO: - What about testing the error cases?
  func toPostfixTokens() throws -> [Tokenable] {
    var operators = [Operator]()
    var postfixTokens = [Tokenable]()

    for currentToken in infixTokens {
      switch currentToken {
      case is Operand:
        postfixTokens.append(currentToken)

      case let currentOperator as Operator:
        switch currentOperator {
        case .parenthesisOpen:
          operators.append(currentOperator)

        case .parenthesisClose:
          while true {
            guard let topOperator = operators.popLast() else {
              throw ExpressionError.missingOpenParenthesis
            }

            if topOperator == .parenthesisOpen {
              break
            }

            postfixTokens.append(topOperator)
          }

        case .addition, .division, .multiplication, .subtraction:
          while let topOperator = operators.last {
            if currentOperator.hasPrecedence(topOperator) {
              break
            }

            postfixTokens.append(topOperator)
            operators.removeLast()
          }

          operators.append(currentOperator)
        }

      default:
        throw ExpressionError.invalidToken
      }
    }

    if operators.isEmpty {
      return postfixTokens
    }

    while let topOperator = operators.popLast() {
      if topOperator == .parenthesisOpen {
        throw ExpressionError.missingCloseParenthesis
      }

      postfixTokens.append(topOperator)
    }

    return postfixTokens
  }

  // TODO: - What about testing the error cases?
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

        guard let newOperand = currentOperator.evaluate(operand1, operand2) else {
          throw ExpressionError.invalidOperator
        }

        operands.append(newOperand)

      default:
        throw ExpressionError.invalidToken
      }
    }

    guard operands.count == 1 else {
      throw ExpressionError.missingOperator
    }

    return operands[0].value()
  }
}
