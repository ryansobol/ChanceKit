@testable import ChanceKit

typealias LexemeRollPositiveSidesFixture = (
  lexeme: String,
  token: RollPositiveSides
)

let lexemeRollPositiveSidesFixtures: [LexemeRollPositiveSidesFixture] = [
  (lexeme: "0d", token: RollPositiveSides(times: 0)),
  (lexeme: "1d", token: RollPositiveSides(times: 1)),
  (lexeme: "9d", token: RollPositiveSides(times: 9)),
  (lexeme: "\(Int.max)d", token: RollPositiveSides(times: Int.max)),

  (lexeme: "-0d", token: RollPositiveSides(times: -0)),
  (lexeme: "-1d", token: RollPositiveSides(times: -1)),
  (lexeme: "-9d", token: RollPositiveSides(times: -9)),
  (lexeme: "\(Int.min)d", token: RollPositiveSides(times: Int.min)),
]
