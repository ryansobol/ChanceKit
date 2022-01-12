@testable import ChanceKit
import XCTest

final class RollNegativeSidesTests: XCTestCase {}

// MARK: - Tokenable

extension RollNegativeSidesTests {
  func testDescription() {
    typealias Fixture = (
      token: RollNegativeSides,
      expected: String
    )

    let fixtures: [Fixture] = [
      (token: RollNegativeSides(times: 0), expected: "0d-"),
      (token: RollNegativeSides(times: 1), expected: "1d-"),
      (token: RollNegativeSides(times: 9), expected: "9d-"),
      (token: RollNegativeSides(times: Int.max), expected: "\(Int.max)d-"),

      (token: RollNegativeSides(times: -0), expected: "0d-"),
      (token: RollNegativeSides(times: -1), expected: "-1d-"),
      (token: RollNegativeSides(times: -9), expected: "-9d-"),
      (token: RollNegativeSides(times: Int.min), expected: "\(Int.min)d-"),
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

extension RollNegativeSidesTests {
  func testInitWithValidRawLexeme() {
    for fixture in lexemeRollNegativeSidesFixtures {
      let rawLexeme = fixture.lexeme
      let expected = fixture.token
      let actual = RollNegativeSides(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidRawLexeme() {
    for fixture in invalidLexemeFixtures {
      XCTAssertNil(RollNegativeSides(rawLexeme: fixture.lexeme))
    }

    for fixture in constantFixtures {
      XCTAssertNil(RollNegativeSides(rawLexeme: fixture.lexeme))
    }

    for fixture in rollFixtures {
      XCTAssertNil(RollNegativeSides(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollPositiveSidesFixtures {
      XCTAssertNil(RollNegativeSides(rawLexeme: fixture.lexeme))
    }

    for `operator` in Operator.allCases {
      XCTAssertNil(RollNegativeSides(rawLexeme: `operator`.rawValue))
    }

    for parenthesis in Parenthesis.allCases {
      XCTAssertNil(RollNegativeSides(rawLexeme: parenthesis.rawValue))
    }
  }
}

// MARK: - Inclusion

extension RollNegativeSidesTests {
  func testCombinedWithConstant() {
    typealias Fixture = (
      operand1: RollNegativeSides,
      operand2: Constant,
      expected: Roll
    )

    let fixtures: [Fixture] = [
      (
        operand1: RollNegativeSides(times: 0),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: -0)
      ),
      (
        operand1: RollNegativeSides(times: 1),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: -1)
      ),
      (
        operand1: RollNegativeSides(times: 9),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: -9)
      ),
      (
        operand1: RollNegativeSides(times: 1),
        operand2: Constant(term: Int.max),
        expected: Roll(times: 1, sides: -Int.max)
      ),

      (
        operand1: RollNegativeSides(times: -0),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: -0)
      ),
      (
        operand1: RollNegativeSides(times: -1),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: -1)
      ),
      (
        operand1: RollNegativeSides(times: -9),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: -9)
      ),
      (
        operand1: RollNegativeSides(times: -1),
        operand2: Constant(term: Int.max),
        expected: Roll(times: -1, sides: -Int.max)
      ),

      (
        operand1: RollNegativeSides(times: 0),
        operand2: Constant(term: -0),
        expected: Roll(times: 0, sides: -0)
      ),
      (
        operand1: RollNegativeSides(times: 1),
        operand2: Constant(term: -1),
        expected: Roll(times: 1, sides: 1)
      ),
      (
        operand1: RollNegativeSides(times: 9),
        operand2: Constant(term: -9),
        expected: Roll(times: 9, sides: 9)
      ),
      (
        operand1: RollNegativeSides(times: 1),
        operand2: Constant(term: -Int.max),
        expected: Roll(times: 1, sides: Int.max)
      ),
      (
        operand1: RollNegativeSides(times: -0),
        operand2: Constant(term: -0),
        expected: Roll(times: -0, sides: -0)
      ),
      (
        operand1: RollNegativeSides(times: -1),
        operand2: Constant(term: -1),
        expected: Roll(times: -1, sides: 1)
      ),
      (
        operand1: RollNegativeSides(times: -9),
        operand2: Constant(term: -9),
        expected: Roll(times: -9, sides: 9)
      ),
      (
        operand1: RollNegativeSides(times: -1),
        operand2: Constant(term: -Int.max),
        expected: Roll(times: -1, sides: Int.max)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2) as! Roll

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedWithInvalidConstant() {
    let operand1 = RollNegativeSides(times: 1)
    let operand2 = Constant(term: Int.min)
    let expected = Expression.PushedError.invalidCombination(
      operandLeft: String(describing: operand1),
      operandRight: String(describing: operand2)
    )

    XCTAssertThrowsError(try operand1.combined(operand2)) { error in
      XCTAssertEqual(expected, error as? Expression.PushedError)
    }
  }

  func testCombinedWithRoll() {
    typealias Fixture = (
      operand1: RollNegativeSides,
      operand2: Roll
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: RollNegativeSides(times: 0), operand2: Roll(times: 0, sides: -0)),
      (operand1: RollNegativeSides(times: 0), operand2: Roll(times: 0, sides: -1)),
      (operand1: RollNegativeSides(times: 0), operand2: Roll(times: 0, sides: -21)),

      (operand1: RollNegativeSides(times: 1), operand2: Roll(times: 1, sides: -0)),
      (operand1: RollNegativeSides(times: 1), operand2: Roll(times: 1, sides: -2)),
      (operand1: RollNegativeSides(times: 1), operand2: Roll(times: 1, sides: -32)),

      (operand1: RollNegativeSides(times: 9), operand2: Roll(times: 9, sides: -0)),
      (operand1: RollNegativeSides(times: 9), operand2: Roll(times: 9, sides: -8)),
      (operand1: RollNegativeSides(times: 9), operand2: Roll(times: 9, sides: -78)),

      (operand1: RollNegativeSides(times: Int.max), operand2: Roll(times: 0, sides: -0)),
      (operand1: RollNegativeSides(times: Int.max), operand2: Roll(times: 0, sides: -1)),
      (operand1: RollNegativeSides(times: Int.max), operand2: Roll(times: 0, sides: Int.min)),

      (operand1: RollNegativeSides(times: -0), operand2: Roll(times: -0, sides: -0)),
      (operand1: RollNegativeSides(times: -0), operand2: Roll(times: -0, sides: -2)),
      (operand1: RollNegativeSides(times: -0), operand2: Roll(times: -0, sides: -32)),

      (operand1: RollNegativeSides(times: -1), operand2: Roll(times: -1, sides: -0)),
      (operand1: RollNegativeSides(times: -1), operand2: Roll(times: -1, sides: -2)),
      (operand1: RollNegativeSides(times: -1), operand2: Roll(times: -1, sides: -32)),

      (operand1: RollNegativeSides(times: -9), operand2: Roll(times: -9, sides: -0)),
      (operand1: RollNegativeSides(times: -9), operand2: Roll(times: -9, sides: -8)),
      (operand1: RollNegativeSides(times: -9), operand2: Roll(times: -9, sides: -78)),

      (operand1: RollNegativeSides(times: Int.min), operand2: Roll(times: -0, sides: -0)),
      (operand1: RollNegativeSides(times: Int.min), operand2: Roll(times: -0, sides: -1)),
      (operand1: RollNegativeSides(times: Int.min), operand2: Roll(times: -0, sides: Int.min)),

      // Mis-matching sides signage
      (operand1: RollNegativeSides(times: 1), operand2: Roll(times: 1, sides: 1)),
      (operand1: RollNegativeSides(times: 1), operand2: Roll(times: 1, sides: Int.max)),

      // Overflowing integer addition
      (operand1: RollNegativeSides(times: 1), operand2: Roll(times: Int.max, sides: -1)),
      (operand1: RollNegativeSides(times: -1), operand2: Roll(times: Int.min, sides: -1)),
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
      operand1: RollNegativeSides,
      operand2: RollNegativeSides,
      expected: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      (
        operand1: RollNegativeSides(times: 0),
        operand2: RollNegativeSides(times: 0),
        expected: RollNegativeSides(times: 0)
      ),

      (
        operand1: RollNegativeSides(times: 1),
        operand2: RollNegativeSides(times: 1),
        expected: RollNegativeSides(times: 2)
      ),

      (
        operand1: RollNegativeSides(times: 9),
        operand2: RollNegativeSides(times: 9),
        expected: RollNegativeSides(times: 18)
      ),

      (
        operand1: RollNegativeSides(times: Int.max),
        operand2: RollNegativeSides(times: 0),
        expected: RollNegativeSides(times: Int.max)
      ),

      (
        operand1: RollNegativeSides(times: -0),
        operand2: RollNegativeSides(times: -0),
        expected: RollNegativeSides(times: -0)
      ),

      (
        operand1: RollNegativeSides(times: -1),
        operand2: RollNegativeSides(times: -1),
        expected: RollNegativeSides(times: -2)
      ),

      (
        operand1: RollNegativeSides(times: -9),
        operand2: RollNegativeSides(times: -9),
        expected: RollNegativeSides(times: -18)
      ),

      (
        operand1: RollNegativeSides(times: Int.min),
        operand2: RollNegativeSides(times: -0),
        expected: RollNegativeSides(times: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2) as! RollNegativeSides

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedWithInvalidRollNegativeSides() {
    typealias Fixture = (
      operand1: RollNegativeSides,
      operand2: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      // Overflowing integer addition
      (operand1: RollNegativeSides(times: Int.max), operand2: RollNegativeSides(times: 1)),
      (operand1: RollNegativeSides(times: 1), operand2: RollNegativeSides(times: Int.max)),
      (operand1: RollNegativeSides(times: Int.min), operand2: RollNegativeSides(times: -1)),
      (operand1: RollNegativeSides(times: -1), operand2: RollNegativeSides(times: Int.min)),
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
      operand1: RollNegativeSides,
      operand2: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      // Mis-matching sides signage
      (operand1: RollNegativeSides(times: 1), operand2: RollPositiveSides(times: 1)),
      (operand1: RollNegativeSides(times: -1), operand2: RollPositiveSides(times: -1)),
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

extension RollNegativeSidesTests {
  func testDroppedToRollPositiveSides() {
    typealias Fixture = (
      operand: RollNegativeSides,
      expected: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      (operand: RollNegativeSides(times: 0), expected: RollPositiveSides(times: 0)),
      (operand: RollNegativeSides(times: 1), expected: RollPositiveSides(times: 1)),
      (operand: RollNegativeSides(times: 9), expected: RollPositiveSides(times: 9)),

      (operand: RollNegativeSides(times: Int.max), expected: RollPositiveSides(times: Int.max)),

      (operand: RollNegativeSides(times: -0), expected: RollPositiveSides(times: -0)),
      (operand: RollNegativeSides(times: -1), expected: RollPositiveSides(times: -1)),
      (operand: RollNegativeSides(times: -9), expected: RollPositiveSides(times: -9)),

      (operand: RollNegativeSides(times: Int.min), expected: RollPositiveSides(times: Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped() as! RollPositiveSides

      XCTAssertEqual(expected, actual, "operand: \(operand)")
    }
  }
}

// MARK: - Evaluation

extension RollNegativeSidesTests {
  func testValue() {
    typealias Fixture = (
      operand: RollNegativeSides,
      expected: Expression.InterpretError
    )

    let fixtures: [Fixture] = [
      (operand: RollNegativeSides(times: 0), expected: .missingSides(operand: "0d-")),
      (operand: RollNegativeSides(times: 1), expected: .missingSides(operand: "1d-")),
      (operand: RollNegativeSides(times: 9), expected: .missingSides(operand: "9d-")),
      (
        operand: RollNegativeSides(times: Int.max),
        expected: .missingSides(operand: "\(Int.max)d-")
      ),

      (operand: RollNegativeSides(times: -0), expected: .missingSides(operand: "0d-")),
      (operand: RollNegativeSides(times: -1), expected: .missingSides(operand: "-1d-")),
      (operand: RollNegativeSides(times: -9), expected: .missingSides(operand: "-9d-")),
      (
        operand: RollNegativeSides(times: Int.min),
        expected: .missingSides(operand: "\(Int.min)d-")
      ),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError)
      }
    }
  }
}

// MARK: - Operation

extension RollNegativeSidesTests {
  // MARK: - Negation

  func testNegated() {
    typealias Fixture = (
      operand: RollNegativeSides,
      expected: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      (operand: RollNegativeSides(times: 1), expected: RollPositiveSides(times: 1)),
      (operand: RollNegativeSides(times: -1), expected: RollPositiveSides(times: -1)),

      (operand: RollNegativeSides(times: 0), expected: RollPositiveSides(times: 0)),
      (operand: RollNegativeSides(times: -0), expected: RollPositiveSides(times: 0)),

      (operand: RollNegativeSides(times: Int.max), expected: RollPositiveSides(times: Int.max)),
      (operand: RollNegativeSides(times: Int.min), expected: RollPositiveSides(times: Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated() as! RollPositiveSides

      XCTAssertEqual(expected, actual)
    }
  }
}
