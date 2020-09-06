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

      if let constant = Constant(rawLexeme: lexeme) {
        return constant
      }

      if let roll = Roll(rawLexeme: lexeme) {
        return roll
      }

      if let rollNegativeSides = RollNegativeSides(rawLexeme: lexeme) {
        return rollNegativeSides
      }

      if let rollPositiveSides = RollPositiveSides(rawLexeme: lexeme) {
        return rollPositiveSides
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
    let result = self.tokens.reduce("") { accumulation, token in
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

    if let constant = Constant(rawLexeme: lexeme) {
      let tokens = try lexed(operand: constant, into: self.tokens)

      return Expression(tokens)
    }

    if let roll = Roll(rawLexeme: lexeme) {
      let tokens = try lexed(operand: roll, into: self.tokens)

      return Expression(tokens)
    }

    if let rollNegativeSides = RollNegativeSides(rawLexeme: lexeme) {
      let tokens = try lexed(operand: rollNegativeSides, into: self.tokens)

      return Expression(tokens)
    }

    if let rollPositiveSides = RollPositiveSides(rawLexeme: lexeme) {
      let tokens = try lexed(operand: rollPositiveSides, into: self.tokens)

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

    if let lastOperand = lastToken as? Operand2, let droppedToken = lastOperand.dropped() {
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
