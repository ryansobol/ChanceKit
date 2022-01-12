@testable import ChanceKit
import XCTest

final class ConstantTests: XCTestCase {}

// MARK: - Tokenable

extension ConstantTests {
  func testDescription() {
    typealias Fixture = (
      token: Constant,
      expected: String
    )

    let fixtures: [Fixture] = [
      (token: Constant(term: 0), expected: "0"),
      (token: Constant(term: 1), expected: "1"),
      (token: Constant(term: 9), expected: "9"),
      (token: Constant(term: Int.max), expected: String(Int.max)),

      (token: Constant(term: -0), expected: "0"),
      (token: Constant(term: -1), expected: "-1"),
      (token: Constant(term: -9), expected: "-9"),
      (token: Constant(term: Int.min), expected: String(Int.min)),
    ]

    for fixture in fixtures {
      let token = fixture.token
      let expected = fixture.expected
      let actual = String(describing: token)

      XCTAssertEqual(expected, actual)
    }
  }
}

// MARK: - Initialization

extension ConstantTests {
  func testInitWithValidRawLexeme() {
    for fixture in constantFixtures {
      let rawLexeme = fixture.lexeme
      let expected = fixture.token
      let actual = Constant(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidRawLexeme() {
    for fixture in invalidLexemeFixtures {
      XCTAssertNil(Constant(rawLexeme: fixture.lexeme))
    }

    for fixture in rollFixtures {
      XCTAssertNil(Constant(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollNegativeSidesFixtures {
      XCTAssertNil(Constant(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollPositiveSidesFixtures {
      XCTAssertNil(Constant(rawLexeme: fixture.lexeme))
    }

    for `operator` in Operator.allCases {
      XCTAssertNil(Constant(rawLexeme: `operator`.rawValue))
    }

    for parenthesis in Parenthesis.allCases {
      XCTAssertNil(Constant(rawLexeme: parenthesis.rawValue))
    }
  }
}

// MARK: - Inclusion

extension ConstantTests {
  func testCombinedWithConstant() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: 1), operand2: Constant(term: 0), expected: Constant(term: 10)),
      (operand1: Constant(term: 21), operand2: Constant(term: 0), expected: Constant(term: 210)),

      (operand1: Constant(term: 0), operand2: Constant(term: 1), expected: Constant(term: 1)),
      (operand1: Constant(term: 2), operand2: Constant(term: 1), expected: Constant(term: 21)),
      (operand1: Constant(term: 32), operand2: Constant(term: 1), expected: Constant(term: 321)),

      (operand1: Constant(term: 0), operand2: Constant(term: 9), expected: Constant(term: 9)),
      (operand1: Constant(term: 8), operand2: Constant(term: 9), expected: Constant(term: 89)),
      (operand1: Constant(term: 78), operand2: Constant(term: 9), expected: Constant(term: 789)),

      (
        operand1: Constant(term: 0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: 9),
        operand2: Constant(term: 223372036854775807),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: 922337203685477580),
        operand2: Constant(term: 7),
        expected: Constant(term: Int.max)
      ),

      (operand1: Constant(term: -0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: -1), operand2: Constant(term: 0), expected: Constant(term: -10)),
      (operand1: Constant(term: -21), operand2: Constant(term: 0), expected: Constant(term: -210)),

      (operand1: Constant(term: -0), operand2: Constant(term: 1), expected: Constant(term: 1)),
      (operand1: Constant(term: -2), operand2: Constant(term: 1), expected: Constant(term: -21)),
      (operand1: Constant(term: -32), operand2: Constant(term: 1), expected: Constant(term: -321)),

      (operand1: Constant(term: -0), operand2: Constant(term: 9), expected: Constant(term: 9)),
      (operand1: Constant(term: -8), operand2: Constant(term: 9), expected: Constant(term: -89)),
      (operand1: Constant(term: -78), operand2: Constant(term: 9), expected: Constant(term: -789)),

      (
        operand1: Constant(term: -0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: -9),
        operand2: Constant(term: 223372036854775807),
        expected: Constant(term: -Int.max)
      ),
      (
        operand1: Constant(term: -922337203685477580),
        operand2: Constant(term: 7),
        expected: Constant(term: -Int.max)
      ),

      (operand1: Constant(term: 0), operand2: Constant(term: -0), expected: Constant(term: 0)),
      (operand1: Constant(term: 1), operand2: Constant(term: -0), expected: Constant(term: 10)),
      (operand1: Constant(term: 21), operand2: Constant(term: -0), expected: Constant(term: 210)),

      (operand1: Constant(term: -0), operand2: Constant(term: -0), expected: Constant(term: 0)),
      (operand1: Constant(term: -1), operand2: Constant(term: -0), expected: Constant(term: -10)),
      (operand1: Constant(term: -21), operand2: Constant(term: -0), expected: Constant(term: -210)),

      (
        operand1: Constant(term: -9),
        operand2: Constant(term: 223372036854775808),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: -922337203685477580),
        operand2: Constant(term: 8),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2) as! Constant

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedWithInvalidConstant() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      // Invalid format
      (operand1: Constant(term: 0), operand2: Constant(term: -1)),
      (operand1: Constant(term: 2), operand2: Constant(term: -1)),
      (operand1: Constant(term: 32), operand2: Constant(term: -1)),

      (operand1: Constant(term: 0), operand2: Constant(term: -9)),
      (operand1: Constant(term: 8), operand2: Constant(term: -9)),
      (operand1: Constant(term: 78), operand2: Constant(term: -9)),

      (operand1: Constant(term: 0), operand2: Constant(term: Int.min)),
      (operand1: Constant(term: 9), operand2: Constant(term: -223372036854775807)),
      (operand1: Constant(term: 922337203685477580), operand2: Constant(term: -7)),

      (operand1: Constant(term: -0), operand2: Constant(term: -1)),
      (operand1: Constant(term: -2), operand2: Constant(term: -1)),
      (operand1: Constant(term: -32), operand2: Constant(term: -1)),

      (operand1: Constant(term: -0), operand2: Constant(term: -9)),
      (operand1: Constant(term: -8), operand2: Constant(term: -9)),
      (operand1: Constant(term: -78), operand2: Constant(term: -9)),

      (operand1: Constant(term: -0), operand2: Constant(term: Int.min)),
      (operand1: Constant(term: -9), operand2: Constant(term: -223372036854775807)),
      (operand1: Constant(term: -922337203685477580), operand2: Constant(term: -7)),

      // Out of range
      (operand1: Constant(term: 922337203685477580), operand2: Constant(term: 8)),
      (operand1: Constant(term: Int.max), operand2: Constant(term: 0)),

      (operand1: Constant(term: -922337203685477580), operand2: Constant(term: 9)),
      (operand1: Constant(term: Int.min), operand2: Constant(term: 0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = Expression.PushedError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.PushedError)
      }
    }
  }

  func testCombinedWithRoll() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: 0)),
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: 1)),
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: 21)),

      (operand1: Constant(term: 1), operand2: Roll(times: 1, sides: 0)),
      (operand1: Constant(term: 1), operand2: Roll(times: 1, sides: 2)),
      (operand1: Constant(term: 1), operand2: Roll(times: 1, sides: 32)),

      (operand1: Constant(term: 9), operand2: Roll(times: 9, sides: 0)),
      (operand1: Constant(term: 9), operand2: Roll(times: 9, sides: 8)),
      (operand1: Constant(term: 9), operand2: Roll(times: 9, sides: 78)),

      (operand1: Constant(term: Int.max), operand2: Roll(times: 1, sides: 0)),
      (operand1: Constant(term: 922337203685477580), operand2: Roll(times: 1, sides: 7)),
      (operand1: Constant(term: 9), operand2: Roll(times: 1, sides: 223372036854775807)),

      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: -0)),
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: -1)),
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: -21)),

      (operand1: Constant(term: 1), operand2: Roll(times: 1, sides: -0)),
      (operand1: Constant(term: 1), operand2: Roll(times: 1, sides: -2)),
      (operand1: Constant(term: 1), operand2: Roll(times: 1, sides: -32)),

      (operand1: Constant(term: 9), operand2: Roll(times: 9, sides: -0)),
      (operand1: Constant(term: 9), operand2: Roll(times: 9, sides: -8)),
      (operand1: Constant(term: 9), operand2: Roll(times: 9, sides: -78)),

      (operand1: Constant(term: Int.max), operand2: Roll(times: 1, sides: -0)),
      (operand1: Constant(term: 922337203685477580), operand2: Roll(times: 1, sides: -7)),
      (operand1: Constant(term: 9), operand2: Roll(times: 1, sides: -223372036854775807)),

      (operand1: Constant(term: 0), operand2: Roll(times: -0, sides: 0)),
      (operand1: Constant(term: 0), operand2: Roll(times: -0, sides: 1)),
      (operand1: Constant(term: 0), operand2: Roll(times: -0, sides: 21)),

      (operand1: Constant(term: 1), operand2: Roll(times: -1, sides: 0)),
      (operand1: Constant(term: 1), operand2: Roll(times: -1, sides: 2)),
      (operand1: Constant(term: 1), operand2: Roll(times: -1, sides: 32)),

      (operand1: Constant(term: 9), operand2: Roll(times: -9, sides: 0)),
      (operand1: Constant(term: 9), operand2: Roll(times: -9, sides: 8)),
      (operand1: Constant(term: 9), operand2: Roll(times: -9, sides: 78)),

      (operand1: Constant(term: Int.max), operand2: Roll(times: -1, sides: 0)),
      (operand1: Constant(term: 922337203685477580), operand2: Roll(times: -1, sides: 7)),
      (operand1: Constant(term: 9), operand2: Roll(times: -1, sides: 223372036854775807)),

      (operand1: Constant(term: 0), operand2: Roll(times: -0, sides: -0)),
      (operand1: Constant(term: 0), operand2: Roll(times: -0, sides: -1)),
      (operand1: Constant(term: 0), operand2: Roll(times: -0, sides: -21)),

      (operand1: Constant(term: 1), operand2: Roll(times: -1, sides: -0)),
      (operand1: Constant(term: 1), operand2: Roll(times: -1, sides: -2)),
      (operand1: Constant(term: 1), operand2: Roll(times: -1, sides: -32)),

      (operand1: Constant(term: 9), operand2: Roll(times: -9, sides: -0)),
      (operand1: Constant(term: 9), operand2: Roll(times: -9, sides: -8)),
      (operand1: Constant(term: 9), operand2: Roll(times: -9, sides: -78)),

      (operand1: Constant(term: Int.max), operand2: Roll(times: -1, sides: -0)),
      (operand1: Constant(term: 922337203685477580), operand2: Roll(times: -1, sides: -7)),
      (operand1: Constant(term: 9), operand2: Roll(times: -1, sides: -223372036854775807)),

      (operand1: Constant(term: -0), operand2: Roll(times: 0, sides: 0)),
      (operand1: Constant(term: -0), operand2: Roll(times: 0, sides: 1)),
      (operand1: Constant(term: -0), operand2: Roll(times: 0, sides: 21)),

      (operand1: Constant(term: -1), operand2: Roll(times: 1, sides: 0)),
      (operand1: Constant(term: -1), operand2: Roll(times: 1, sides: 2)),
      (operand1: Constant(term: -1), operand2: Roll(times: 1, sides: 32)),

      (operand1: Constant(term: -9), operand2: Roll(times: 9, sides: 0)),
      (operand1: Constant(term: -9), operand2: Roll(times: 9, sides: 8)),
      (operand1: Constant(term: -9), operand2: Roll(times: 9, sides: 78)),

      (operand1: Constant(term: Int.min), operand2: Roll(times: 1, sides: 0)),
      (operand1: Constant(term: -922337203685477580), operand2: Roll(times: 1, sides: 8)),
      (operand1: Constant(term: -9), operand2: Roll(times: 1, sides: 223372036854775808)),

      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: -0)),
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: -1)),
      (operand1: Constant(term: 0), operand2: Roll(times: 0, sides: -21)),

      (operand1: Constant(term: -1), operand2: Roll(times: 1, sides: -0)),
      (operand1: Constant(term: -1), operand2: Roll(times: 1, sides: -2)),
      (operand1: Constant(term: -1), operand2: Roll(times: 1, sides: -32)),

      (operand1: Constant(term: -9), operand2: Roll(times: 9, sides: -0)),
      (operand1: Constant(term: -9), operand2: Roll(times: 9, sides: -8)),
      (operand1: Constant(term: -9), operand2: Roll(times: 9, sides: -78)),

      (operand1: Constant(term: Int.min), operand2: Roll(times: 1, sides: -0)),
      (operand1: Constant(term: -922337203685477580), operand2: Roll(times: 1, sides: -8)),
      (operand1: Constant(term: -9), operand2: Roll(times: 1, sides: -223372036854775808)),

      (operand1: Constant(term: -0), operand2: Roll(times: -0, sides: 0)),
      (operand1: Constant(term: -0), operand2: Roll(times: -0, sides: 1)),
      (operand1: Constant(term: -0), operand2: Roll(times: -0, sides: 21)),

      (operand1: Constant(term: -1), operand2: Roll(times: -1, sides: 0)),
      (operand1: Constant(term: -1), operand2: Roll(times: -1, sides: 2)),
      (operand1: Constant(term: -1), operand2: Roll(times: -1, sides: 32)),

      (operand1: Constant(term: -9), operand2: Roll(times: -9, sides: 0)),
      (operand1: Constant(term: -9), operand2: Roll(times: -9, sides: 8)),
      (operand1: Constant(term: -9), operand2: Roll(times: -9, sides: 78)),

      (operand1: Constant(term: Int.min), operand2: Roll(times: -1, sides: 0)),
      (operand1: Constant(term: -92337203685477580), operand2: Roll(times: -1, sides: 8)),
      (operand1: Constant(term: -9), operand2: Roll(times: -1, sides: 223372036854775808)),

      (operand1: Constant(term: -0), operand2: Roll(times: -0, sides: -0)),
      (operand1: Constant(term: -0), operand2: Roll(times: -0, sides: -1)),
      (operand1: Constant(term: -0), operand2: Roll(times: -0, sides: -21)),

      (operand1: Constant(term: -1), operand2: Roll(times: -1, sides: -0)),
      (operand1: Constant(term: -1), operand2: Roll(times: -1, sides: -2)),
      (operand1: Constant(term: -1), operand2: Roll(times: -1, sides: -32)),

      (operand1: Constant(term: -9), operand2: Roll(times: -9, sides: -0)),
      (operand1: Constant(term: -9), operand2: Roll(times: -9, sides: -8)),
      (operand1: Constant(term: -9), operand2: Roll(times: -9, sides: -78)),

      (operand1: Constant(term: Int.min), operand2: Roll(times: -1, sides: -0)),
      (operand1: Constant(term: -922337203685477580), operand2: Roll(times: -1, sides: -8)),
      (operand1: Constant(term: -9), operand2: Roll(times: -1, sides: -223372036854775808)),

      (operand1: Constant(term: 9), operand2: Roll(times: 1, sides: 223372036854775808)),
      (operand1: Constant(term: 0), operand2: Roll(times: 1, sides: Int.max)),

      (operand1: Constant(term: -9), operand2: Roll(times: 1, sides: -223372036854775809)),
      (operand1: Constant(term: -0), operand2: Roll(times: 1, sides: Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = Expression.PushedError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.PushedError)
      }
    }
  }

  func testCombinedWithRollNegativeSides() {
    typealias Fixture = (
      operand1: Constant,
      operand2: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 0), operand2: RollNegativeSides(times: 0)),
      (operand1: Constant(term: 1), operand2: RollNegativeSides(times: 1)),
      (operand1: Constant(term: 9), operand2: RollNegativeSides(times: 9)),
      (operand1: Constant(term: Int.max), operand2: RollNegativeSides(times: 1)),

      (operand1: Constant(term: 0), operand2: RollNegativeSides(times: -0)),
      (operand1: Constant(term: 1), operand2: RollNegativeSides(times: -1)),
      (operand1: Constant(term: 9), operand2: RollNegativeSides(times: -9)),
      (operand1: Constant(term: Int.max), operand2: RollNegativeSides(times: -1)),

      (operand1: Constant(term: -0), operand2: RollNegativeSides(times: 0)),
      (operand1: Constant(term: -1), operand2: RollNegativeSides(times: 1)),
      (operand1: Constant(term: -9), operand2: RollNegativeSides(times: 9)),
      (operand1: Constant(term: -Int.max), operand2: RollNegativeSides(times: 1)),

      (operand1: Constant(term: -0), operand2: RollNegativeSides(times: -0)),
      (operand1: Constant(term: -1), operand2: RollNegativeSides(times: -1)),
      (operand1: Constant(term: -9), operand2: RollNegativeSides(times: -9)),
      (operand1: Constant(term: -Int.max), operand2: RollNegativeSides(times: -1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = Expression.PushedError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.PushedError)
      }
    }
  }

  func testCombinedWithRollPositiveSides() {
    typealias Fixture = (
      operand1: Constant,
      operand2: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 0), operand2: RollPositiveSides(times: 0)),
      (operand1: Constant(term: 1), operand2: RollPositiveSides(times: 1)),
      (operand1: Constant(term: 9), operand2: RollPositiveSides(times: 9)),
      (operand1: Constant(term: Int.max), operand2: RollPositiveSides(times: 1)),

      (operand1: Constant(term: 0), operand2: RollPositiveSides(times: -0)),
      (operand1: Constant(term: 1), operand2: RollPositiveSides(times: -1)),
      (operand1: Constant(term: 9), operand2: RollPositiveSides(times: -9)),
      (operand1: Constant(term: Int.max), operand2: RollPositiveSides(times: -1)),

      (operand1: Constant(term: -0), operand2: RollPositiveSides(times: 0)),
      (operand1: Constant(term: -1), operand2: RollPositiveSides(times: 1)),
      (operand1: Constant(term: -9), operand2: RollPositiveSides(times: 9)),
      (operand1: Constant(term: Int.min), operand2: RollPositiveSides(times: 1)),

      (operand1: Constant(term: -0), operand2: RollPositiveSides(times: -0)),
      (operand1: Constant(term: -1), operand2: RollPositiveSides(times: -1)),
      (operand1: Constant(term: -9), operand2: RollPositiveSides(times: -9)),
      (operand1: Constant(term: Int.min), operand2: RollPositiveSides(times: -1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = Expression.PushedError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.PushedError)
      }
    }
  }
}

