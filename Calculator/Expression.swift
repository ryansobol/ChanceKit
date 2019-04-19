public struct Expression {
  let infixTokens: [Tokenable]
}

// MARK: - Initialization

extension Expression {
  public init(_ lexemes: [String]) throws {
    self.infixTokens = try lexemes.map { lexeme in
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

  init(_ infixTokens: [Tokenable]) {
    self.infixTokens = infixTokens
  }
}

// MARK: - Equatable

extension Expression: Equatable {
  public static func == (lhs: Expression, rhs: Expression) -> Bool {
    let lht = lhs.infixTokens
    let rht = rhs.infixTokens

    return lht.count == rht.count && !zip(lht, rht).contains { !$0.isEqualTo($1) }
  }
}

// MARK: - CustomStringConvertible

extension Expression: CustomStringConvertible {
  public var description: String {
    let result = infixTokens.reduce("") { accumulation, infixToken in
      let lexeme: String

      if let operatorToken = infixToken as? Operator {
        lexeme = " \(String(describing: operatorToken)) "
      }
      else {
        lexeme = String(describing: infixToken)
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
      let infixTokens = pushed(parenthesisToken: parenthesis)

      return Expression(infixTokens)
    }

    if let `operator` = Operator(rawValue: lexeme) {
      let infixTokens = pushed(operatorToken: `operator`)

      return Expression(infixTokens)
    }

    if let integer = Int(lexeme) {
      let infixTokens = try pushed(integer: integer)

      return Expression(infixTokens)
    }

    throw ExpressionError.invalidLexeme(lexeme)
  }

  func pushed(parenthesisToken: Parenthesis) -> [Tokenable] {
    var infixTokens = self.infixTokens

    if parenthesisToken == .close {
      infixTokens.append(parenthesisToken)

      return infixTokens
    }

    if let lastParenthesis = infixTokens.last as? Parenthesis, lastParenthesis == .close {
      infixTokens.append(Operator.multiplication)
    }
    else if infixTokens.last is Operand {
      infixTokens.append(Operator.multiplication)
    }

    infixTokens.append(parenthesisToken)

    return infixTokens
  }

  func pushed(operatorToken: Operator) -> [Tokenable] {
    var infixTokens = self.infixTokens

    if infixTokens.last is Operator {
      infixTokens.removeLast()
    }

    infixTokens.append(operatorToken)

    return infixTokens
  }

  func pushed(integer: Int) throws -> [Tokenable] {
    var infixTokens = self.infixTokens

    switch infixTokens.last {
    case nil:
      infixTokens.append(Operand.number(integer))

    case let lastParenthesis as Parenthesis:
      if lastParenthesis == .close {
        infixTokens.append(Operator.multiplication)
      }

      infixTokens.append(Operand.number(integer))

    case let lastOperator as Operator:
      let tokenCount = infixTokens.count

      if tokenCount == 1 && lastOperator == .addition {
        infixTokens.removeLast()
      }

      var integer = integer

      if tokenCount == 1 && lastOperator == .subtraction {
        infixTokens.removeLast()

        integer.negate()
      }

      infixTokens.append(Operand.number(integer))

    case let lastOperand as Operand:
      let nextOperand = try lastOperand.pushed(integer)

      infixTokens.removeLast()
      infixTokens.append(nextOperand)

    default:
      preconditionFailure()
    }

    return infixTokens
  }
}

// MARK: - Exclusion

extension Expression {
  public func dropped() -> Expression {
    var infixTokens = self.infixTokens

    guard let lastInfixToken = infixTokens.popLast() else {
      return self
    }

    if let lastOperand = lastInfixToken as? Operand, let nextTokenable = lastOperand.dropped() {
      infixTokens.append(nextTokenable)
    }

    return Expression(infixTokens)
  }
}

// MARK: - Evaluation

// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
extension Expression {
  public func evaluate() throws -> Int {
    let postfixTokens = try parse(infixTokens: infixTokens)

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
