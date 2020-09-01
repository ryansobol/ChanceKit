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
      let tokens = lexed(parenthesis: parenthesis, into: self.tokens)

      return Expression(tokens)
    }

    if let `operator` = Operator(rawValue: lexeme) {
      let tokens = lexed(operator: `operator`, into: self.tokens)

      return Expression(tokens)
    }

    if let operand = Operand(rawLexeme: lexeme) {
      let tokens = try lexed(operand: operand, into: self.tokens)

      return Expression(tokens)
    }

    throw ExpressionError.invalidLexeme(lexeme)
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

// MARK: - Interpretation

// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
extension Expression {
  public func interpret() throws -> Int {
    let parsedTokens = try parse(infixTokens: tokens)

    return try evaluate(postfixTokens: parsedTokens)
  }
}