// MARK: - Exclusion

extension ConstantTests {
  func testDroppedToNil() {
    let operands = [
      Constant(term: 0),
      Constant(term: 1),
      Constant(term: 9),
      Constant(term: -0),
    ]

    for operand in operands {
      let actual = operand.dropped()

      XCTAssertNil(actual, "operand: \(operand)")
    }
  }

  func testDroppedToConstant() {
    typealias Fixture = (
      operand: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand: Constant(term: 10), expected: Constant(term: 1)),
      (operand: Constant(term: 210), expected: Constant(term: 21)),

      (operand: Constant(term: 21), expected: Constant(term: 2)),
      (operand: Constant(term: 321), expected: Constant(term: 32)),

      (operand: Constant(term: 89), expected: Constant(term: 8)),
      (operand: Constant(term: 789), expected: Constant(term: 78)),

      (operand: Constant(term: Int.max), expected: Constant(term: 922337203685477580)),

      (operand: Constant(term: -10), expected: Constant(term: -1)),
      (operand: Constant(term: -210), expected: Constant(term: -21)),

      (operand: Constant(term: -21), expected: Constant(term: -2)),
      (operand: Constant(term: -321), expected: Constant(term: -32)),

      (operand: Constant(term: -89), expected: Constant(term: -8)),
      (operand: Constant(term: -789), expected: Constant(term: -78)),

      (operand: Constant(term: Int.min), expected: Constant(term: -922337203685477580)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped() as! Constant

      XCTAssertEqual(expected, actual, "operand: \(operand)")
    }
  }

