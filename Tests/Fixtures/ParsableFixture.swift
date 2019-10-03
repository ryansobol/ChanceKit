@testable import ChanceKit

typealias ParsableFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable],
  error: ExpressionError
)

let parsableFixtures: [ParsableFixture] = [
  (
    description: "+",
    lexemes: ["+"],
    infixTokens: [Operator(rawValue: "+")!],
    postfixTokens: [Operator(rawValue: "+")!],
    error: .missingOperand
  ),
  (
    description: "÷",
    lexemes: ["÷"],
    infixTokens: [Operator(rawValue: "÷")!],
    postfixTokens: [Operator(rawValue: "÷")!],
    error: .missingOperand
  ),
  (
    description: "×",
    lexemes: ["×"],
    infixTokens: [Operator(rawValue: "×")!],
    postfixTokens: [Operator(rawValue: "×")!],
    error: .missingOperand
  ),
  (
    description: "-",
    lexemes: ["-"],
    infixTokens: [Operator(rawValue: "-")!],
    postfixTokens: [Operator(rawValue: "-")!],
    error: .missingOperand
  ),
  (
    description: "1 +",
    lexemes: ["1", "+"],
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!],
    error: .missingOperand
  ),
  (
    description: "11", // TODO: Fix logic to insert a space separator
    lexemes: ["1", "1"],
    infixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!],
    error: .missingOperator
  ),
  (
    description: "1 ÷ 0",
    lexemes: ["1", "÷", "0"],
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "0")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "0")!, Operator(rawValue: "÷")!],
    error: .divisionByZero
  ),
  (
    description: "9223372036854775807 + 1",
    lexemes: ["9223372036854775807", "+", "1"],
    infixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
    ],
    error: .operationOverflow
  ),
  (
    description: "-9223372036854775808 ÷ -1",
    lexemes: ["-9223372036854775808", "÷", "-1"],
    infixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "÷")!,
    ],
    error: .operationOverflow
  ),
  (
    description: "-9223372036854775808 × -1",
    lexemes: ["-9223372036854775808", "×", "-1"],
    infixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "×")!,
    ],
    error: .operationOverflow
  ),
  (
    description: "9223372036854775807 - -1",
    lexemes: ["9223372036854775807", "-", "-1"],
    infixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "-")!,
    ],
    error: .operationOverflow
  ),
]
