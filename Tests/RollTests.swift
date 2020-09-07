@testable import ChanceKit
import XCTest

class RollTests: XCTestCase {}

// MARK: - Tokenable

extension RollTests {
  func testDescription() {
    typealias Fixture = (
      token: Roll,
      expected: String
    )

    let fixtures: [Fixture] = [
      (token: Roll(times: 0, sides: 0), expected: "0d0"),
      (token: Roll(times: 1, sides: 1), expected: "1d1"),
      (token: Roll(times: 9, sides: 9), expected: "9d9"),
      (token: Roll(times: Int.max, sides: Int.max), expected: "\(Int.max)d\(Int.max)"),

      (token: Roll(times: 0, sides: -0), expected: "0d0"),
      (token: Roll(times: 1, sides: -1), expected: "1d-1"),
      (token: Roll(times: 9, sides: -9), expected: "9d-9"),
      (token: Roll(times: Int.max, sides: Int.min), expected: "\(Int.max)d\(Int.min)"),

      (token: Roll(times: -0, sides: 0), expected: "0d0"),
      (token: Roll(times: -1, sides: 1), expected: "-1d1"),
      (token: Roll(times: -9, sides: 9), expected: "-9d9"),
      (token: Roll(times: Int.min, sides: Int.max), expected: "\(Int.min)d\(Int.max)"),

      (token: Roll(times: -0, sides: -0), expected: "0d0"),
      (token: Roll(times: -1, sides: -1), expected: "-1d-1"),
      (token: Roll(times: -9, sides: -9), expected: "-9d-9"),
      (token: Roll(times: Int.min, sides: Int.min), expected: "\(Int.min)d\(Int.min)"),
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

extension RollTests {
  func testInitWithValidRawLexeme() {
    for fixture in lexemeRollFixtures {
      let rawLexeme = fixture.lexeme
      let expected = fixture.token
      let actual = Roll(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidRawLexeme() {
    for fixture in invalidFixtures {
      XCTAssertNil(Roll(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeConstantFixtures {
      XCTAssertNil(Roll(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollNegativeSidesFixtures {
      XCTAssertNil(Roll(rawLexeme: fixture.lexeme))
    }

    for fixture in lexemeRollPositiveSidesFixtures {
      XCTAssertNil(Roll(rawLexeme: fixture.lexeme))
    }

    for `operator` in Operator.allCases {
      XCTAssertNil(Roll(rawLexeme: `operator`.rawValue))
    }

    for parenthesis in Parenthesis.allCases {
      XCTAssertNil(Roll(rawLexeme: parenthesis.rawValue))
    }
  }
}

// MARK: - Inclusion

extension RollTests {
  func testCombinedWithConstant() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Constant,
      expected: Roll
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 1),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: 10)
      ),
      (
        operand1: Roll(times: 0, sides: 21),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: 210)
      ),

      (
        operand1: Roll(times: 1, sides: 0),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: 1)
      ),
      (
        operand1: Roll(times: 1, sides: 2),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: 21)
      ),
      (
        operand1: Roll(times: 1, sides: 32),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: 321)
      ),

      (
        operand1: Roll(times: 9, sides: 0),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: 9)
      ),
      (
        operand1: Roll(times: 9, sides: 8),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: 89)
      ),
      (
        operand1: Roll(times: 9, sides: 78),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: 789)
      ),

      (
        operand1: Roll(times: 1, sides: 0),
        operand2: Constant(term: Int.max),
        expected: Roll(times: 1, sides: Int.max)
      ),
      (
        operand1: Roll(times: 1, sides: 9),
        operand2: Constant(term: 223372036854775807),
        expected: Roll(times: 1, sides: Int.max)
      ),
      (
        operand1: Roll(times: 1, sides: 922337203685477580),
        operand2: Constant(term: 7),
        expected: Roll(times: 1, sides: Int.max)
      ),

      (
        operand1: Roll(times: 0, sides: -0),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: Roll(times: 0, sides: -1),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: -10)
      ),
      (
        operand1: Roll(times: 0, sides: -21),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: -210)
      ),

