@testable import ChanceKit
import XCTest

class RollPositiveSidesTests: XCTestCase {}

// MARK: - Tokenable

extension RollPositiveSidesTests {
  func testDescription() {
    typealias Fixture = (
      token: RollPositiveSides,
      expected: String
    )

    let fixtures: [Fixture] = [
      (token: RollPositiveSides(times: 0), expected: "0d"),
      (token: RollPositiveSides(times: 1), expected: "1d"),
      (token: RollPositiveSides(times: 9), expected: "9d"),
      (token: RollPositiveSides(times: Int.max), expected: "\(Int.max)d"),

      (token: RollPositiveSides(times: -0), expected: "0d"),
      (token: RollPositiveSides(times: -1), expected: "-1d"),
      (token: RollPositiveSides(times: -9), expected: "-9d"),
      (token: RollPositiveSides(times: Int.min), expected: "\(Int.min)d"),
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

extension RollPositiveSidesTests {
  func testInitWithValidRawLexeme() {
    for fixture in lexemeRollPositiveSidesFixtures {
      let rawLexeme = fixture.lexeme
      let expected = fixture.token
      let actual = RollPositiveSides(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidRawLexeme() {
    for fixture in invalidFixtures {
      XCTAssertNil(RollPositiveSides(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeConstantFixtures {
      XCTAssertNil(RollPositiveSides(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollFixtures {
      XCTAssertNil(RollPositiveSides(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollNegativeSidesFixtures {
      XCTAssertNil(RollPositiveSides(rawLexeme: fixture.lexeme))
    }

    for `operator` in Operator.allCases {
      XCTAssertNil(RollPositiveSides(rawLexeme: `operator`.rawValue))
    }

    for parenthesis in Parenthesis.allCases {
      XCTAssertNil(RollPositiveSides(rawLexeme: parenthesis.rawValue))
    }
  }
}

// MARK: - Inclusion

extension RollPositiveSidesTests {
  func testCombinedRollPositiveSidesWithConstant() {
    typealias Fixture = (
      operand1: RollPositiveSides,
      operand2: Constant,
      expected: Roll
    )

    let fixtures: [Fixture] = [
      (
        operand1: RollPositiveSides(times: 0),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: RollPositiveSides(times: 1),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: 1)
      ),
      (
        operand1: RollPositiveSides(times: 9),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: 9)
      ),
      (
        operand1: RollPositiveSides(times: 1),
        operand2: Constant(term: Int.max),
        expected: Roll(times: 1, sides: Int.max)
      ),

      (
        operand1: RollPositiveSides(times: -0),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: RollPositiveSides(times: -1),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: 1)
      ),
      (
        operand1: RollPositiveSides(times: -9),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: 9)
      ),
      (
        operand1: RollPositiveSides(times: -1),
        operand2: Constant(term: Int.max),
        expected: Roll(times: -1, sides: Int.max)
      ),

      (
        operand1: RollPositiveSides(times: 0),
        operand2: Constant(term: -0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: RollPositiveSides(times: 1),
        operand2: Constant(term: -1),
        expected: Roll(times: 1, sides: -1)
      ),
      (
        operand1: RollPositiveSides(times: 9),
        operand2: Constant(term: -9),
        expected: Roll(times: 9, sides: -9)
      ),
      (
        operand1: RollPositiveSides(times: 1),
        operand2: Constant(term: Int.min),
        expected: Roll(times: 1, sides: Int.min)
      ),

      (
        operand1: RollPositiveSides(times: -0),
        operand2: Constant(term: -0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: RollPositiveSides(times: -1),
        operand2: Constant(term: -1),
        expected: Roll(times: -1, sides: -1)
      ),
      (
        operand1: RollPositiveSides(times: -9),
        operand2: Constant(term: -9),
        expected: Roll(times: -9, sides: -9)
      ),
      (
        operand1: RollPositiveSides(times: -1),
        operand2: Constant(term: Int.min),
        expected: Roll(times: -1, sides: Int.min)
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

  func testCombinedRollPositiveSidesWithRoll() {
    typealias Fixture = (
      operand1: RollPositiveSides,
      operand2: Roll
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: RollPositiveSides(times: 0), operand2: Roll(times: 0, sides: 0)),
      (operand1: RollPositiveSides(times: 0), operand2: Roll(times: 0, sides: 1)),
      (operand1: RollPositiveSides(times: 0), operand2: Roll(times: 0, sides: 21)),

      (operand1: RollPositiveSides(times: 1), operand2: Roll(times: 1, sides: 0)),
      (operand1: RollPositiveSides(times: 1), operand2: Roll(times: 1, sides: 2)),
      (operand1: RollPositiveSides(times: 1), operand2: Roll(times: 1, sides: 32)),

      (operand1: RollPositiveSides(times: 9), operand2: Roll(times: 9, sides: 0)),
      (operand1: RollPositiveSides(times: 9), operand2: Roll(times: 9, sides: 8)),
      (operand1: RollPositiveSides(times: 9), operand2: Roll(times: 9, sides: 78)),

      (operand1: RollPositiveSides(times: Int.max), operand2: Roll(times: 0, sides: 0)),
      (operand1: RollPositiveSides(times: Int.max), operand2: Roll(times: 0, sides: 1)),
      (operand1: RollPositiveSides(times: Int.max), operand2: Roll(times: 0, sides: Int.max)),

      (operand1: RollPositiveSides(times: -0), operand2: Roll(times: -0, sides: 0)),
      (operand1: RollPositiveSides(times: -0), operand2: Roll(times: -0, sides: 2)),
      (operand1: RollPositiveSides(times: -0), operand2: Roll(times: -0, sides: 32)),

      (operand1: RollPositiveSides(times: -1), operand2: Roll(times: -1, sides: 0)),
      (operand1: RollPositiveSides(times: -1), operand2: Roll(times: -1, sides: 2)),
      (operand1: RollPositiveSides(times: -1), operand2: Roll(times: -1, sides: 32)),

      (operand1: RollPositiveSides(times: -9), operand2: Roll(times: -9, sides: 0)),
      (operand1: RollPositiveSides(times: -9), operand2: Roll(times: -9, sides: 8)),
      (operand1: RollPositiveSides(times: -9), operand2: Roll(times: -9, sides: 78)),

      (operand1: RollPositiveSides(times: Int.min), operand2: Roll(times: -0, sides: 0)),
      (operand1: RollPositiveSides(times: Int.min), operand2: Roll(times: -0, sides: 1)),
      (operand1: RollPositiveSides(times: Int.min), operand2: Roll(times: -0, sides: Int.max)),

      // Mis-matching sides signage
      (operand1: RollPositiveSides(times: 1), operand2: Roll(times: 1, sides: -1)),
      (operand1: RollPositiveSides(times: 1), operand2: Roll(times: 1, sides: Int.min)),

      // Overflowing integer addition
      (operand1: RollPositiveSides(times: 1), operand2: Roll(times: Int.max, sides: 1)),
      (operand1: RollPositiveSides(times: -1), operand2: Roll(times: Int.min, sides: 1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollPositiveSidesWithRollPositiveSides() {
    typealias Fixture = (
      operand1: RollPositiveSides,
      operand2: RollPositiveSides,
      expected: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      (
        operand1: RollPositiveSides(times: 0),
        operand2: RollPositiveSides(times: 0),
        expected: RollPositiveSides(times: 0)
      ),

      (
        operand1: RollPositiveSides(times: 1),
        operand2: RollPositiveSides(times: 1),
        expected: RollPositiveSides(times: 2)
      ),

      (
        operand1: RollPositiveSides(times: 9),
        operand2: RollPositiveSides(times: 9),
        expected: RollPositiveSides(times: 18)
      ),

      (
        operand1: RollPositiveSides(times: Int.max),
        operand2: RollPositiveSides(times: 0),
        expected: RollPositiveSides(times: Int.max)
      ),

      (
        operand1: RollPositiveSides(times: -0),
        operand2: RollPositiveSides(times: -0),
        expected: RollPositiveSides(times: -0)
      ),

      (
        operand1: RollPositiveSides(times: -1),
        operand2: RollPositiveSides(times: -1),
        expected: RollPositiveSides(times: -2)
      ),

      (
        operand1: RollPositiveSides(times: -9),
        operand2: RollPositiveSides(times: -9),
        expected: RollPositiveSides(times: -18)
      ),

      (
        operand1: RollPositiveSides(times: Int.min),
        operand2: RollPositiveSides(times: -0),
        expected: RollPositiveSides(times: Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2) as! RollPositiveSides

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollPositiveSidesWithInvalidRollPositiveSides() {
    typealias Fixture = (
      operand1: RollPositiveSides,
      operand2: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      // Overflowing integer addition
      (operand1: RollPositiveSides(times: Int.max), operand2: RollPositiveSides(times: 1)),
      (operand1: RollPositiveSides(times: 1), operand2: RollPositiveSides(times: Int.max)),
      (operand1: RollPositiveSides(times: Int.min), operand2: RollPositiveSides(times: -1)),
      (operand1: RollPositiveSides(times: -1), operand2: RollPositiveSides(times: Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollPositiveSidesWithRollNegativeSides() {
    typealias Fixture = (
      operand1: RollPositiveSides,
      operand2: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      // Mis-matching sides signage
      (operand1: RollPositiveSides(times: 1), operand2: RollNegativeSides(times: 1)),
      (operand1: RollPositiveSides(times: -1), operand2: RollNegativeSides(times: -1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombination(
        operandLeft: String(describing: operand1),
        operandRight: String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Exclusion

extension RollPositiveSidesTests {
  func testDroppedFromToConstant() {
    typealias Fixture = (
      operand: RollPositiveSides,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (operand: RollPositiveSides(times: 0), expected: Constant(term: 0)),
      (operand: RollPositiveSides(times: 1), expected: Constant(term: 1)),
      (operand: RollPositiveSides(times: 9), expected: Constant(term: 9)),

      (operand: RollPositiveSides(times: Int.max), expected: Constant(term: Int.max)),

      (operand: RollPositiveSides(times: -0), expected: Constant(term: -0)),
      (operand: RollPositiveSides(times: -1), expected: Constant(term: -1)),
      (operand: RollPositiveSides(times: -9), expected: Constant(term: -9)),

      (operand: RollPositiveSides(times: Int.min), expected: Constant(term: Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped() as! Constant

      XCTAssertEqual(expected, actual, "operand: \(operand)")
    }
  }
}

// MARK: - Evaluation

extension RollPositiveSidesTests {
  func testValue() {
    typealias Fixture = (
      operand: RollPositiveSides,
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      (operand: RollPositiveSides(times: 0), expected: .missingRollSides(operand: "0d")),
      (operand: RollPositiveSides(times: 1), expected: .missingRollSides(operand: "1d")),
      (operand: RollPositiveSides(times: 9), expected: .missingRollSides(operand: "9d")),
      (
        operand: RollPositiveSides(times: Int.max),
        expected: .missingRollSides(operand: "\(Int.max)d")
      ),

      (operand: RollPositiveSides(times: -0), expected: .missingRollSides(operand: "0d")),
      (operand: RollPositiveSides(times: -1), expected: .missingRollSides(operand: "-1d")),
      (operand: RollPositiveSides(times: -9), expected: .missingRollSides(operand: "-9d")),
      (
        operand: RollPositiveSides(times: Int.min),
        expected: .missingRollSides(operand: "\(Int.min)d")
      ),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Operation

extension RollPositiveSidesTests {
  // MARK: - Negation

  func testNegated() {
    typealias Fixture = (
      operand: RollPositiveSides,
      expected: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      (operand: RollPositiveSides(times: 1), expected: RollNegativeSides(times: 1)),
      (operand: RollPositiveSides(times: -1), expected: RollNegativeSides(times: -1)),

      (operand: RollPositiveSides(times: 0), expected: RollNegativeSides(times: 0)),
      (operand: RollPositiveSides(times: -0), expected: RollNegativeSides(times: 0)),

      (operand: RollPositiveSides(times: Int.max), expected: RollNegativeSides(times: Int.max)),
      (operand: RollPositiveSides(times: Int.min), expected: RollNegativeSides(times: Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated() as! RollNegativeSides

      XCTAssertEqual(expected, actual)
    }
  }
}
