@testable import ChanceKit

typealias RollNegativeSidesFixture = (
	lexeme: String,
	token: RollNegativeSides
)

let rollNegativeSidesFixtures: [RollNegativeSidesFixture] = [
	(lexeme: "0d-", token: RollNegativeSides(times: 0)),
	(lexeme: "1d-", token: RollNegativeSides(times: 1)),
	(lexeme: "9d-", token: RollNegativeSides(times: 9)),
	(lexeme: "\(Int.max)d-", token: RollNegativeSides(times: Int.max)),

	(lexeme: "-0d-", token: RollNegativeSides(times: -0)),
	(lexeme: "-1d-", token: RollNegativeSides(times: -1)),
	(lexeme: "-9d-", token: RollNegativeSides(times: -9)),
	(lexeme: "\(Int.min)d-", token: RollNegativeSides(times: Int.min)),
]