      (
        operand1: Roll(times: 1, sides: -0),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: 1)
      ),
      (
        operand1: Roll(times: 1, sides: -2),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: -21)
      ),
      (
        operand1: Roll(times: 1, sides: -32),
        operand2: Constant(term: 1),
        expected: Roll(times: 1, sides: -321)
      ),

      (
        operand1: Roll(times: 9, sides: -0),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: 9)
      ),
      (
        operand1: Roll(times: 9, sides: -8),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: -89)
      ),
      (
        operand1: Roll(times: 9, sides: -78),
        operand2: Constant(term: 9),
        expected: Roll(times: 9, sides: -789)
      ),

      (
        operand1: Roll(times: 1, sides: -0),
        operand2: Constant(term: Int.max),
        expected: Roll(times: 1, sides: Int.max)
      ),
      (
        operand1: Roll(times: 1, sides: -9),
        operand2: Constant(term: 223372036854775808),
        expected: Roll(times: 1, sides: Int.min)
      ),
      (
        operand1: Roll(times: 1, sides: -922337203685477580),
        operand2: Constant(term: 8),
        expected: Roll(times: 1, sides: Int.min)
      ),

      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 1),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: 10)
      ),
      (
        operand1: Roll(times: -0, sides: 21),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: 210)
      ),

      (
        operand1: Roll(times: -1, sides: 0),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 2),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: 21)
      ),
      (
        operand1: Roll(times: -1, sides: 32),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: 321)
      ),

      (
        operand1: Roll(times: -9, sides: 0),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: 9)
      ),
      (
        operand1: Roll(times: -9, sides: 8),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: 89)
      ),
      (
        operand1: Roll(times: -9, sides: 78),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: 789)
      ),

      (
        operand1: Roll(times: -1, sides: 0),
        operand2: Constant(term: Int.max),
        expected: Roll(times: -1, sides: Int.max)
      ),
      (
        operand1: Roll(times: -1, sides: 9),
        operand2: Constant(term: 223372036854775807),
        expected: Roll(times: -1, sides: Int.max)
      ),
      (
        operand1: Roll(times: -1, sides: 922337203685477580),
        operand2: Constant(term: 7),
        expected: Roll(times: -1, sides: Int.max)
      ),

      (
        operand1: Roll(times: -0, sides: -0),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: Roll(times: -0, sides: -1),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: -10)
      ),
      (
        operand1: Roll(times: -0, sides: -21),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: -210)
      ),

      (
        operand1: Roll(times: -1, sides: -0),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: 1)
      ),
      (
        operand1: Roll(times: -1, sides: -2),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: -21)
      ),
      (
        operand1: Roll(times: -1, sides: -32),
        operand2: Constant(term: 1),
        expected: Roll(times: -1, sides: -321)
      ),

      (
        operand1: Roll(times: -9, sides: -0),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: 9)
      ),
      (
        operand1: Roll(times: -9, sides: -8),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: -89)
      ),
      (
        operand1: Roll(times: -9, sides: -78),
        operand2: Constant(term: 9),
        expected: Roll(times: -9, sides: -789)
      ),

      (
        operand1: Roll(times: -1, sides: -0),
        operand2: Constant(term: Int.max),
        expected: Roll(times: -1, sides: Int.max)
      ),
      (
        operand1: Roll(times: -1, sides: -9),
        operand2: Constant(term: 223372036854775808),
        expected: Roll(times: -1, sides: Int.min)
      ),
      (
        operand1: Roll(times: -1, sides: -922337203685477580),
        operand2: Constant(term: 8),
        expected: Roll(times: -1, sides: Int.min)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 1),
        operand2: Constant(term: -0),
        expected: Roll(times: 0, sides: 10)
      ),
      (
        operand1: Roll(times: 0, sides: 21),
        operand2: Constant(term: -0),
        expected: Roll(times: 0, sides: 210)
      ),

      (
        operand1: Roll(times: 0, sides: -0),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: Roll(times: 0, sides: -1),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: -10)
      ),
      (
        operand1: Roll(times: 0, sides: -21),
        operand2: Constant(term: 0),
        expected: Roll(times: 0, sides: -210)
      ),

      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 1),
        operand2: Constant(term: -0),
        expected: Roll(times: -0, sides: 10)
      ),
      (
        operand1: Roll(times: -0, sides: 21),
        operand2: Constant(term: -0),
        expected: Roll(times: -0, sides: 210)
      ),

      (
        operand1: Roll(times: -0, sides: -0),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: Roll(times: -0, sides: -1),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: -10)
      ),
      (
        operand1: Roll(times: -0, sides: -21),
        operand2: Constant(term: 0),
        expected: Roll(times: -0, sides: -210)
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
    typealias Fixture = (
      operand1: Roll,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      // Invalid format
      (operand1: Roll(times: 1, sides: 0), operand2: Constant(term: -1)),
      (operand1: Roll(times: 1, sides: 2), operand2: Constant(term: -1)),
      (operand1: Roll(times: 1, sides: 32), operand2: Constant(term: -1)),

      (operand1: Roll(times: 9, sides: 0), operand2: Constant(term: -9)),
      (operand1: Roll(times: 9, sides: 8), operand2: Constant(term: -9)),
      (operand1: Roll(times: 9, sides: 78), operand2: Constant(term: -9)),

      (operand1: Roll(times: 1, sides: 0), operand2: Constant(term: Int.min)),
      (operand1: Roll(times: 1, sides: 9), operand2: Constant(term: -223372036854775808)),
      (operand1: Roll(times: 1, sides: 922337203685477580), operand2: Constant(term: -8)),

      (operand1: Roll(times: 1, sides: -0), operand2: Constant(term: -1)),
      (operand1: Roll(times: 1, sides: -2), operand2: Constant(term: -1)),
      (operand1: Roll(times: 1, sides: -32), operand2: Constant(term: -1)),

      (operand1: Roll(times: 9, sides: -0), operand2: Constant(term: -9)),
      (operand1: Roll(times: 9, sides: -8), operand2: Constant(term: -9)),
      (operand1: Roll(times: 9, sides: -78), operand2: Constant(term: -9)),

      (operand1: Roll(times: 1, sides: -0), operand2: Constant(term: Int.min)),
      (operand1: Roll(times: 1, sides: -9), operand2: Constant(term: -223372036854775808)),
      (operand1: Roll(times: 1, sides: -922337203685477580), operand2: Constant(term: -8)),

      (operand1: Roll(times: -1, sides: 0), operand2: Constant(term: -1)),
      (operand1: Roll(times: -1, sides: 2), operand2: Constant(term: -1)),
      (operand1: Roll(times: -1, sides: 32), operand2: Constant(term: -1)),

      (operand1: Roll(times: -9, sides: 0), operand2: Constant(term: -9)),
      (operand1: Roll(times: -9, sides: 8), operand2: Constant(term: -9)),
      (operand1: Roll(times: -9, sides: 78), operand2: Constant(term: -9)),

      (operand1: Roll(times: -1, sides: 0), operand2: Constant(term: Int.min)),
      (operand1: Roll(times: -1, sides: 9), operand2: Constant(term: -223372036854775808)),
      (operand1: Roll(times: -1, sides: 922337203685477580), operand2: Constant(term: -8)),

      (operand1: Roll(times: -1, sides: -0), operand2: Constant(term: -1)),
      (operand1: Roll(times: -1, sides: -2), operand2: Constant(term: -1)),
      (operand1: Roll(times: -1, sides: -32), operand2: Constant(term: -1)),

      (operand1: Roll(times: -9, sides: -0), operand2: Constant(term: -9)),
      (operand1: Roll(times: -9, sides: -8), operand2: Constant(term: -9)),
      (operand1: Roll(times: -9, sides: -78), operand2: Constant(term: -9)),

      (operand1: Roll(times: -1, sides: -0), operand2: Constant(term: Int.min)),
      (operand1: Roll(times: -1, sides: -9), operand2: Constant(term: -223372036854775808)),
      (operand1: Roll(times: -1, sides: -922337203685477580), operand2: Constant(term: -8)),

      // Out of range
      (operand1: Roll(times: 1, sides: 922337203685477580), operand2: Constant(term: 8)),
      (operand1: Roll(times: 1, sides: Int.max), operand2: Constant(term: 0)),

      (operand1: Roll(times: 1, sides: -922337203685477580), operand2: Constant(term: 9)),
      (operand1: Roll(times: 1, sides: Int.min), operand2: Constant(term: 0)),
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

  func testCombinedWithRoll() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Roll,
      expected: Roll
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Roll(times: 0, sides: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 1),
        operand2: Roll(times: 0, sides: 1),
        expected: Roll(times: 0, sides: 1)
      ),
      (
        operand1: Roll(times: 0, sides: 21),
        operand2: Roll(times: 0, sides: 21),
        expected: Roll(times: 0, sides: 21)
      ),

      (
        operand1: Roll(times: 1, sides: 0),
        operand2: Roll(times: 1, sides: 0),
        expected: Roll(times: 2, sides: 0)
      ),
      (
        operand1: Roll(times: 1, sides: 2),
        operand2: Roll(times: 1, sides: 2),
        expected: Roll(times: 2, sides: 2)
      ),
      (
        operand1: Roll(times: 1, sides: 32),
        operand2: Roll(times: 1, sides: 32),
        expected: Roll(times: 2, sides: 32)
      ),

      (
        operand1: Roll(times: 9, sides: 0),
        operand2: Roll(times: 9, sides: 0),
        expected: Roll(times: 18, sides: 0)
      ),
      (
        operand1: Roll(times: 9, sides: 8),
        operand2: Roll(times: 9, sides: 8),
        expected: Roll(times: 18, sides: 8)
      ),
      (
        operand1: Roll(times: 9, sides: 78),
        operand2: Roll(times: 9, sides: 78),
        expected: Roll(times: 18, sides: 78)
      ),

      (
        operand1: Roll(times: Int.max, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Roll(times: Int.max, sides: 0)
      ),
      (
        operand1: Roll(times: Int.max, sides: 1),
        operand2: Roll(times: 0, sides: 1),
        expected: Roll(times: Int.max, sides: 1)
      ),
      (
        operand1: Roll(times: Int.max, sides: Int.max),
        operand2: Roll(times: 0, sides: Int.max),
        expected: Roll(times: Int.max, sides: Int.max)
      ),

      (
        operand1: Roll(times: 0, sides: -0),
        operand2: Roll(times: 0, sides: -0),
        expected: Roll(times: 0, sides: -0)
      ),
      (
        operand1: Roll(times: 0, sides: -1),
        operand2: Roll(times: 0, sides: -1),
        expected: Roll(times: 0, sides: -1)
      ),
      (
        operand1: Roll(times: 0, sides: -21),
        operand2: Roll(times: 0, sides: -21),
        expected: Roll(times: 0, sides: -21)
      ),

      (
        operand1: Roll(times: 1, sides: -0),
        operand2: Roll(times: 1, sides: -0),
        expected: Roll(times: 2, sides: -0)
      ),
      (
        operand1: Roll(times: 1, sides: -2),
        operand2: Roll(times: 1, sides: -2),
        expected: Roll(times: 2, sides: -2)
      ),
      (
        operand1: Roll(times: 1, sides: -32),
        operand2: Roll(times: 1, sides: -32),
        expected: Roll(times: 2, sides: -32)
      ),

      (
        operand1: Roll(times: 9, sides: -0),
        operand2: Roll(times: 9, sides: -0),
        expected: Roll(times: 18, sides: -0)
      ),
      (
        operand1: Roll(times: 9, sides: -8),
        operand2: Roll(times: 9, sides: -8),
        expected: Roll(times: 18, sides: -8)
      ),
      (
        operand1: Roll(times: 9, sides: -78),
        operand2: Roll(times: 9, sides: -78),
        expected: Roll(times: 18, sides: -78)
      ),

      (
        operand1: Roll(times: Int.max, sides: -0),
        operand2: Roll(times: 0, sides: -0),
        expected: Roll(times: Int.max, sides: -0)
      ),
      (
        operand1: Roll(times: Int.max, sides: -1),
        operand2: Roll(times: 0, sides: -1),
        expected: Roll(times: Int.max, sides: -1)
      ),
      (
        operand1: Roll(times: Int.max, sides: Int.min),
        operand2: Roll(times: 0, sides: Int.min),
        expected: Roll(times: Int.max, sides: Int.min)
      ),

      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Roll(times: -0, sides: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 2),
        operand2: Roll(times: -0, sides: 2),
        expected: Roll(times: -0, sides: 2)
      ),
      (
        operand1: Roll(times: -0, sides: 32),
        operand2: Roll(times: -0, sides: 32),
        expected: Roll(times: -0, sides: 32)
      ),

      (
        operand1: Roll(times: -1, sides: 0),
        operand2: Roll(times: -1, sides: 0),
        expected: Roll(times: -2, sides: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 2),
        operand2: Roll(times: -1, sides: 2),
        expected: Roll(times: -2, sides: 2)
      ),
      (
        operand1: Roll(times: -1, sides: 32),
        operand2: Roll(times: -1, sides: 32),
        expected: Roll(times: -2, sides: 32)
      ),

      (
        operand1: Roll(times: -9, sides: 0),
        operand2: Roll(times: -9, sides: 0),
        expected: Roll(times: -18, sides: 0)
      ),
      (
        operand1: Roll(times: -9, sides: 8),
        operand2: Roll(times: -9, sides: 8),
        expected: Roll(times: -18, sides: 8)
      ),
      (
        operand1: Roll(times: -9, sides: 78),
        operand2: Roll(times: -9, sides: 78),
        expected: Roll(times: -18, sides: 78)
      ),

      (
        operand1: Roll(times: Int.min, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Roll(times: Int.min, sides: 0)
      ),
      (
        operand1: Roll(times: Int.min, sides: 1),
        operand2: Roll(times: -0, sides: 1),
        expected: Roll(times: Int.min, sides: 1)
      ),
      (
        operand1: Roll(times: Int.min, sides: Int.max),
        operand2: Roll(times: -0, sides: Int.max),
        expected: Roll(times: Int.min, sides: Int.max)
      ),

      (
        operand1: Roll(times: -0, sides: -0),
        operand2: Roll(times: -0, sides: -0),
        expected: Roll(times: -0, sides: -0)
      ),
      (
        operand1: Roll(times: -0, sides: -2),
        operand2: Roll(times: -0, sides: -2),
        expected: Roll(times: -0, sides: -2)
      ),
      (
        operand1: Roll(times: -0, sides: -32),
        operand2: Roll(times: -0, sides: -32),
        expected: Roll(times: -0, sides: -32)
      ),

      (
        operand1: Roll(times: -1, sides: -0),
        operand2: Roll(times: -1, sides: -0),
        expected: Roll(times: -2, sides: -0)
      ),
      (
        operand1: Roll(times: -1, sides: -2),
        operand2: Roll(times: -1, sides: -2),
        expected: Roll(times: -2, sides: -2)
      ),
      (
        operand1: Roll(times: -1, sides: -32),
        operand2: Roll(times: -1, sides: -32),
        expected: Roll(times: -2, sides: -32)
      ),

      (
        operand1: Roll(times: -9, sides: -0),
        operand2: Roll(times: -9, sides: -0),
        expected: Roll(times: -18, sides: -0)
      ),
      (
        operand1: Roll(times: -9, sides: -8),
        operand2: Roll(times: -9, sides: -8),
        expected: Roll(times: -18, sides: -8)
      ),
      (
        operand1: Roll(times: -9, sides: -78),
        operand2: Roll(times: -9, sides: -78),
        expected: Roll(times: -18, sides: -78)
      ),

      (
        operand1: Roll(times: Int.min, sides: -0),
        operand2: Roll(times: -0, sides: -0),
        expected: Roll(times: Int.min, sides: -0)
      ),
      (
        operand1: Roll(times: Int.min, sides: -1),
        operand2: Roll(times: -0, sides: -1),
        expected: Roll(times: Int.min, sides: -1)
      ),
      (
        operand1: Roll(times: Int.min, sides: Int.min),
        operand2: Roll(times: -0, sides: Int.min),
        expected: Roll(times: Int.min, sides: Int.min)
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

  func testCombinedWithInvalidRoll() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Roll
    )

    let fixtures: [Fixture] = [
      // Mis-matching sides value
      (operand1: Roll(times: 1, sides: 0), operand2: Roll(times: 1, sides: 1)),
      (operand1: Roll(times: 1, sides: 1), operand2: Roll(times: 1, sides: 0)),
      (operand1: Roll(times: 1, sides: 0), operand2: Roll(times: 1, sides: Int.max)),
      (operand1: Roll(times: 1, sides: Int.max), operand2: Roll(times: 1, sides: 0)),

      (operand1: Roll(times: 1, sides: -0), operand2: Roll(times: 1, sides: -1)),
      (operand1: Roll(times: 1, sides: -1), operand2: Roll(times: 1, sides: -0)),
      (operand1: Roll(times: 1, sides: -0), operand2: Roll(times: 1, sides: Int.min)),
      (operand1: Roll(times: 1, sides: Int.min), operand2: Roll(times: 1, sides: -0)),

      // Overflowing integer addition
      (operand1: Roll(times: Int.max, sides: 1), operand2: Roll(times: 1, sides: 1)),
      (operand1: Roll(times: 1, sides: 1), operand2: Roll(times: Int.max, sides: 1)),
      (operand1: Roll(times: Int.min, sides: 1), operand2: Roll(times: -1, sides: 1)),
      (operand1: Roll(times: -1, sides: 1), operand2: Roll(times: Int.min, sides: 1)),
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

  func testCombinedWithRollNegativeSides() {
    typealias Fixture = (
      operand1: Roll,
      operand2: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: Roll(times: 0, sides: -0), operand2: RollNegativeSides(times: 0)),
      (operand1: Roll(times: 0, sides: -1), operand2: RollNegativeSides(times: 0)),
      (operand1: Roll(times: 0, sides: -21), operand2: RollNegativeSides(times: 0)),

      (operand1: Roll(times: 1, sides: -0), operand2: RollNegativeSides(times: 1)),
      (operand1: Roll(times: 1, sides: -2), operand2: RollNegativeSides(times: 1)),
      (operand1: Roll(times: 1, sides: -32), operand2: RollNegativeSides(times: 1)),

      (operand1: Roll(times: 9, sides: -0), operand2: RollNegativeSides(times: 9)),
      (operand1: Roll(times: 9, sides: -8), operand2: RollNegativeSides(times: 9)),
      (operand1: Roll(times: 9, sides: -78), operand2: RollNegativeSides(times: 9)),

      (operand1: Roll(times: 0, sides: -0), operand2: RollNegativeSides(times: Int.max)),
      (operand1: Roll(times: 0, sides: -1), operand2: RollNegativeSides(times: Int.max)),
      (operand1: Roll(times: 0, sides: Int.min), operand2: RollNegativeSides(times: Int.max)),

      (operand1: Roll(times: -1, sides: -0), operand2: RollNegativeSides(times: -1)),
      (operand1: Roll(times: -1, sides: -2), operand2: RollNegativeSides(times: -1)),
      (operand1: Roll(times: -1, sides: -32), operand2: RollNegativeSides(times: -1)),

      (operand1: Roll(times: -9, sides: -0), operand2: RollNegativeSides(times: -9)),
      (operand1: Roll(times: -9, sides: -8), operand2: RollNegativeSides(times: -9)),
      (operand1: Roll(times: -9, sides: -78), operand2: RollNegativeSides(times: -9)),

      (operand1: Roll(times: -0, sides: -0), operand2: RollNegativeSides(times: Int.min)),
      (operand1: Roll(times: -0, sides: -1), operand2: RollNegativeSides(times: Int.min)),
      (operand1: Roll(times: -0, sides: Int.min), operand2: RollNegativeSides(times: Int.min)),

      // Mis-matching sides signage
      (operand1: Roll(times: 1, sides: 1), operand2: RollNegativeSides(times: 1)),
      (operand1: Roll(times: 1, sides: Int.max), operand2: RollNegativeSides(times: 1)),

      // Overflowing integer addition
      (operand1: Roll(times: Int.max, sides: -1), operand2: RollNegativeSides(times: 1)),
      (operand1: Roll(times: Int.min, sides: -1), operand2: RollNegativeSides(times: -1)),
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

  func testCombinedWithRollPositiveSides() {
    typealias Fixture = (
      operand1: Roll,
      operand2: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: Roll(times: 0, sides: 0), operand2: RollPositiveSides(times: 0)),
      (operand1: Roll(times: 0, sides: 1), operand2: RollPositiveSides(times: 0)),
      (operand1: Roll(times: 0, sides: 21), operand2: RollPositiveSides(times: 0)),

      (operand1: Roll(times: 1, sides: 0), operand2: RollPositiveSides(times: 1)),
      (operand1: Roll(times: 1, sides: 2), operand2: RollPositiveSides(times: 1)),
      (operand1: Roll(times: 1, sides: 32), operand2: RollPositiveSides(times: 1)),

      (operand1: Roll(times: 9, sides: 0), operand2: RollPositiveSides(times: 9)),
      (operand1: Roll(times: 9, sides: 8), operand2: RollPositiveSides(times: 9)),
      (operand1: Roll(times: 9, sides: 78), operand2: RollPositiveSides(times: 9)),

      (operand1: Roll(times: 0, sides: 0), operand2: RollPositiveSides(times: Int.max)),
      (operand1: Roll(times: 0, sides: 1), operand2: RollPositiveSides(times: Int.max)),
      (operand1: Roll(times: 0, sides: Int.max), operand2: RollPositiveSides(times: Int.max)),

      (operand1: Roll(times: -1, sides: 0), operand2: RollPositiveSides(times: -1)),
      (operand1: Roll(times: -1, sides: 2), operand2: RollPositiveSides(times: -1)),
      (operand1: Roll(times: -1, sides: 32), operand2: RollPositiveSides(times: -1)),

      (operand1: Roll(times: -9, sides: 0), operand2: RollPositiveSides(times: -9)),
      (operand1: Roll(times: -9, sides: 8), operand2: RollPositiveSides(times: -9)),
      (operand1: Roll(times: -9, sides: 78), operand2: RollPositiveSides(times: -9)),

      (operand1: Roll(times: -0, sides: 0), operand2: RollPositiveSides(times: Int.min)),
      (operand1: Roll(times: -0, sides: 1), operand2: RollPositiveSides(times: Int.min)),
      (operand1: Roll(times: -0, sides: Int.max), operand2: RollPositiveSides(times: Int.min)),

      // Mis-matching sides signage
      (operand1: Roll(times: 1, sides: -1), operand2: RollPositiveSides(times: 1)),
      (operand1: Roll(times: 1, sides: Int.min), operand2: RollPositiveSides(times: 1)),

      // Overflowing integer addition
      (operand1: Roll(times: Int.max, sides: 1), operand2: RollPositiveSides(times: 1)),
      (operand1: Roll(times: Int.min, sides: 1), operand2: RollPositiveSides(times: -1)),
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

extension RollTests {
  func testDroppedToRoll() {
    typealias Fixture = (
      operand: Roll,
      expected: Roll
    )

    let fixtures: [Fixture] = [
      (operand: Roll(times: 0, sides: 10), expected: Roll(times: 0, sides: 1)),
      (operand: Roll(times: 0, sides: 210), expected: Roll(times: 0, sides: 21)),

      (operand: Roll(times: 1, sides: 21), expected: Roll(times: 1, sides: 2)),
      (operand: Roll(times: 1, sides: 321), expected: Roll(times: 1, sides: 32)),

      (operand: Roll(times: 9, sides: 89), expected: Roll(times: 9, sides: 8)),
      (operand: Roll(times: 9, sides: 789), expected: Roll(times: 9, sides: 78)),

      (
        operand: Roll(times: 1, sides: Int.max),
        expected: Roll(times: 1, sides: 922337203685477580)
      ),

      (operand: Roll(times: 0, sides: -10), expected: Roll(times: 0, sides: -1)),
      (operand: Roll(times: 0, sides: -210), expected: Roll(times: 0, sides: -21)),

      (operand: Roll(times: 1, sides: -21), expected: Roll(times: 1, sides: -2)),
      (operand: Roll(times: 1, sides: -321), expected: Roll(times: 1, sides: -32)),

      (operand: Roll(times: 9, sides: -89), expected: Roll(times: 9, sides: -8)),
      (operand: Roll(times: 9, sides: -789), expected: Roll(times: 9, sides: -78)),

      (
        operand: Roll(times: 1, sides: Int.min),
        expected: Roll(times: 1, sides: -922337203685477580)
      ),

      (operand: Roll(times: -0, sides: 10), expected: Roll(times: -0, sides: 1)),
      (operand: Roll(times: -0, sides: 210), expected: Roll(times: -0, sides: 21)),

      (operand: Roll(times: -1, sides: 21), expected: Roll(times: -1, sides: 2)),
      (operand: Roll(times: -1, sides: 321), expected: Roll(times: -1, sides: 32)),

      (operand: Roll(times: -9, sides: 89), expected: Roll(times: -9, sides: 8)),
      (operand: Roll(times: -9, sides: 789), expected: Roll(times: -9, sides: 78)),

      (
        operand: Roll(times: -1, sides: Int.max),
        expected: Roll(times: -1, sides: 922337203685477580)
      ),

      (operand: Roll(times: -0, sides: -10), expected: Roll(times: -0, sides: -1)),
      (operand: Roll(times: -0, sides: -210), expected: Roll(times: -0, sides: -21)),

      (operand: Roll(times: -1, sides: -21), expected: Roll(times: -1, sides: -2)),
      (operand: Roll(times: -1, sides: -321), expected: Roll(times: -1, sides: -32)),

      (operand: Roll(times: -9, sides: -89), expected: Roll(times: -9, sides: -8)),
      (operand: Roll(times: -9, sides: -789), expected: Roll(times: -9, sides: -78)),

      (
        operand: Roll(times: -1, sides: Int.min),
        expected: Roll(times: -1, sides: -922337203685477580)
      ),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped() as! Roll

      XCTAssertEqual(expected, actual, "operand: \(operand)")
    }
  }

  func testDroppedToRollNegativeSides() {
    typealias Fixture = (
      operand: Roll,
      expected: RollNegativeSides
    )

    let fixtures: [Fixture] = [
      (operand: Roll(times: 1, sides: -1), expected: RollNegativeSides(times: 1)),
      (operand: Roll(times: 9, sides: -9), expected: RollNegativeSides(times: 9)),

      (operand: Roll(times: -1, sides: -1), expected: RollNegativeSides(times: -1)),
      (operand: Roll(times: -9, sides: -9), expected: RollNegativeSides(times: -9)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped() as! RollNegativeSides

      XCTAssertEqual(expected, actual, "operand: \(operand)")
    }
  }

  func testDroppedToRollPositiveSides() {
    typealias Fixture = (
      operand: Roll,
      expected: RollPositiveSides
    )

    let fixtures: [Fixture] = [
      (operand: Roll(times: 0, sides: 0), expected: RollPositiveSides(times: 0)),
      (operand: Roll(times: 1, sides: 1), expected: RollPositiveSides(times: 1)),
      (operand: Roll(times: 9, sides: 9), expected: RollPositiveSides(times: 9)),

      (operand: Roll(times: 0, sides: -0), expected: RollPositiveSides(times: 0)),

      (operand: Roll(times: -0, sides: 0), expected: RollPositiveSides(times: -0)),
      (operand: Roll(times: -1, sides: 1), expected: RollPositiveSides(times: -1)),
      (operand: Roll(times: -9, sides: 9), expected: RollPositiveSides(times: -9)),

      (operand: Roll(times: -0, sides: -0), expected: RollPositiveSides(times: 0)),
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

extension RollTests {
  func testValue() {
    typealias Fixture = (
      operand: Roll,
      expected: CountableClosedRange<Int>
    )

    let fixtures: [Fixture] = [
      (operand: Roll(times: 1, sides: 3), expected: 1...3),
      (operand: Roll(times: 2, sides: 4), expected: 2...8),
      (operand: Roll(times: 3, sides: 6), expected: 3...18),
      (operand: Roll(times: 4, sides: 8), expected: 4...32),
      (operand: Roll(times: 5, sides: 10), expected: 5...50),
      (operand: Roll(times: 6, sides: 12), expected: 6...72),
      (operand: Roll(times: 7, sides: 20), expected: 7...140),

      (operand: Roll(times: -1, sides: 3), expected: -3...(-1)),
      (operand: Roll(times: -2, sides: 4), expected: -8...(-2)),
      (operand: Roll(times: -3, sides: 6), expected: -18...(-3)),
      (operand: Roll(times: -4, sides: 8), expected: -32...(-4)),
      (operand: Roll(times: -5, sides: 10), expected: -50...(-5)),
      (operand: Roll(times: -6, sides: 12), expected: -72...(-6)),
      (operand: Roll(times: -7, sides: 20), expected: -140...(-7)),

      (operand: Roll(times: 1, sides: -3), expected: -3...(-1)),
      (operand: Roll(times: 2, sides: -4), expected: -8...(-2)),
      (operand: Roll(times: 3, sides: -6), expected: -18...(-3)),
      (operand: Roll(times: 4, sides: -8), expected: -32...(-4)),
      (operand: Roll(times: 5, sides: -10), expected: -50...(-5)),
      (operand: Roll(times: 6, sides: -12), expected: -72...(-6)),
      (operand: Roll(times: 7, sides: -20), expected: -140...(-7)),

      (operand: Roll(times: -1, sides: -3), expected: 1...3),
      (operand: Roll(times: -2, sides: -4), expected: 2...8),
      (operand: Roll(times: -3, sides: -6), expected: 3...18),
      (operand: Roll(times: -4, sides: -8), expected: 4...32),
      (operand: Roll(times: -5, sides: -10), expected: 5...50),
      (operand: Roll(times: -6, sides: -12), expected: 6...72),
      (operand: Roll(times: -7, sides: -20), expected: 7...140),

      (operand: Roll(times: 0, sides: 3), expected: 0...0),
      (operand: Roll(times: 0, sides: 4), expected: 0...0),
      (operand: Roll(times: 0, sides: 6), expected: 0...0),
      (operand: Roll(times: 0, sides: 8), expected: 0...0),
      (operand: Roll(times: 0, sides: 10), expected: 0...0),
      (operand: Roll(times: 0, sides: 12), expected: 0...0),
      (operand: Roll(times: 0, sides: 20), expected: 0...0),

      (operand: Roll(times: -0, sides: 3), expected: 0...0),
      (operand: Roll(times: -0, sides: 4), expected: 0...0),
      (operand: Roll(times: -0, sides: 6), expected: 0...0),
      (operand: Roll(times: -0, sides: 8), expected: 0...0),
      (operand: Roll(times: -0, sides: 10), expected: 0...0),
      (operand: Roll(times: -0, sides: 12), expected: 0...0),
      (operand: Roll(times: -0, sides: 20), expected: 0...0),

      (operand: Roll(times: 1, sides: 0), expected: 0...0),
      (operand: Roll(times: 2, sides: 0), expected: 0...0),
      (operand: Roll(times: 3, sides: 0), expected: 0...0),
      (operand: Roll(times: 4, sides: 0), expected: 0...0),
      (operand: Roll(times: 5, sides: 0), expected: 0...0),
      (operand: Roll(times: 6, sides: 0), expected: 0...0),
      (operand: Roll(times: 7, sides: 0), expected: 0...0),

      (operand: Roll(times: 1, sides: -0), expected: 0...0),
      (operand: Roll(times: 2, sides: -0), expected: 0...0),
      (operand: Roll(times: 3, sides: -0), expected: 0...0),
      (operand: Roll(times: 4, sides: -0), expected: 0...0),
      (operand: Roll(times: 5, sides: -0), expected: 0...0),
      (operand: Roll(times: 6, sides: -0), expected: 0...0),
      (operand: Roll(times: 7, sides: -0), expected: 0...0),

      (operand: Roll(times: 0, sides: 0), expected: 0...0),
      (operand: Roll(times: -0, sides: 0), expected: 0...0),
      (operand: Roll(times: 0, sides: -0), expected: 0...0),
      (operand: Roll(times: -0, sides: -0), expected: 0...0),

      (operand: Roll(times: 1, sides: Int.max), expected: 1...Int.max),
      (operand: Roll(times: 1, sides: Int.min + 1), expected: (Int.min + 1)...(-1)),

//      Near infinite loops
//      (operand: Roll(times: Int.max, sides: 1), expected: Int.max...Int.max),
//      (operand: Roll(times: Int.min + 1, sides: 1), expected: (Int.min + 1)...(Int.min + 1)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.value()

      XCTAssertTrue(
        expected.contains(actual),
        "expected: \(expected) actual: \(actual) operand: \(operand)"
      )
    }
  }

  func testValueWithOverflow() {
    let fixtures: [Roll] = [
      Roll(times: 1, sides: Int.min),
      Roll(times: Int.min, sides: 4),
      Roll(times: Int.min, sides: Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand = fixture

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Operation

extension RollTests {
  // MARK: - Negation

  func testNegated() {
    typealias Fixture = (
      operand: Roll,
      expected: Roll
    )

    let fixtures: [Fixture] = [
      (operand: Roll(times: 1, sides: 1), expected: Roll(times: 1, sides: -1)),
      (operand: Roll(times: 1, sides: -1), expected: Roll(times: 1, sides: 1)),
      (operand: Roll(times: -1, sides: 1), expected: Roll(times: -1, sides: -1)),
      (operand: Roll(times: -1, sides: -1), expected: Roll(times: -1, sides: 1)),

      (operand: Roll(times: 0, sides: 0), expected: Roll(times: 0, sides: 0)),
      (operand: Roll(times: 0, sides: -0), expected: Roll(times: 0, sides: 0)),
      (operand: Roll(times: -0, sides: 0), expected: Roll(times: 0, sides: 0)),
      (operand: Roll(times: -0, sides: -0), expected: Roll(times: 0, sides: 0)),

      (
        operand: Roll(times: Int.max, sides: Int.max),
        expected: Roll(times: Int.max, sides: -Int.max)
      ),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated() as! Roll

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegatedWithOverflow() {
    let operands: [Roll] = [
      Roll(times: Int.min, sides: Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for operand in operands {
      XCTAssertThrowsError(try operand.negated()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  // MARK: - Addition

  func testAddedToConstant() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: 3)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: -3)
      ),

      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: 0),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: -0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: -0),
        expected: Constant(term: -1)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -0),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: Int.min),
        expected: Constant(term: Int.min)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: Int.min),
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
      operand1: Roll,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Roll(times: 1, sides: 1), operand2: Constant(term: Int.max)),
      (operand1: Roll(times: -1, sides: 1), operand2: Constant(term: Int.min)),
      (operand1: Roll(times: 1, sides: Int.min), operand2: Constant(term: 0)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1.added(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testAddedToRoll() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -2)
      ),

      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: -1)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -1)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
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

  // MARK: - Division

  func testDividedByConstant() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -2),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: Int.min),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: Int.min),
        expected: Constant(term: 0)
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
      operand1: Roll,
      operand2: Constant,
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "1d1")
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "-1d1")
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "1d1")
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "-1d1")
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "0d0")
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 0),
        expected: .divisionByZero(operandLeft: "0d0")
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "0d0")
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -0),
        expected: .divisionByZero(operandLeft: "0d0")
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected

      XCTAssertThrowsError(try operand1.divided(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDividedByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Roll(times: 1, sides: Int.min), operand2: Constant(term: 1)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1.divided(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDividedByRoll() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 2, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -2, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: 2, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: -2, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 2)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 0)
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

  // MARK: - Multiplication

  func testMultipliedByConstant() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: 2)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -2),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -2),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -0),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: Int.max)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: Int.max),
        expected: Constant(term: -Int.max)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: Int.min),
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
      operand1: Roll,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Roll(times: 1, sides: Int.max), operand2: Constant(term: Int.max)),
      (operand1: Roll(times: 1, sides: -Int.max), operand2: Constant(term: Int.max)),
      (operand1: Roll(times: 1, sides: Int.max), operand2: Constant(term: -Int.max)),
      (operand1: Roll(times: 1, sides: -Int.max), operand2: Constant(term: -Int.max)),

      (operand1: Roll(times: 2, sides: 1), operand2: Constant(term: Int.max)),
      (operand1: Roll(times: -2, sides: 1), operand2: Constant(term: Int.max)),
      (operand1: Roll(times: 2, sides: 1), operand2: Constant(term: -Int.max)),
      (operand1: Roll(times: -2, sides: 1), operand2: Constant(term: -Int.max)),

      (operand1: Roll(times: -1, sides: 1), operand2: Constant(term: Int.min)),

