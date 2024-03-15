@testable import ChanceKit

typealias EvaluatableClosedRangeFixture = (
	description: String,
	lexemes: [String],
	infixTokens: [any Tokenable],
	postfixTokens: [any Tokenable],
	value: ClosedRange<Int>
)

let evaluatableClosedRangeFixtures: [EvaluatableClosedRangeFixture] = [
	(
		description: "1d4",
		lexemes: ["1d4"],
		infixTokens: [Roll(times: 1, sides: 4)],
		postfixTokens: [Roll(times: 1, sides: 4)],
		value: 1...4
	),
	(
		description: "1d6",
		lexemes: ["1d6"],
		infixTokens: [Roll(times: 1, sides: 6)],
		postfixTokens: [Roll(times: 1, sides: 6)],
		value: 1...6
	),
	(
		description: "1d8",
		lexemes: ["1d8"],
		infixTokens: [Roll(times: 1, sides: 8)],
		postfixTokens: [Roll(times: 1, sides: 8)],
		value: 1...8
	),
	(
		description: "1d10",
		lexemes: ["1d10"],
		infixTokens: [Roll(times: 1, sides: 10)],
		postfixTokens: [Roll(times: 1, sides: 10)],
		value: 1...10
	),
	(
		description: "1d12",
		lexemes: ["1d12"],
		infixTokens: [Roll(times: 1, sides: 12)],
		postfixTokens: [Roll(times: 1, sides: 12)],
		value: 1...12
	),
	(
		description: "1d20",
		lexemes: ["1d20"],
		infixTokens: [Roll(times: 1, sides: 20)],
		postfixTokens: [Roll(times: 1, sides: 20)],
		value: 1...20
	),
	(
		description: "1d100",
		lexemes: ["1d100"],
		infixTokens: [Roll(times: 1, sides: 100)],
		postfixTokens: [Roll(times: 1, sides: 100)],
		value: 1...100
	),
]
