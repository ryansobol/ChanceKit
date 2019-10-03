@testable import ChanceKit

typealias LexebleFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  error: ExpressionError
)

let lexebleFixtures: [LexebleFixture] = [
  (
    description: "(",
    lexemes: ["("],
    infixTokens: [Parenthesis.open],
    error: .missingParenthesisClose
  ),
  (
    description: ")",
    lexemes: [")"],
    infixTokens: [Parenthesis.close],
    error: .missingParenthesisOpen
  ),
]

