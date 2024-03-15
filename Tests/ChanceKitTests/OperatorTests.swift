@testable import ChanceKit
import XCTest

final class OperatorTests: XCTestCase {}

// MARK: - Markable

extension OperatorTests {
	func testDescription() {
		typealias Fixture = (
			operator: Operator,
			expected: String
		)

		let fixtures: [Fixture] = [
			(operator: .addition, expected: "+"),
			(operator: .division, expected: "÷"),
			(operator: .multiplication, expected: "×"),
			(operator: .subtraction, expected: "-"),
		]

		for fixture in fixtures {
			let `operator` = fixture.operator
			let expected = fixture.expected
			let actual = String(describing: `operator`)

			XCTAssertEqual(expected, actual)
		}
	}
}

// MARK: - Comparison

extension OperatorTests {
	func testHasPrecedence() {
		typealias Fixture = (
			operator1: String,
			operator2: String,
			expected: Bool
		)

		let fixtures: [Fixture] = [
			("+", "+", false),
			("+", "-", false),
			("+", "×", false),
			("+", "÷", false),

			("-", "+", false),
			("-", "-", false),
			("-", "×", false),
			("-", "÷", false),

			("×", "+", true),
			("×", "-", true),
			("×", "×", false),
			("×", "÷", false),

			("÷", "+", true),
			("÷", "-", true),
			("÷", "×", false),
			("÷", "÷", false),
		]

		for fixture in fixtures {
			let operator1 = Operator(rawValue: fixture.operator1)!
			let operator2 = Operator(rawValue: fixture.operator2)!
			let expected = fixture.expected
			let actual = operator1.hasPrecedence(operator2)

			XCTAssertEqual(expected, actual, "operator1: \(operator1) operator2: \(operator2)")
		}
	}
}

// MARK: - Evaluation

extension OperatorTests {
	func testEvaluate() {
		typealias Fixture = (
			operator: Operator,
			operand1: Constant,
			operand2: Constant,
			expected: Constant
		)

		let fixtures: [Fixture] = [
			(.addition, Constant(term: 1), Constant(term: 2), Constant(term: 3)),
			(.division, Constant(term: 8), Constant(term: 2), Constant(term: 4)),
			(.multiplication, Constant(term: 6), Constant(term: 7), Constant(term: 42)),
			(.subtraction, Constant(term: 5), Constant(term: 4), Constant(term: 1)),
		]

		for fixture in fixtures {
			let `operator` = fixture.operator
			let operand1 = fixture.operand1
			let operand2 = fixture.operand2
			let expected = fixture.expected
			let actual = try! `operator`.evaluate(operand1, operand2) as! Constant

			XCTAssertEqual(
				expected,
				actual,
				"operator: \(`operator`) operand1: \(operand1) operand2: \(operand2)"
			)
		}
	}

	func testEvaluateDivisionByZero() {
		let `operator` = Operator.division
		let operand1 = Constant(term: 1)
		let operand2 = Constant(term: 0)
		let expected = Expression.InterpretError.divisionByZero(operandLeft: "1")

		XCTAssertThrowsError(try `operator`.evaluate(operand1, operand2)) { error in
			XCTAssertEqual(expected, error as? Expression.InterpretError)
		}
	}

	func testEvaluateOperationOverflow() {
		typealias Fixture = (
			operator: Operator,
			operand1: Constant,
			operand2: Constant,
			expected: Expression.InterpretError
		)

		let fixtures: [Fixture] = [
			(
				.addition,
				Constant(term: Int.max),
				Constant(term: 1),
				expected: .overflowAddition(operandLeft: String(Int.max), operandRight: "1")
			),
			(
				.division,
				Constant(term: Int.min),
				Constant(term: -1),
				expected: .overflowDivision(operandLeft: String(Int.min), operandRight: "-1")
			),
			(
				.multiplication,
				Constant(term: Int.min),
				Constant(term: -1),
				expected: .overflowMultiplication(operandLeft: String(Int.min), operandRight: "-1")
			),
			(
				.subtraction,
				Constant(term: Int.max),
				Constant(term: -1),
				expected: .overflowSubtraction(operandLeft: String(Int.max), operandRight: "-1")
			),
		]

		for fixture in fixtures {
			let `operator` = fixture.operator
			let operand1 = fixture.operand1
			let operand2 = fixture.operand2
			let expected = fixture.expected

			XCTAssertThrowsError(try `operator`.evaluate(operand1, operand2)) { error in
				XCTAssertEqual(expected, error as? Expression.InterpretError)
			}
		}
	}
}
