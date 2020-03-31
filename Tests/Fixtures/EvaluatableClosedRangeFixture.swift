@testable import ChanceKit

typealias EvaluatableClosedRangeFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable],
  value: ClosedRange<Int>
)

let evaluatableClosedRangeFixtures: [EvaluatableClosedRangeFixture] = [
  (
    description: "1d4",
    lexemes: ["1d4"],
    infixTokens: [Operand(rawLexeme: "1d4")!],
    postfixTokens: [Operand(rawLexeme: "1d4")!],
    value: 1...4
  ),
  (
    description: "1d6",
    lexemes: ["1d6"],
    infixTokens: [Operand(rawLexeme: "1d6")!],
    postfixTokens: [Operand(rawLexeme: "1d6")!],
    value: 1...6
  ),
  (
    description: "1d8",
    lexemes: ["1d8"],
    infixTokens: [Operand(rawLexeme: "1d8")!],
    postfixTokens: [Operand(rawLexeme: "1d8")!],
    value: 1...8
  ),
  (
    description: "1d10",
    lexemes: ["1d10"],
    infixTokens: [Operand(rawLexeme: "1d10")!],
    postfixTokens: [Operand(rawLexeme: "1d10")!],
    value: 1...10
  ),
  (
    description: "1d12",
    lexemes: ["1d12"],
    infixTokens: [Operand(rawLexeme: "1d12")!],
    postfixTokens: [Operand(rawLexeme: "1d12")!],
    value: 1...12
  ),
  (
    description: "1d20",
    lexemes: ["1d20"],
    infixTokens: [Operand(rawLexeme: "1d20")!],
    postfixTokens: [Operand(rawLexeme: "1d20")!],
    value: 1...20
  ),
  (
    description: "1d100",
    lexemes: ["1d100"],
    infixTokens: [Operand(rawLexeme: "1d100")!],
    postfixTokens: [Operand(rawLexeme: "1d100")!],
    value: 1...100
  ),
]
