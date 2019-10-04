@testable import ChanceKit

typealias LexebleOnlyFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  error: ExpressionError
)

let lexebleOnlyFixtures: [LexebleOnlyFixture] = [
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