  func testDroppedToOperator() {
    typealias Fixture = (
      operand: Constant,
      expected: Operator
    )

    let fixtures: [Fixture] = [
      (operand: Constant(term: -1), expected: .subtraction),
      (operand: Constant(term: -9), expected: .subtraction),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped() as! Operator

      XCTAssertEqual(expected, actual, "operand: \(operand)")
    }
  }
}

// MARK: - Evaluation

extension ConstantTests {
  func testValue() {
    typealias Fixture = (
      operand: Constant,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand: Constant(term: 42), expected: 42),
      (operand: Constant(term: -42), expected: -42),
      (operand: Constant(term: 0), expected: 0),
      (operand: Constant(term: -0), expected: 0),
      (operand: Constant(term: Int.max), expected: Int.max),
      (operand: Constant(term: Int.min), expected: Int.min),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.value()

      XCTAssertEqual(expected, actual)
    }
  }
}

// MARK: - Operation

extension ConstantTests {
  // MARK: - Negation

  func testNegated() {
    typealias Fixture = (
      operand: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand: Constant(term: 1), expected: Constant(term: -1)),
      (operand: Constant(term: -1), expected: Constant(term: 1)),

      (operand: Constant(term: 0), expected: Constant(term: 0)),
      (operand: Constant(term: -0), expected: Constant(term: 0)),

      (operand: Constant(term: Int.max), expected: Constant(term: -Int.max)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated() as! Constant

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegatedWithOverflow() {
    let operand = Constant(term: Int.min)
    let expected = Expression.PushedError.overflowNegation(operand: String(Int.min))

    XCTAssertThrowsError(try operand.negated()) { error in
      XCTAssertEqual(expected, error as? Expression.PushedError)
    }
  }

  // MARK: - Addition

  func testAddedToConstant() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 1), operand2: Constant(term: 2), expected: Constant(term: 3)),
      (operand1: Constant(term: -1), operand2: Constant(term: 2), expected: Constant(term: 1)),
      (operand1: Constant(term: 1), operand2: Constant(term: -2), expected: Constant(term: -1)),
      (operand1: Constant(term: -1), operand2: Constant(term: -2), expected: Constant(term: -3)),

