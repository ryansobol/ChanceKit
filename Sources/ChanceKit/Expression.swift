/// A model representing a mathematical expression that supports probabilities.
///
/// An expression is composed of a sequence of lexemes—numbers and polyhedral dice rolls, separated by arithmetic operations and potentially organized into arithmetic groups. When interpretted, an expression produces a single, probablistic result. New expressions that are longer or shorter in length can be derived from older ones.
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
/// catch Expression.InitError.invalidLexeme(let lexeme) {
///   print("The lexeme \(lexeme) is invalid")
/// }
/// ```
///
/// Interpretting an expression using the ``interpret()`` method produces a single, probablistic result.
///
/// ```swift
/// do {
///   let result = try expression.interpret()
///
///   print("The result \(result) is between 5 and 10")
///   // Prints "The result 7 is between 5 and 10"
/// }
/// catch let error as Expression.InterpretError {
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
/// catch Expression.PushedError.invalidLexeme(let lexeme) {
///   print("The lexeme \(lexeme) is invalid")
/// }
/// ```
public struct Expression {
  let tokens: [Tokenable]
}

// MARK: - Initialization

extension Expression {
  /// A model representing errors thrown when initializing an expression.
  public enum InitError: Error, Equatable {
    /// The error thrown when a lexeme is invalid.
    case invalidLexeme(lexeme: String)
  }

  /// Initializes an expression with zero or more lexemes.
  ///
  /// A lexeme is text that represents either a number, polyhedral dice roll, partial polyhedral dice roll, arithmetic operation, or arithmetic group.
  ///
  /// #### Number
  ///
  /// Text representing an `Int` value. For example, `"1"`, `"-1"`, etc.
  ///
  /// #### Polyhedral Dice Roll
  ///
  /// Text representing an `Int` value, followed by the `d` character, followed by another `Int` value. For example, `"3d6"`, `"-3d6"`,`"3d-6"`, `"-3d-6"`, etc.
  ///
  /// #### Partial Polyhedral Dice Roll

  /// Text representing an `Int` value, followed by the `d` character, possibly followed by the `-` character. For example, `"3d"`, `"-3d"`, `"3d-"`, `"-3d-"`, etc.
  ///
  /// #### Arithmetic Operation
  ///
  /// Text representing the arithmetic opertion of addition, subtraction, multiplcation, or division using `"+"`, `"-"`, `"×"`, or `"÷"` respectively.
  ///
  /// #### Arithmetic Group
  ///
  /// Text representing an aritmetic group using matching pairs of `"("` and `")"`.
  ///
  /// #### Deriving Expressions
  ///
  /// A new, shorter expression can be derived with the ``dropped()`` method. And a new, longer expression can be derived with the ``pushed(lexeme:)`` method.
  ///
  /// - Parameter lexemes: The zero or more lexemes for the expression.
  ///
  /// - Throws: ``InitError`` if the expression cannot be initialized.
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

      throw InitError.invalidLexeme(lexeme: lexeme)
    }
  }

  /// Initializes a blank expression without any lexemes.
  ///
  /// See the ``init(lexemes:)`` method to learn more about lexemes.
  public init() {
    self.tokens = []
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
  /// A model representing errors thrown when a lexeme is pushed onto the end of an expression.
  public enum PushedError: Error, Equatable {
    /// The error thrown when two operands cannot be combined.
    case invalidCombination(operandLeft: String, operandRight: String)

    /// The error thrown when a lexeme is invalid.
    case invalidLexeme(lexeme: String)

    /// The error thrown when an overflow occurs negating an operand.
    case overflowNegation(operand: String)
  }

  /// Produces a new, longer expression with a lexeme pushed onto the end.
  ///
  /// See the ``init(lexemes:)`` method to learn more about lexemes.
  ///
  /// - Parameter lexeme: The lexeme to push onto the end of the original expression.
  ///
  /// - Returns: The longer expression.
  ///
  /// - Throws: ``PushedError`` if the lexeme cannot be pushed.
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

    throw PushedError.invalidLexeme(lexeme: lexeme)
  }
}

// MARK: - Exclusion

extension Expression {
  /// Produces a new, shorter expression with a character is dropped from the last lexeme.
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
  /// A model representing errors thrown when interpretting an expression.
  public enum InterpretError: Error, Equatable {
    /// The error thrown when an operand is divided by zero.
    case divisionByZero(operandLeft: String)

    /// The error thrown when a close parenthesis is missing from the expression.
    case missingParenthesisClose

    /// The error thrown when an open parenthesis is missing from the expression.
    case missingParenthesisOpen

    /// The error thrown when an operand is missing from the expression.
    case missingOperand

    /// The error thrown when an operator is missing from the expression.
    case missingOperator

    /// The error thrown when the sides value is missing from a polyhedral dice operand.
    case missingSides(operand: String)

    /// The error thrown when an overflow occurs adding two operands.
    case overflowAddition(operandLeft: String, operandRight: String)

    /// The error thrown when an overflow occurs dividing two operands.
    case overflowDivision(operandLeft: String, operandRight: String)

    /// The error thrown when an overflow occurs multiplying two operands.
    case overflowMultiplication(operandLeft: String, operandRight: String)

    /// The error thrown when an overflow occurs negating an operand.
    case overflowNegation(operand: String)

    /// The error thrown when an overflow occurs subtracting two operands.
    case overflowSubtraction(operandLeft: String, operandRight: String)
  }

  /// Produces a single, probablistic result by interpretting an expression.
  ///
  /// This method is referentially opaque if the expression is composed of a polyhedral dice roll.
  ///
  /// - Returns: The result of interpretting the expression.
  ///
  /// - Throws: ``InterpretError`` if the expression cannot be interpretted.
  public func interpret() throws -> Int {
    let parsedTokens = try parse(infixTokens: tokens)

    return try evaluate(postfixTokens: parsedTokens)
  }
}
