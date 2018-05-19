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

    for token in infixTokens {
      switch token {
      case is Operand:
        postfixTokens.append(token)

      case let operatorToken as Operator:
        switch operatorToken {
        case .parenthesisOpen:
          operators.append(operatorToken)

        case .parenthesisClose:
          while true {
            guard let top = operators.popLast() else {
              throw ExpressionError.missingOpenParenthesis
            }

            if top == .parenthesisOpen {
              break
            }

            postfixTokens.append(top)
          }

        case .addition, .division, .multiplication, .subtraction:
          while let top = operators.last {
            if operatorToken.hasPrecedence(top) {
              break
            }

            postfixTokens.append(top)
            operators.removeLast()
          }

          operators.append(operatorToken)
        }

      default:
        throw ExpressionError.invalidToken
      }
    }

    if operators.isEmpty {
      return postfixTokens
    }

    while let top = operators.popLast() {
      if top == .parenthesisOpen {
        throw ExpressionError.missingCloseParenthesis
      }

      postfixTokens.append(top)
    }

    return postfixTokens
  }

  // TODO: - What about testing the error cases?
  public func evaluate() throws -> Int {
    var operands = [Operand]()

    let postfixTokens = try toPostfixTokens()

    for token in postfixTokens {
      switch token {
      case let operatorToken as Operator:
        guard let operand2 = operands.popLast() else {
          throw ExpressionError.missingOperand
        }

        guard let operand1 = operands.popLast() else {
          throw ExpressionError.missingOperand
        }

        guard let operand = operatorToken.evaluate(operand1, operand2) else {
          throw ExpressionError.invalidOperator
        }

        operands.append(operand)

      case let operandToken as Operand:
        operands.append(operandToken)

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
