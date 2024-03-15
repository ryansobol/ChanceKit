@testable import ChanceKit

typealias RollFixture = (
	lexeme: String,
	token: Roll
)

let rollFixtures: [RollFixture] = [
	(lexeme: "0d0", token: Roll(times: 0, sides: 0)),
	(lexeme: "1d1", token: Roll(times: 1, sides: 1)),
	(lexeme: "9d9", token: Roll(times: 9, sides: 9)),
	(lexeme: "\(Int.max)d\(Int.max)", token: Roll(times: Int.max, sides: Int.max)),

	(lexeme: "0d-0", token: Roll(times: 0, sides: -0)),
	(lexeme: "1d-1", token: Roll(times: 1, sides: -1)),
	(lexeme: "9d-9", token: Roll(times: 9, sides: -9)),
	(lexeme: "\(Int.max)d\(Int.min)", token: Roll(times: Int.max, sides: Int.min)),

	(lexeme: "-0d0", token: Roll(times: -0, sides: 0)),
	(lexeme: "-1d1", token: Roll(times: -1, sides: 1)),
	(lexeme: "-9d9", token: Roll(times: -9, sides: 9)),
	(lexeme: "\(Int.min)d\(Int.max)", token: Roll(times: Int.min, sides: Int.max)),

	(lexeme: "-0d-0", token: Roll(times: -0, sides: -0)),
	(lexeme: "-1d-1", token: Roll(times: -1, sides: -1)),
	(lexeme: "-9d-9", token: Roll(times: -9, sides: -9)),
	(lexeme: "\(Int.min)d\(Int.min)", token: Roll(times: Int.min, sides: Int.min)),
]