      (operand1: Constant(term: 2), operand2: Constant(term: 1), expected: Constant(term: 3)),
      (operand1: Constant(term: -2), operand2: Constant(term: 1), expected: Constant(term: -1)),
      (operand1: Constant(term: 2), operand2: Constant(term: -1), expected: Constant(term: 1)),
      (operand1: Constant(term: -2), operand2: Constant(term: -1), expected: Constant(term: -3)),

      (operand1: Constant(term: 1), operand2: Constant(term: 0), expected: Constant(term: 1)),
      (operand1: Constant(term: -1), operand2: Constant(term: 0), expected: Constant(term: -1)),
      (operand1: Constant(term: 1), operand2: Constant(term: -0), expected: Constant(term: 1)),
      (operand1: Constant(term: -1), operand2: Constant(term: -0), expected: Constant(term: -1)),

      (operand1: Constant(term: 0), operand2: Constant(term: 1), expected: Constant(term: 1)),
      (operand1: Constant(term: -0), operand2: Constant(term: 1), expected: Constant(term: 1)),
      (operand1: Constant(term: 0), operand2: Constant(term: -1), expected: Constant(term: -1)),
      (operand1: Constant(term: -0), operand2: Constant(term: -1), expected: Constant(term: -1)),

      (operand1: Constant(term: 0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: 0), operand2: Constant(term: -0), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: -0), expected: Constant(term: 0)),

      (
        operand1: Constant(term: 0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: 0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: -0),
        expected: Constant(term: Int.max)
      ),

      (
        operand1: Constant(term: 0),
        operand2: Constant(term: Int.min),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: Int.min),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: 0),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: -0),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.added(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testAddedToConstantWithOverflow() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: 1),
        expected: .overflowAddition(operandLeft: String(Int.max), operandRight: "1")
      ),
      (
        operand1: Constant(term: 1),
        operand2: Constant(term: Int.max),
        expected: .overflowAddition(operandLeft: "1", operandRight: String(Int.max))
      ),

      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: -1),
        expected: .overflowAddition(operandLeft: String(Int.min), operandRight: "-1")
      ),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: Int.min),
        expected: .overflowAddition(operandLeft: "-1", operandRight: String(Int.min))
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.added(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }

  func testAddedToRoll() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 3)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -1)
      ),
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -3)
      ),

      (
        operand1: Constant(term: 0),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Constant(term: -0),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Constant(term: 0),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -1)
      ),
      (
        operand1: Constant(term: -0),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -1)
      ),

      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.added(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testAddedToRollWithOverflow() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: 1, sides: 1),
        expected: .overflowAddition(operandLeft: String(Int.max), operandRight: "1d1")
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: -1, sides: 1),
        expected: .overflowAddition(operandLeft: String(Int.min), operandRight: "-1d1")
      ),
      (
        operand1: Constant(term: 0),
        operand2: Roll(times: 1, sides: Int.min),
        expected: .overflowNegation(operand: "1d\(Int.min)")
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.added(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }

  // MARK: - Division

  func testDividedByConstant() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 1), operand2: Constant(term: 2), expected: Constant(term: 0)),
      (operand1: Constant(term: -1), operand2: Constant(term: 2), expected: Constant(term: 0)),
      (operand1: Constant(term: 1), operand2: Constant(term: -2), expected: Constant(term: 0)),
      (operand1: Constant(term: -1), operand2: Constant(term: -2), expected: Constant(term: 0)),

      (operand1: Constant(term: 2), operand2: Constant(term: 1), expected: Constant(term: 2)),
      (operand1: Constant(term: -2), operand2: Constant(term: 1), expected: Constant(term: -2)),
      (operand1: Constant(term: 2), operand2: Constant(term: -1), expected: Constant(term: -2)),
      (operand1: Constant(term: -2), operand2: Constant(term: -1), expected: Constant(term: 2)),

      (operand1: Constant(term: 0), operand2: Constant(term: 2), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: 2), expected: Constant(term: 0)),
      (operand1: Constant(term: 0), operand2: Constant(term: -2), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: -2), expected: Constant(term: 0)),

      (operand1: Constant(term: 1), operand2: Constant(term: Int.max), expected: Constant(term: 0)),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: 0)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: 1),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: -1),
        expected: Constant(term: -Int.max)
      ),

      (operand1: Constant(term: 1), operand2: Constant(term: Int.min), expected: Constant(term: 0)),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: Int.min),
        expected: Constant(term: 0)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: 1),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.divided(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testDividedByConstantZero() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: 1),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "1")
      ),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "-1")
      ),
      (
        operand1: Constant(term: 1),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "1")
      ),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "-1")
      ),

      (
        operand1: Constant(term: 0),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "0")
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "0")
      ),
      (
        operand1: Constant(term: 0),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "0")
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "0")
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.divided(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }

  func testDividedByConstantWithOverflow() {
    let operand1 = Constant(term: Int.min)
    let operand2 = Constant(term: -1)
    let expected = Expression.InterpretError.overflowDivision(
      operandLeft: String(Int.min),
      operandRight: "-1"
    )

    XCTAssertThrowsError(try operand1.divided(operand2)) { error in
      XCTAssertEqual(expected, error as? Expression.InterpretError)
    }
  }

  func testDividedByRoll() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 2)
      ),

      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -Int.max)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.divided(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testDividedByRollWithOverflow() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: -1, sides: 1),
        expected: .overflowDivision(operandLeft: String(Int.min), operandRight: "-1d1")
      ),
      (
        operand1: Constant(term: 1),
        operand2: Roll(times: 1, sides: Int.min),
        expected: .overflowNegation(operand: "1d\(Int.min)")
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.divided(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }

  // MARK: - Multiplication

  func testMultipliedByConstant() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 1), operand2: Constant(term: 2), expected: Constant(term: 2)),
      (operand1: Constant(term: -1), operand2: Constant(term: 2), expected: Constant(term: -2)),
      (operand1: Constant(term: 1), operand2: Constant(term: -2), expected: Constant(term: -2)),
      (operand1: Constant(term: -1), operand2: Constant(term: -2), expected: Constant(term: 2)),

      (operand1: Constant(term: 2), operand2: Constant(term: 1), expected: Constant(term: 2)),
      (operand1: Constant(term: -2), operand2: Constant(term: 1), expected: Constant(term: -2)),
      (operand1: Constant(term: 2), operand2: Constant(term: -1), expected: Constant(term: -2)),
      (operand1: Constant(term: -2), operand2: Constant(term: -1), expected: Constant(term: 2)),

      (operand1: Constant(term: 0), operand2: Constant(term: 2), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: 2), expected: Constant(term: 0)),
      (operand1: Constant(term: 0), operand2: Constant(term: -2), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: -2), expected: Constant(term: 0)),

      (operand1: Constant(term: 1), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: -1), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: 1), operand2: Constant(term: -0), expected: Constant(term: 0)),
      (operand1: Constant(term: -1), operand2: Constant(term: -0), expected: Constant(term: 0)),

      (operand1: Constant(term: 0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: 0), operand2: Constant(term: -0), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: -0), expected: Constant(term: 0)),

      (
        operand1: Constant(term: 1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: -Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: 1),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: -1),
        expected: Constant(term: -Int.max)
      ),

      (
        operand1: Constant(term: 1),
        operand2: Constant(term: Int.min),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: 1),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.multiplied(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultipliedByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: 2),
        expected: .overflowMultiplication(operandLeft: String(Int.max), operandRight: "2")
      ),
      (
        operand1: Constant(term: -Int.max),
        operand2: Constant(term: 2),
        expected: .overflowMultiplication(operandLeft: String(-Int.max), operandRight: "2")
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: -2),
        expected: .overflowMultiplication(operandLeft: String(Int.max), operandRight: "-2")
      ),
      (
        operand1: Constant(term: -Int.max),
        operand2: Constant(term: -2),
        expected: .overflowMultiplication(operandLeft: String(-Int.max), operandRight: "-2")
      ),

      (
        operand1: Constant(term: 2),
        operand2: Constant(term: Int.max),
        expected: .overflowMultiplication(operandLeft: "2", operandRight: String(Int.max))
      ),
      (
        operand1: Constant(term: -2),
        operand2: Constant(term: Int.max),
        expected: .overflowMultiplication(operandLeft: "-2", operandRight: String(Int.max))
      ),
      (
        operand1: Constant(term: 2),
        operand2: Constant(term: -Int.max),
        expected: .overflowMultiplication(operandLeft: "2", operandRight: String(-Int.max))
      ),
      (
        operand1: Constant(term: -2),
        operand2: Constant(term: -Int.max),
        expected: .overflowMultiplication(operandLeft: "-2", operandRight: String(-Int.max))
      ),

      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: -1),
        expected: .overflowMultiplication(operandLeft: String(Int.min), operandRight: "-1")
      ),
      (
        operand1: Constant(term: -1),
        operand2: Constant(term: Int.min),
        expected: .overflowMultiplication(operandLeft: "-1", operandRight: String(Int.min))
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.multiplied(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }

  func testMultipliedByRoll() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 2)
      ),

      (
        operand1: Constant(term: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Constant(term: -1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Constant(term: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Constant(term: -1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),

      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -Int.max)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.multiplied(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  // MARK: - Subtraction

  func testSubtractedByConstant() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Constant(term: 1), operand2: Constant(term: 2), expected: Constant(term: -1)),
      (operand1: Constant(term: -1), operand2: Constant(term: 2), expected: Constant(term: -3)),
      (operand1: Constant(term: 1), operand2: Constant(term: -2), expected: Constant(term: 3)),
      (operand1: Constant(term: -1), operand2: Constant(term: -2), expected: Constant(term: 1)),

      (operand1: Constant(term: 2), operand2: Constant(term: 1), expected: Constant(term: 1)),
      (operand1: Constant(term: -2), operand2: Constant(term: 1), expected: Constant(term: -3)),
      (operand1: Constant(term: 2), operand2: Constant(term: -1), expected: Constant(term: 3)),
      (operand1: Constant(term: -2), operand2: Constant(term: -1), expected: Constant(term: -1)),

      (operand1: Constant(term: 0), operand2: Constant(term: 2), expected: Constant(term: -2)),
      (operand1: Constant(term: -0), operand2: Constant(term: 2), expected: Constant(term: -2)),
      (operand1: Constant(term: 0), operand2: Constant(term: -2), expected: Constant(term: 2)),
      (operand1: Constant(term: -0), operand2: Constant(term: -2), expected: Constant(term: 2)),

      (operand1: Constant(term: 1), operand2: Constant(term: 0), expected: Constant(term: 1)),
      (operand1: Constant(term: -1), operand2: Constant(term: 0), expected: Constant(term: -1)),
      (operand1: Constant(term: 1), operand2: Constant(term: -0), expected: Constant(term: 1)),
      (operand1: Constant(term: -1), operand2: Constant(term: -0), expected: Constant(term: -1)),

      (operand1: Constant(term: 0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: 0), expected: Constant(term: 0)),
      (operand1: Constant(term: 0), operand2: Constant(term: -0), expected: Constant(term: 0)),
      (operand1: Constant(term: -0), operand2: Constant(term: -0), expected: Constant(term: 0)),

      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: 0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: -0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: 0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: -Int.max)
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: -Int.max)
      ),

      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: 0),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: -0),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: 0),
        operand2: Constant(term: Int.min + 1),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: Int.min + 1),
        expected: Constant(term: Int.max)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.subtracted(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractedByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Constant,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: Int.max),
        operand2: Constant(term: -1),
        expected: .overflowSubtraction(operandLeft: String(Int.max), operandRight: "-1")
      ),
      (
        operand1: Constant(term: -2),
        operand2: Constant(term: Int.max),
        expected: .overflowSubtraction(operandLeft: "-2", operandRight: String(Int.max))
      ),

      (
        operand1: Constant(term: Int.min),
        operand2: Constant(term: 1),
        expected: .overflowSubtraction(operandLeft: String(Int.min), operandRight: "1")
      ),
      (
        operand1: Constant(term: 0),
        operand2: Constant(term: Int.min),
        expected: .overflowSubtraction(operandLeft: "0", operandRight: String(Int.min))
      ),
      (
        operand1: Constant(term: -0),
        operand2: Constant(term: Int.min),
        expected: .overflowSubtraction(operandLeft: "0", operandRight: String(Int.min))
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.subtracted(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }

  func testSubtractedByRoll() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -3)
      ),
      (
        operand1: Constant(term: 2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 3)
      ),
      (
        operand1: Constant(term: -2),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -1)
      ),

      (
        operand1: Constant(term: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Constant(term: -1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: -1)
      ),
      (
        operand1: Constant(term: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Constant(term: -1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: -1)
      ),

      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.subtracted(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractedByRollWithOverflow() {
    typealias Fixture = (
      operand1: Constant,
      operand2: Roll,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Constant(term: Int.max),
        operand2: Roll(times: -1, sides: 1),
        expected: .overflowSubtraction(operandLeft: String(Int.max), operandRight: "-1d1")
      ),
      (
        operand1: Constant(term: Int.min),
        operand2: Roll(times: 1, sides: 1),
        expected: .overflowSubtraction(operandLeft: String(Int.min), operandRight: "1d1")
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.subtracted(operand2)) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }
}
