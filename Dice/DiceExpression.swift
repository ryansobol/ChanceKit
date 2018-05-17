enum DiceExpressionError: Error {
  case invalidOperand
  case invalidOperator
  case missingCloseParenthesis
  case missingOperand
  case missingOpenParenthesis
}

// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
public class DiceExpression {
  var infixTokens: [String]

  public init() {
    infixTokens = [String]()
  }

  public init(_ infixTokens: [String]) {
    self.infixTokens = infixTokens
  }

  func hasLowerOrEqualPrecedence(_ operator1: String,
                                 _ operator2: String) -> Bool {
    switch operator1 {
    case "*", "/", "×", "÷":
      switch operator2 {
      case "+", "-":
        return false

      default:
        return true
      }

    default:
      return true
    }
  }

  func toPostfixTokens() throws -> [String] {
    var operators = [String]()
    var postfixTokens = [String]()

    for token in infixTokens {
      switch token {
      case "(":
        operators.append(token)

      case ")":
        while true {
          guard let top = operators.popLast() else {
            throw DiceExpressionError.missingOpenParenthesis
          }

          guard top != "(" else {
            break
          }

          postfixTokens.append(top)
        }

      case "+", "-", "*", "/", "×", "÷":
        while let top = operators.last {
          guard top != "(" else {
            break
          }

          guard hasLowerOrEqualPrecedence(token, top) else {
            break
          }

          postfixTokens.append(top)
          operators.removeLast()
        }

        operators.append(token)

      default:
        postfixTokens.append(token)
      }
    }

    guard !operators.isEmpty else {
      return postfixTokens
    }

    while let top = operators.popLast() {
      guard top != "(" else {
        throw DiceExpressionError.missingCloseParenthesis
      }

      postfixTokens.append(top)
    }

    return postfixTokens
  }

  func isOperator(_ token: String) -> Bool {
    switch token {
    case "+", "-", "*", "/", "×", "÷":
      return true
    default:
      return false
    }
  }

  public func evaluate() throws -> Int {
    var operands = [Int]()

    let postfixTokens = try toPostfixTokens()

    for token in postfixTokens {
      if isOperator(token) {
        guard let operand2 = operands.popLast() else {
          throw DiceExpressionError.missingOperand
        }

        guard let operand1 = operands.popLast() else {
          throw DiceExpressionError.missingOperand
        }

        // TODO: Abstract into OperatorToken type
        switch token {
        case "+":
          operands.append(operand1 + operand2)

        case "-":
          operands.append(operand1 - operand2)

        case "*", "×":
          operands.append(operand1 * operand2)

        case "/", "÷":
          operands.append(operand1 / operand2)

        default:
          throw DiceExpressionError.invalidOperator
        }
      }
      else {
        // TODO: Abstract into OperandToken type
        if let operand = Int(token) {
          operands.append(operand)
        }
        else {
          throw DiceExpressionError.invalidOperand
        }
      }
      // TODO: The true else if OperandToken and OperatorToken types exist
      //    else {
      //      throw EvaluatePostfixError.invalidToken
      //    }
    }

    return operands[0]
  }
}
