@testable import ChanceKit

typealias ParsableOnlyFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable],
  error: ExpressionError
)

let parsableOnlyFixtures: [ParsableOnlyFixture] = [
  (
    description: "+",
    lexemes: ["+"],
    infixTokens: [Operator.addition],
    postfixTokens: [Operator.addition],
    error: .missingOperand
  ),
  (
    description: "÷",
    lexemes: ["÷"],
    infixTokens: [Operator.division],
    postfixTokens: [Operator.division],
    error: .missingOperand
  ),
  (
    description: "×",
    lexemes: ["×"],
    infixTokens: [Operator.multiplication],
    postfixTokens: [Operator.multiplication],
    error: .missingOperand
  ),
  (
    description: "-",
    lexemes: ["-"],
    infixTokens: [Operator.subtraction],
    postfixTokens: [Operator.subtraction],
    error: .missingOperand
  ),
  (
    description: "1 +",
    lexemes: ["1", "+"],
    infixTokens: [Constant(term: 1), Operator.addition],
    postfixTokens: [Constant(term: 1), Operator.addition],
    error: .missingOperand
  ),
  (
    description: "11", // TODO: Fix logic to insert a space separator
    lexemes: ["1", "1"],
    infixTokens: [Constant(term: 1), Constant(term: 1)],
    postfixTokens: [Constant(term: 1), Constant(term: 1)],
    error: .missingOperator
  ),
  (
    description: "1 ÷ 0",
    lexemes: ["1", "÷", "0"],
    infixTokens: [Constant(term: 1), Operator.division, Constant(term: 0)],
    postfixTokens: [Constant(term: 1), Constant(term: 0), Operator.division],
    error: .divisionByZero(operandLeft: "1")
  ),
  (
    description: "9223372036854775807 + 1",
    lexemes: ["9223372036854775807", "+", "1"],
    infixTokens: [
      Constant(term: 9223372036854775807),
      Operator.addition,
      Constant(term: 1),
    ],
    postfixTokens: [
      Constant(term: 9223372036854775807),
      Constant(term: 1),
      Operator.addition,
    ],
    error: .overflowAddition(operandLeft: "9223372036854775807", operandRight: "1")
  ),
  (
    description: "-9223372036854775808 ÷ -1",
    lexemes: ["-9223372036854775808", "÷", "-1"],
    infixTokens: [
      Constant(term: -9223372036854775808),
      Operator.division,
      Constant(term: -1),
    ],
    postfixTokens: [
      Constant(term: -9223372036854775808),
      Constant(term: -1),
      Operator.division,
    ],
    error: .overflowDivision(operandLeft: "-9223372036854775808", operandRight: "-1")
  ),
  (
    description: "-9223372036854775808 × -1",
    lexemes: ["-9223372036854775808", "×", "-1"],
    infixTokens: [
      Constant(term: -9223372036854775808),
      Operator.multiplication,
      Constant(term: -1),
    ],
    postfixTokens: [
      Constant(term: -9223372036854775808),
      Constant(term: -1),
      Operator.multiplication,
    ],
    error: .overflowMultiplication(operandLeft: "-9223372036854775808", operandRight: "-1")
  ),
  (
    description: "9223372036854775807 - -1",
    lexemes: ["9223372036854775807", "-", "-1"],
    infixTokens: [
      Constant(term: 9223372036854775807),
      Operator.subtraction,
      Constant(term: -1),
    ],
    postfixTokens: [
      Constant(term: 9223372036854775807),
      Constant(term: -1),
      Operator.subtraction,
    ],
    error: .overflowSubtraction(operandLeft: "9223372036854775807", operandRight: "-1")
  ),
]
