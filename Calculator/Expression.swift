public struct Expression {
  let tokens: [Tokenable]
}

// MARK: - Initialization

extension Expression {
  public init(_ lexemes: [String]) throws {
    self.tokens = try lexemes.map { lexeme in
      if let parenthesis = Parenthesis(rawValue: lexeme) {
        return parenthesis
      }

      if let `operator` = Operator(rawValue: lexeme) {
        return `operator`
      }

      if let operand = Operand(rawLexeme: lexeme) {
        return operand
      }

      throw ExpressionError.invalidLexeme(lexeme)
    }
  }

  init(_ tokens: [Tokenable]) {
    self.tokens = tokens
  }
}

// MARK: - Equatable

extension Expression: Equatable {
  public static func == (lhs: Expression, rhs: Expression) -> Bool {
    let lht = lhs.tokens
    let rht = rhs.tokens

    return lht.count == rht.count && !zip(lht, rht).contains { !$0.isEqualTo($1) }
  }
}

// MARK: - CustomStringConvertible

extension Expression: CustomStringConvertible {
  public var description: String {
    let result = tokens.reduce("") { accumulation, token in
      let lexeme: String

      if let operatorToken = token as? Operator {
        lexeme = " \(String(describing: operatorToken)) "
      }
      else {
        lexeme = String(describing: token)
      }

      return accumulation + lexeme
    }

    return result.trimmingCharacters(in: .whitespaces)
  }
}

// MARK: - Inclusion

extension Expression {
  public func pushed(_ lexeme: String) throws -> Expression {
    if let parenthesis = Parenthesis(rawValue: lexeme) {
      let tokens = pushed(parenthesisToken: parenthesis)

      return Expression(tokens)
    }

    if let `operator` = Operator(rawValue: lexeme) {
      let tokens = pushed(operatorToken: `operator`)

      return Expression(tokens)
    }

    if let integer = Int(lexeme) {
      let tokens = try pushed(integer: integer)

      return Expression(tokens)
    }

    throw ExpressionError.invalidLexeme(lexeme)
  }

  func pushed(parenthesisToken: Parenthesis) -> [Tokenable] {
    var tokens = self.tokens

    if parenthesisToken == .close {
      tokens.append(parenthesisToken)

      return tokens
    }

    if let lastParenthesis = tokens.last as? Parenthesis, lastParenthesis == .close {
      tokens.append(Operator.multiplication)
    }
    else if tokens.last is Operand {
      tokens.append(Operator.multiplication)
    }

    tokens.append(parenthesisToken)

    return tokens
  }

  func pushed(operatorToken: Operator) -> [Tokenable] {
    var tokens = self.tokens

    if tokens.last is Operator {
      tokens.removeLast()
    }

    tokens.append(operatorToken)

    return tokens
  }

  func pushed(integer: Int) throws -> [Tokenable] {
    var tokens = self.tokens

    switch tokens.last {
    case nil:
      tokens.append(Operand.number(integer))

    case let lastParenthesis as Parenthesis:
      if lastParenthesis == .close {
        tokens.append(Operator.multiplication)
      }

      tokens.append(Operand.number(integer))

    case let lastOperator as Operator:
      let tokensCount = tokens.count

      if tokensCount == 1 && lastOperator == .addition {
        tokens.removeLast()
      }

      var integer = integer

      if tokensCount == 1 && lastOperator == .subtraction {
        tokens.removeLast()

        integer.negate()
      }

      tokens.append(Operand.number(integer))

    case let lastOperand as Operand:
      let nextOperand = try lastOperand.pushed(integer)

      tokens.removeLast()
      tokens.append(nextOperand)

    default:
      preconditionFailure()
    }

    return tokens
  }
}

// MARK: - Exclusion

extension Expression {
  public func dropped() -> Expression {
    var tokens = self.tokens

    guard let lastToken = tokens.popLast() else {
      return self
    }

    if let lastOperand = lastToken as? Operand, let droppedToken = lastOperand.dropped() {
      tokens.append(droppedToken)
    }

    return Expression(tokens)
  }
}

// MARK: - Evaluation

// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
extension Expression {
  public func evaluate() throws -> Int {
    let postfixTokens = try parse(infixTokens: tokens)

    var operands = [Operand]()

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
        preconditionFailure()
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