//       Near infinite loop
//       (operand1: Roll(times: Int.min, sides: 1), operand2: Constant(term: -1)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1.multiplied(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testMultipliedByRoll() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 2)
      ),

      (
        operand1: Roll(times: 2, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -2, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: 2, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: -2, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 2)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
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
      operand1: Roll,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: 2),
        expected: Constant(term: -3)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: 3)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Constant(term: -2),
        expected: Constant(term: 1)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 2),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 2),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: -2),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -2),
        expected: Constant(term: 2)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Constant(term: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: -0),
        operand2: Constant(term: -0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Constant(term: -0),
        expected: Constant(term: 0)
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
      operand1: Roll,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      (operand1: Roll(times: -2, sides: 1), operand2: Constant(term: Int.max)),

      (operand1: Roll(times: 0, sides: 0), operand2: Constant(term: Int.min)),
      (operand1: Roll(times: -0, sides: 0), operand2: Constant(term: Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1.subtracted(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testSubtractedByRoll() {
    typealias Fixture = (
      operand1: Roll,
      operand2: Roll,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: -3)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 3)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 1)
      ),

      (
        operand1: Roll(times: 2, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -2, sides: 1),
        operand2: Roll(times: 1, sides: 1),
        expected: Constant(term: -3)
      ),
      (
        operand1: Roll(times: 2, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: 3)
      ),
      (
        operand1: Roll(times: -2, sides: 1),
        operand2: Roll(times: -1, sides: 1),
        expected: Constant(term: -1)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 2, sides: 1),
        expected: Constant(term: -2)
      ),
      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 2)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -2, sides: 1),
        expected: Constant(term: 2)
      ),

      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: -1)
      ),
      (
        operand1: Roll(times: 1, sides: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 1)
      ),
      (
        operand1: Roll(times: -1, sides: 1),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: -1)
      ),

      (
        operand1: Roll(times: 0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: 0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: 0, sides: -0),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
      ),
      (
        operand1: Roll(times: -0, sides: 0),
        operand2: Roll(times: -0, sides: 0),
        expected: Constant(term: 0)
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
}
