@testable import ChanceKit

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
