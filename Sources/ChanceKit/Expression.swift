/// A model representing an expression.
///
/// An expression is initialized with zero or more lexemes using the ``init(lexemes:)`` initializer.
///
/// ```swift
/// import ChanceKit
///
/// let expression: Expression
///
/// do {
///   expression = try Expression(lexemes: ["1d6", "+", "4"])
///
///   print("The expression is \(expression)")
///   // Prints "The expression is 1d6 + 4"
/// }
/// catch LexemeError.invalid(let lexeme) {
///   print("The lexeme \(lexeme) is invalid")
/// }
/// ```
///
/// Interpretting an expression using the ``interpret()`` method produces a result.
///
/// ```swift
/// do {
///   let result = try expression.interpret()
///
///   print("The result \(result) is between 5 and 10")
///   // Prints "The result 7 is between 5 and 10"
/// }
/// catch let error as ExpressionError {
///   print("The expression \(expression) cannot be interpretted because \(error)")
/// }
/// ```
///
/// Dropping a character from the last lexeme of an expression using the ``dropped()`` method produces a new, shorter expression.
///
/// ```swift
/// let shorter = expression.dropped()
///
/// print("The shorter expression is \(shorter)")
/// // Prints "The shorter expression is 1d6 +"
/// ```
///
/// Pushing a lexeme onto the end of an expression using the ``pushed(lexeme:)`` method produces a new, longer expression.
///
/// ```swift
/// do {
///   let longer = try shorter.pushed(lexeme: "2d4")
///
///   print("The longer expression is \(longer)")
///   // Prints "The longer expression is 1d6 + 2d4"
/// }
/// catch LexemeError.invalid(let lexeme) {
///   print("The lexeme \(lexeme) is invalid")
/// }
/// ```
public struct Expression {
  let tokens: [Tokenable]
}

// MARK: - Initialization

extension Expression {
  /// Initializes an expression with zero or more lexemes.
  ///
  /// - Parameter lexemes: The zero or more lexemes of an expression.
  ///
  /// - Throws: ``LexemeError/invalid(lexeme:)`` if any lexeme is invalid.
  public init(lexemes: [String]) throws {
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

      throw LexemeError.invalid(lexeme: lexeme)
    }
  }

  init(_ tokens: [Tokenable]) {
    self.tokens = tokens
  }
}

// MARK: - Equatable

extension Expression: Equatable {
  /// Compares the lexemes of two expressions for equality.
  ///
  /// - Returns: `true` if the lexemes for both expressions are equivalent, otherwise `false`.
  public static func == (lhs: Expression, rhs: Expression) -> Bool {
    let lht = lhs.tokens
    let rht = rhs.tokens

    return lht.count == rht.count && !zip(lht, rht).contains { !$0.isEqualTo($1) }
  }
}

// MARK: - CustomStringConvertible

extension Expression: CustomStringConvertible {
  /// A text representation of an expression.
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
  /// Produces a new, longer expression with a lexeme pushed onto the end.
  ///
  /// The original expression remains unchanged.
  ///
  /// - Parameter lexeme: The lexeme to push onto the end of the original expression.
  ///
  /// - Returns: The longer expression.
  ///
  /// - Throws: ``LexemeError/invalid(lexeme:)`` if the lexeme is invalid.
  public func pushed(lexeme: String) throws -> Expression {
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

    throw LexemeError.invalid(lexeme: lexeme)
  }
}

// MARK: - Exclusion

extension Expression {
  /// Produces a new, shorter expression with a character dropped from the last lexeme.
  ///
  /// The original expression remains unchanged.
  ///
  /// - Returns: The shorter expression if the original contains a lexeme, otherwise the original expression.
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
  /// Produces a result by interpretting an expression.
  ///
  /// The expression remains unchanged.
  ///
  /// - Returns: The result of interpretting the expression.
  ///
  /// - Throws: ``ExpressionError`` if the expression cannot be interpretted for any reason.
  public func interpret() throws -> Int {
    let parsedTokens = try parse(infixTokens: tokens)

    return try evaluate(postfixTokens: parsedTokens)
  }
}
