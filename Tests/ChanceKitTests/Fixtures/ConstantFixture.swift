@testable import ChanceKit

typealias ConstantFixture = (
  lexeme: String,
  token: Constant
)

let constantFixtures: [ConstantFixture] = [
  (lexeme: "0", token: Constant(term: 0)),
  (lexeme: "1", token: Constant(term: 1)),
  (lexeme: "9", token: Constant(term: 9)),
  (lexeme: String(Int.max), token: Constant(term: Int.max)),

  (lexeme: "-0", token: Constant(term: -0)),
  (lexeme: "-1", token: Constant(term: -1)),
  (lexeme: "-9", token: Constant(term: -9)),
  (lexeme: String(Int.min), token: Constant(term: Int.min)),
]
