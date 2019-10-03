@testable import ChanceKit

// MARK: - LexebleFixture

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

// MARK: - InvalidFixture

typealias InvalidFixture = (
  lexeme: String,
  error: ExpressionError
)

let invalidFixtures: [InvalidFixture] = [
  (lexeme: "d", error: .invalidLexeme("d")),
  (lexeme: "=", error: .invalidLexeme("=")),
  (lexeme: "[", error: .invalidLexeme("[")),
  (lexeme: "{", error: .invalidLexeme("{")),
  (lexeme: "<", error: .invalidLexeme("<")),
  (lexeme: ".", error: .invalidLexeme(".")),
  (lexeme: ",", error: .invalidLexeme(",")),
  (lexeme: ",", error: .invalidLexeme(",")),
  (lexeme: "**", error: .invalidLexeme("**")),
  (lexeme: "&", error: .invalidLexeme("&")),
  (lexeme: "|", error: .invalidLexeme("|")),
  (lexeme: "!", error: .invalidLexeme("!")),
  (lexeme: "~", error: .invalidLexeme("~")),
  (lexeme: "..<", error: .invalidLexeme("..<")),
  (lexeme: "...", error: .invalidLexeme("...")),
  (lexeme: "<<", error: .invalidLexeme("<<")),
  (lexeme: ">>", error: .invalidLexeme(">>")),
  (lexeme: "%", error: .invalidLexeme("%")),
]
