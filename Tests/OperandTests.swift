@testable import ChanceKit
import XCTest

class OperandTests: XCTestCase {}

// MARK: - Initialization

extension OperandTests {
  func testInitConstantWithValidRawLexeme() {
    typealias Fixture = (
      rawLexeme: String,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (rawLexeme: "0", expected: .constant(0)),
      (rawLexeme: "1", expected: .constant(1)),
      (rawLexeme: "9", expected: .constant(9)),
      (rawLexeme: String(Int.max), expected: .constant(Int.max)),

      (rawLexeme: "-0", expected: .constant(-0)),
      (rawLexeme: "-1", expected: .constant(-1)),
      (rawLexeme: "-9", expected: .constant(-9)),
      (rawLexeme: String(Int.min), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let rawLexeme = fixture.rawLexeme
      let expected = fixture.expected
      let actual = Operand(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitRollWithValidRawLexeme() {
    typealias Fixture = (
      rawLexeme: String,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (rawLexeme: "0d0", expected: .roll(0, 0)),
      (rawLexeme: "1d1", expected: .roll(1, 1)),
      (rawLexeme: "9d9", expected: .roll(9, 9)),
      (rawLexeme: "\(Int.max)d\(Int.max)", expected: .roll(Int.max, Int.max)),

      (rawLexeme: "0d-0", expected: .roll(0, -0)),
      (rawLexeme: "1d-1", expected: .roll(1, -1)),
      (rawLexeme: "9d-9", expected: .roll(9, -9)),
      (rawLexeme: "\(Int.max)d\(Int.min)", expected: .roll(Int.max, Int.min)),

      (rawLexeme: "-0d0", expected: .roll(-0, 0)),
      (rawLexeme: "-1d1", expected: .roll(-1, 1)),
      (rawLexeme: "-9d9", expected: .roll(-9, 9)),
      (rawLexeme: "\(Int.min)d\(Int.max)", expected: .roll(Int.min, Int.max)),

      (rawLexeme: "-0d-0", expected: .roll(-0, -0)),
      (rawLexeme: "-1d-1", expected: .roll(-1, -1)),
      (rawLexeme: "-9d-9", expected: .roll(-9, -9)),
      (rawLexeme: "\(Int.min)d\(Int.min)", expected: .roll(Int.min, Int.min)),
    ]

    for fixture in fixtures {
      let rawLexeme = fixture.rawLexeme
      let expected = fixture.expected
      let actual = Operand(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitRollNegativeSidesWithValidRawLexeme() {
    typealias Fixture = (
      rawLexeme: String,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (rawLexeme: "0d-", expected: .rollNegativeSides(0)),
      (rawLexeme: "1d-", expected: .rollNegativeSides(1)),
      (rawLexeme: "9d-", expected: .rollNegativeSides(9)),
      (rawLexeme: "\(Int.max)d-", expected: .rollNegativeSides(Int.max)),

      (rawLexeme: "-0d-", expected: .rollNegativeSides(-0)),
      (rawLexeme: "-1d-", expected: .rollNegativeSides(-1)),
      (rawLexeme: "-9d-", expected: .rollNegativeSides(-9)),
      (rawLexeme: "\(Int.min)d-", expected: .rollNegativeSides(Int.min)),
    ]

    for fixture in fixtures {
      let rawLexeme = fixture.rawLexeme
      let expected = fixture.expected
      let actual = Operand(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitRollPositiveSidesWithValidRawLexeme() {
    typealias Fixture = (
      rawLexeme: String,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (rawLexeme: "0d", expected: .rollPositiveSides(0)),
      (rawLexeme: "1d", expected: .rollPositiveSides(1)),
      (rawLexeme: "9d", expected: .rollPositiveSides(9)),
      (rawLexeme: "\(Int.max)d", expected: .rollPositiveSides(Int.max)),

      (rawLexeme: "-0d", expected: .rollPositiveSides(-0)),
      (rawLexeme: "-1d", expected: .rollPositiveSides(-1)),
      (rawLexeme: "-9d", expected: .rollPositiveSides(-9)),
      (rawLexeme: "\(Int.min)d", expected: .rollPositiveSides(Int.min)),
    ]

    for fixture in fixtures {
      let rawLexeme = fixture.rawLexeme
      let expected = fixture.expected
      let actual = Operand(rawLexeme: rawLexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidRawLexeme() {
    let fixtures = [
      "+",
      "÷",
      "×",
      "-",
      "(",
      ")",
      "d",
      "-d",
      "d-",
      "-d-",
      "+d",
      "d+",
      "+d+",
      "d0",
      "d1",
      "d9",
      "d-0",
      "d-1",
      "d-9",
      "-d0",
      "-d1",
      "-d9",
      "d+0",
      "d+1",
      "d+9",
      "+d0",
      "+d1",
      "+d9",
      "+d-0",
      "+d-1",
      "+d-9",
      "+d+0",
      "+d+1",
      "+d+9",
      "0d+",
      "1d+",
      "9d+",
      "-0d+",
      "-1d+",
      "-9d+",
      "+0d+",
      "+1d+",
      "+9d+",
      "0d0\n1d1",
      "=",
      "[",
      "{",
      "<",
      ".",
      ",",
      ",",
      "**",
      "&",
      "|",
      "!",
      "~",
      "..<",
      "...",
      "<<",
      ">>",
      "%",
    ]

    for fixture in fixtures {
      XCTAssertNil(Operand(rawLexeme: fixture), "rawLexeme: \(fixture)")
    }
  }
}

// MARK: - Tokenable

extension OperandTests {
  func testDescription() {
    typealias Fixture = (
      operand: Operand,
      expected: String
    )

    let fixtures: [Fixture] = [
      (operand: .constant(0), expected: "0"),
      (operand: .constant(Int.max), expected: String(Int.max)),
      (operand: .constant(Int.min), expected: String(Int.min)),

      (operand: .roll(0, 0), expected: "0d0"),
      (operand: .roll(Int.max, Int.max), expected: "\(String(Int.max))d\(String(Int.max))"),
      (operand: .roll(Int.min, Int.min), expected: "\(String(Int.min))d\(String(Int.min))"),

      (operand: .rollNegativeSides(0), expected: "0d-"),
      (operand: .rollNegativeSides(Int.max), expected: "\(Int.max)d-"),
      (operand: .rollNegativeSides(Int.min), expected: "\(Int.min)d-"),

      (operand: .rollPositiveSides(0), expected: "0d"),
      (operand: .rollPositiveSides(Int.max), expected: "\(Int.max)d"),
      (operand: .rollPositiveSides(Int.min), expected: "\(Int.min)d"),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = String(describing: operand)

      XCTAssertEqual(expected, actual)
    }
  }
}

// MARK: - Inclusion

extension OperandTests {
  // MARK: - Constant

  func testCombinedConstantWithConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(1), operand2: .constant(0), expected: .constant(10)),
      (operand1: .constant(21), operand2: .constant(0), expected: .constant(210)),

      (operand1: .constant(0), operand2: .constant(1), expected: .constant(1)),
      (operand1: .constant(2), operand2: .constant(1), expected: .constant(21)),
      (operand1: .constant(32), operand2: .constant(1), expected: .constant(321)),

      (operand1: .constant(0), operand2: .constant(9), expected: .constant(9)),
      (operand1: .constant(8), operand2: .constant(9), expected: .constant(89)),
      (operand1: .constant(78), operand2: .constant(9), expected: .constant(789)),

      (operand1: .constant(0), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (
        operand1: .constant(9),
        operand2: .constant(223372036854775807),
        expected: .constant(Int.max)
      ),
      (
        operand1: .constant(922337203685477580),
        operand2: .constant(7),
        expected: .constant(Int.max)
      ),

      (operand1: .constant(-0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(0), expected: .constant(-10)),
      (operand1: .constant(-21), operand2: .constant(0), expected: .constant(-210)),

      (operand1: .constant(-0), operand2: .constant(1), expected: .constant(1)),
      (operand1: .constant(-2), operand2: .constant(1), expected: .constant(-21)),
      (operand1: .constant(-32), operand2: .constant(1), expected: .constant(-321)),

      (operand1: .constant(-0), operand2: .constant(9), expected: .constant(9)),
      (operand1: .constant(-8), operand2: .constant(9), expected: .constant(-89)),
      (operand1: .constant(-78), operand2: .constant(9), expected: .constant(-789)),

      (operand1: .constant(-0), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (
        operand1: .constant(-9),
        operand2: .constant(223372036854775807),
        expected: .constant(-Int.max)
      ),
      (
        operand1: .constant(-922337203685477580),
        operand2: .constant(7),
        expected: .constant(-Int.max)
      ),

      (operand1: .constant(0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .constant(1), operand2: .constant(-0), expected: .constant(10)),
      (operand1: .constant(21), operand2: .constant(-0), expected: .constant(210)),

      (operand1: .constant(-0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(-0), expected: .constant(-10)),
      (operand1: .constant(-21), operand2: .constant(-0), expected: .constant(-210)),

      (
        operand1: .constant(-9),
        operand2: .constant(223372036854775808),
        expected: .constant(Int.min)
      ),
      (
        operand1: .constant(-922337203685477580),
        operand2: .constant(8),
        expected: .constant(Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedConstantWithInvalidConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Invalid format
      (operand1: .constant(0), operand2: .constant(-1)),
      (operand1: .constant(2), operand2: .constant(-1)),
      (operand1: .constant(32), operand2: .constant(-1)),

      (operand1: .constant(0), operand2: .constant(-9)),
      (operand1: .constant(8), operand2: .constant(-9)),
      (operand1: .constant(78), operand2: .constant(-9)),

      (operand1: .constant(0), operand2: .constant(Int.min)),
      (operand1: .constant(9), operand2: .constant(-223372036854775807)),
      (operand1: .constant(922337203685477580), operand2: .constant(-7)),

      (operand1: .constant(-0), operand2: .constant(-1)),
      (operand1: .constant(-2), operand2: .constant(-1)),
      (operand1: .constant(-32), operand2: .constant(-1)),

      (operand1: .constant(-0), operand2: .constant(-9)),
      (operand1: .constant(-8), operand2: .constant(-9)),
      (operand1: .constant(-78), operand2: .constant(-9)),

      (operand1: .constant(-0), operand2: .constant(Int.min)),
      (operand1: .constant(-9), operand2: .constant(-223372036854775807)),
      (operand1: .constant(-922337203685477580), operand2: .constant(-7)),

      // Out of range
      (operand1: .constant(922337203685477580), operand2: .constant(8)),
      (operand1: .constant(Int.max), operand2: .constant(0)),

      (operand1: .constant(-922337203685477580), operand2: .constant(9)),
      (operand1: .constant(Int.min), operand2: .constant(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedConstantWithRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(0), operand2: .roll(0, 0)),
      (operand1: .constant(0), operand2: .roll(0, 1)),
      (operand1: .constant(0), operand2: .roll(0, 21)),

      (operand1: .constant(1), operand2: .roll(1, 0)),
      (operand1: .constant(1), operand2: .roll(1, 2)),
      (operand1: .constant(1), operand2: .roll(1, 32)),

      (operand1: .constant(9), operand2: .roll(9, 0)),
      (operand1: .constant(9), operand2: .roll(9, 8)),
      (operand1: .constant(9), operand2: .roll(9, 78)),

      (operand1: .constant(Int.max), operand2: .roll(1, 0)),
      (operand1: .constant(922337203685477580), operand2: .roll(1, 7)),
      (operand1: .constant(9), operand2: .roll(1, 223372036854775807)),

      (operand1: .constant(0), operand2: .roll(0, -0)),
      (operand1: .constant(0), operand2: .roll(0, -1)),
      (operand1: .constant(0), operand2: .roll(0, -21)),

      (operand1: .constant(1), operand2: .roll(1, -0)),
      (operand1: .constant(1), operand2: .roll(1, -2)),
      (operand1: .constant(1), operand2: .roll(1, -32)),

      (operand1: .constant(9), operand2: .roll(9, -0)),
      (operand1: .constant(9), operand2: .roll(9, -8)),
      (operand1: .constant(9), operand2: .roll(9, -78)),

      (operand1: .constant(Int.max), operand2: .roll(1, -0)),
      (operand1: .constant(922337203685477580), operand2: .roll(1, -7)),
      (operand1: .constant(9), operand2: .roll(1, -223372036854775807)),

      (operand1: .constant(0), operand2: .roll(-0, 0)),
      (operand1: .constant(0), operand2: .roll(-0, 1)),
      (operand1: .constant(0), operand2: .roll(-0, 21)),

      (operand1: .constant(1), operand2: .roll(-1, 0)),
      (operand1: .constant(1), operand2: .roll(-1, 2)),
      (operand1: .constant(1), operand2: .roll(-1, 32)),

      (operand1: .constant(9), operand2: .roll(-9, 0)),
      (operand1: .constant(9), operand2: .roll(-9, 8)),
      (operand1: .constant(9), operand2: .roll(-9, 78)),

      (operand1: .constant(Int.max), operand2: .roll(-1, 0)),
      (operand1: .constant(922337203685477580), operand2: .roll(-1, 7)),
      (operand1: .constant(9), operand2: .roll(-1, 223372036854775807)),

      (operand1: .constant(0), operand2: .roll(-0, -0)),
      (operand1: .constant(0), operand2: .roll(-0, -1)),
      (operand1: .constant(0), operand2: .roll(-0, -21)),

      (operand1: .constant(1), operand2: .roll(-1, -0)),
      (operand1: .constant(1), operand2: .roll(-1, -2)),
      (operand1: .constant(1), operand2: .roll(-1, -32)),

      (operand1: .constant(9), operand2: .roll(-9, -0)),
      (operand1: .constant(9), operand2: .roll(-9, -8)),
      (operand1: .constant(9), operand2: .roll(-9, -78)),

      (operand1: .constant(Int.max), operand2: .roll(-1, -0)),
      (operand1: .constant(922337203685477580), operand2: .roll(-1, -7)),
      (operand1: .constant(9), operand2: .roll(-1, -223372036854775807)),

      (operand1: .constant(-0), operand2: .roll(0, 0)),
      (operand1: .constant(-0), operand2: .roll(0, 1)),
      (operand1: .constant(-0), operand2: .roll(0, 21)),

      (operand1: .constant(-1), operand2: .roll(1, 0)),
      (operand1: .constant(-1), operand2: .roll(1, 2)),
      (operand1: .constant(-1), operand2: .roll(1, 32)),

      (operand1: .constant(-9), operand2: .roll(9, 0)),
      (operand1: .constant(-9), operand2: .roll(9, 8)),
      (operand1: .constant(-9), operand2: .roll(9, 78)),

      (operand1: .constant(Int.min), operand2: .roll(1, 0)),
      (operand1: .constant(-922337203685477580), operand2: .roll(1, 8)),
      (operand1: .constant(-9), operand2: .roll(1, 223372036854775808)),

      (operand1: .constant(0), operand2: .roll(0, -0)),
      (operand1: .constant(0), operand2: .roll(0, -1)),
      (operand1: .constant(0), operand2: .roll(0, -21)),

      (operand1: .constant(-1), operand2: .roll(1, -0)),
      (operand1: .constant(-1), operand2: .roll(1, -2)),
      (operand1: .constant(-1), operand2: .roll(1, -32)),

      (operand1: .constant(-9), operand2: .roll(9, -0)),
      (operand1: .constant(-9), operand2: .roll(9, -8)),
      (operand1: .constant(-9), operand2: .roll(9, -78)),

      (operand1: .constant(Int.min), operand2: .roll(1, -0)),
      (operand1: .constant(-922337203685477580), operand2: .roll(1, -8)),
      (operand1: .constant(-9), operand2: .roll(1, -223372036854775808)),

      (operand1: .constant(-0), operand2: .roll(-0, 0)),
      (operand1: .constant(-0), operand2: .roll(-0, 1)),
      (operand1: .constant(-0), operand2: .roll(-0, 21)),

      (operand1: .constant(-1), operand2: .roll(-1, 0)),
      (operand1: .constant(-1), operand2: .roll(-1, 2)),
      (operand1: .constant(-1), operand2: .roll(-1, 32)),

      (operand1: .constant(-9), operand2: .roll(-9, 0)),
      (operand1: .constant(-9), operand2: .roll(-9, 8)),
      (operand1: .constant(-9), operand2: .roll(-9, 78)),

      (operand1: .constant(Int.min), operand2: .roll(-1, 0)),
      (operand1: .constant(-92337203685477580), operand2: .roll(-1, 8)),
      (operand1: .constant(-9), operand2: .roll(-1, 223372036854775808)),

      (operand1: .constant(0), operand2: .roll(-0, -0)),
      (operand1: .constant(0), operand2: .roll(-0, -1)),
      (operand1: .constant(0), operand2: .roll(-0, -21)),

      (operand1: .constant(-1), operand2: .roll(-1, -0)),
      (operand1: .constant(-1), operand2: .roll(-1, -2)),
      (operand1: .constant(-1), operand2: .roll(-1, -32)),

      (operand1: .constant(-9), operand2: .roll(-9, -0)),
      (operand1: .constant(-9), operand2: .roll(-9, -8)),
      (operand1: .constant(-9), operand2: .roll(-9, -78)),

      (operand1: .constant(Int.min), operand2: .roll(-1, -0)),
      (operand1: .constant(-922337203685477580), operand2: .roll(-1, -8)),
      (operand1: .constant(-9), operand2: .roll(-1, -223372036854775808)),

      (operand1: .constant(9), operand2: .roll(1, 223372036854775808)),
      (operand1: .constant(0), operand2: .roll(1, Int.max)),

      (operand1: .constant(-9), operand2: .roll(1, -223372036854775809)),
      (operand1: .constant(-0), operand2: .roll(1, Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedConstantWithRollNegativeSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(0), operand2: .rollNegativeSides(0)),
      (operand1: .constant(1), operand2: .rollNegativeSides(1)),
      (operand1: .constant(9), operand2: .rollNegativeSides(9)),
      (operand1: .constant(Int.max), operand2: .rollNegativeSides(1)),

      (operand1: .constant(0), operand2: .rollNegativeSides(-0)),
      (operand1: .constant(1), operand2: .rollNegativeSides(-1)),
      (operand1: .constant(9), operand2: .rollNegativeSides(-9)),
      (operand1: .constant(Int.max), operand2: .rollNegativeSides(-1)),

      (operand1: .constant(-0), operand2: .rollNegativeSides(0)),
      (operand1: .constant(-1), operand2: .rollNegativeSides(1)),
      (operand1: .constant(-9), operand2: .rollNegativeSides(9)),
      (operand1: .constant(-Int.max), operand2: .rollNegativeSides(1)),

      (operand1: .constant(-0), operand2: .rollNegativeSides(-0)),
      (operand1: .constant(-1), operand2: .rollNegativeSides(-1)),
      (operand1: .constant(-9), operand2: .rollNegativeSides(-9)),
      (operand1: .constant(-Int.max), operand2: .rollNegativeSides(-1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedConstantWithRollPositiveSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(0), operand2: .rollPositiveSides(0)),
      (operand1: .constant(1), operand2: .rollPositiveSides(1)),
      (operand1: .constant(9), operand2: .rollPositiveSides(9)),
      (operand1: .constant(Int.max), operand2: .rollPositiveSides(1)),

      (operand1: .constant(0), operand2: .rollPositiveSides(-0)),
      (operand1: .constant(1), operand2: .rollPositiveSides(-1)),
      (operand1: .constant(9), operand2: .rollPositiveSides(-9)),
      (operand1: .constant(Int.max), operand2: .rollPositiveSides(-1)),

      (operand1: .constant(-0), operand2: .rollPositiveSides(0)),
      (operand1: .constant(-1), operand2: .rollPositiveSides(1)),
      (operand1: .constant(-9), operand2: .rollPositiveSides(9)),
      (operand1: .constant(Int.min), operand2: .rollPositiveSides(1)),

      (operand1: .constant(-0), operand2: .rollPositiveSides(-0)),
      (operand1: .constant(-1), operand2: .rollPositiveSides(-1)),
      (operand1: .constant(-9), operand2: .rollPositiveSides(-9)),
      (operand1: .constant(Int.min), operand2: .rollPositiveSides(-1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  // MARK: - Roll

  func testCombinedRollWithConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(0, 0), operand2: .constant(0), expected: .roll(0, 0)),
      (operand1: .roll(0, 1), operand2: .constant(0), expected: .roll(0, 10)),
      (operand1: .roll(0, 21), operand2: .constant(0), expected: .roll(0, 210)),

      (operand1: .roll(1, 0), operand2: .constant(1), expected: .roll(1, 1)),
      (operand1: .roll(1, 2), operand2: .constant(1), expected: .roll(1, 21)),
      (operand1: .roll(1, 32), operand2: .constant(1), expected: .roll(1, 321)),

      (operand1: .roll(9, 0), operand2: .constant(9), expected: .roll(9, 9)),
      (operand1: .roll(9, 8), operand2: .constant(9), expected: .roll(9, 89)),
      (operand1: .roll(9, 78), operand2: .constant(9), expected: .roll(9, 789)),

      (operand1: .roll(1, 0), operand2: .constant(Int.max), expected: .roll(1, Int.max)),
      (operand1: .roll(1, 9), operand2: .constant(223372036854775807), expected: .roll(1, Int.max)),
      (operand1: .roll(1, 922337203685477580), operand2: .constant(7), expected: .roll(1, Int.max)),

      (operand1: .roll(0, -0), operand2: .constant(0), expected: .roll(0, 0)),
      (operand1: .roll(0, -1), operand2: .constant(0), expected: .roll(0, -10)),
      (operand1: .roll(0, -21), operand2: .constant(0), expected: .roll(0, -210)),

      (operand1: .roll(1, -0), operand2: .constant(1), expected: .roll(1, 1)),
      (operand1: .roll(1, -2), operand2: .constant(1), expected: .roll(1, -21)),
      (operand1: .roll(1, -32), operand2: .constant(1), expected: .roll(1, -321)),

      (operand1: .roll(9, -0), operand2: .constant(9), expected: .roll(9, 9)),
      (operand1: .roll(9, -8), operand2: .constant(9), expected: .roll(9, -89)),
      (operand1: .roll(9, -78), operand2: .constant(9), expected: .roll(9, -789)),

      (operand1: .roll(1, -0), operand2: .constant(Int.max), expected: .roll(1, Int.max)),
      (
        operand1: .roll(1, -9),
        operand2: .constant(223372036854775808),
        expected: .roll(1, Int.min)
      ),
      (
        operand1: .roll(1, -922337203685477580),
        operand2: .constant(8),
        expected: .roll(1, Int.min)
      ),

      (operand1: .roll(-0, 0), operand2: .constant(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 1), operand2: .constant(0), expected: .roll(-0, 10)),
      (operand1: .roll(-0, 21), operand2: .constant(0), expected: .roll(-0, 210)),

      (operand1: .roll(-1, 0), operand2: .constant(1), expected: .roll(-1, 1)),
      (operand1: .roll(-1, 2), operand2: .constant(1), expected: .roll(-1, 21)),
      (operand1: .roll(-1, 32), operand2: .constant(1), expected: .roll(-1, 321)),

      (operand1: .roll(-9, 0), operand2: .constant(9), expected: .roll(-9, 9)),
      (operand1: .roll(-9, 8), operand2: .constant(9), expected: .roll(-9, 89)),
      (operand1: .roll(-9, 78), operand2: .constant(9), expected: .roll(-9, 789)),

      (operand1: .roll(-1, 0), operand2: .constant(Int.max), expected: .roll(-1, Int.max)),
      (
        operand1: .roll(-1, 9),
        operand2: .constant(223372036854775807),
        expected: .roll(-1, Int.max)
      ),
      (
        operand1: .roll(-1, 922337203685477580),
        operand2: .constant(7),
        expected: .roll(-1, Int.max)
      ),

      (operand1: .roll(-0, -0), operand2: .constant(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, -1), operand2: .constant(0), expected: .roll(-0, -10)),
      (operand1: .roll(-0, -21), operand2: .constant(0), expected: .roll(-0, -210)),

      (operand1: .roll(-1, -0), operand2: .constant(1), expected: .roll(-1, 1)),
      (operand1: .roll(-1, -2), operand2: .constant(1), expected: .roll(-1, -21)),
      (operand1: .roll(-1, -32), operand2: .constant(1), expected: .roll(-1, -321)),

      (operand1: .roll(-9, -0), operand2: .constant(9), expected: .roll(-9, 9)),
      (operand1: .roll(-9, -8), operand2: .constant(9), expected: .roll(-9, -89)),
      (operand1: .roll(-9, -78), operand2: .constant(9), expected: .roll(-9, -789)),

      (operand1: .roll(-1, -0), operand2: .constant(Int.max), expected: .roll(-1, Int.max)),
      (
        operand1: .roll(-1, -9),
        operand2: .constant(223372036854775808),
        expected: .roll(-1, Int.min)
      ),
      (
        operand1: .roll(-1, -922337203685477580),
        operand2: .constant(8),
        expected: .roll(-1, Int.min)
      ),

      (operand1: .roll(0, 0), operand2: .constant(-0), expected: .roll(0, 0)),
      (operand1: .roll(0, 1), operand2: .constant(-0), expected: .roll(0, 10)),
      (operand1: .roll(0, 21), operand2: .constant(-0), expected: .roll(0, 210)),

      (operand1: .roll(0, -0), operand2: .constant(0), expected: .roll(0, 0)),
      (operand1: .roll(0, -1), operand2: .constant(0), expected: .roll(0, -10)),
      (operand1: .roll(0, -21), operand2: .constant(0), expected: .roll(0, -210)),

      (operand1: .roll(-0, 0), operand2: .constant(-0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 1), operand2: .constant(-0), expected: .roll(-0, 10)),
      (operand1: .roll(-0, 21), operand2: .constant(-0), expected: .roll(-0, 210)),

      (operand1: .roll(-0, -0), operand2: .constant(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, -1), operand2: .constant(0), expected: .roll(-0, -10)),
      (operand1: .roll(-0, -21), operand2: .constant(0), expected: .roll(-0, -210)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollWithInvalidConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Invalid format
      (operand1: .roll(1, 0), operand2: .constant(-1)),
      (operand1: .roll(1, 2), operand2: .constant(-1)),
      (operand1: .roll(1, 32), operand2: .constant(-1)),

      (operand1: .roll(9, 0), operand2: .constant(-9)),
      (operand1: .roll(9, 8), operand2: .constant(-9)),
      (operand1: .roll(9, 78), operand2: .constant(-9)),

      (operand1: .roll(1, 0), operand2: .constant(Int.min)),
      (operand1: .roll(1, 9), operand2: .constant(-223372036854775808)),
      (operand1: .roll(1, 922337203685477580), operand2: .constant(-8)),

      (operand1: .roll(1, -0), operand2: .constant(-1)),
      (operand1: .roll(1, -2), operand2: .constant(-1)),
      (operand1: .roll(1, -32), operand2: .constant(-1)),

      (operand1: .roll(9, -0), operand2: .constant(-9)),
      (operand1: .roll(9, -8), operand2: .constant(-9)),
      (operand1: .roll(9, -78), operand2: .constant(-9)),

      (operand1: .roll(1, -0), operand2: .constant(Int.min)),
      (operand1: .roll(1, -9), operand2: .constant(-223372036854775808)),
      (operand1: .roll(1, -922337203685477580), operand2: .constant(-8)),

      (operand1: .roll(-1, 0), operand2: .constant(-1)),
      (operand1: .roll(-1, 2), operand2: .constant(-1)),
      (operand1: .roll(-1, 32), operand2: .constant(-1)),

      (operand1: .roll(-9, 0), operand2: .constant(-9)),
      (operand1: .roll(-9, 8), operand2: .constant(-9)),
      (operand1: .roll(-9, 78), operand2: .constant(-9)),

      (operand1: .roll(-1, 0), operand2: .constant(Int.min)),
      (operand1: .roll(-1, 9), operand2: .constant(-223372036854775808)),
      (operand1: .roll(-1, 922337203685477580), operand2: .constant(-8)),

      (operand1: .roll(-1, -0), operand2: .constant(-1)),
      (operand1: .roll(-1, -2), operand2: .constant(-1)),
      (operand1: .roll(-1, -32), operand2: .constant(-1)),

      (operand1: .roll(-9, -0), operand2: .constant(-9)),
      (operand1: .roll(-9, -8), operand2: .constant(-9)),
      (operand1: .roll(-9, -78), operand2: .constant(-9)),

      (operand1: .roll(-1, -0), operand2: .constant(Int.min)),
      (operand1: .roll(-1, -9), operand2: .constant(-223372036854775808)),
      (operand1: .roll(-1, -922337203685477580), operand2: .constant(-8)),

      // Out of range
      (operand1: .roll(1, 922337203685477580), operand2: .constant(8)),
      (operand1: .roll(1, Int.max), operand2: .constant(0)),

      (operand1: .roll(1, -922337203685477580), operand2: .constant(9)),
      (operand1: .roll(1, Int.min), operand2: .constant(0)),

      // Overflow negation
      (operand1: .rollNegativeSides(1), operand2: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollWithRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .roll(0, 0)),
      (operand1: .roll(0, 1), operand2: .roll(0, 1), expected: .roll(0, 1)),
      (operand1: .roll(0, 21), operand2: .roll(0, 21), expected: .roll(0, 21)),

      (operand1: .roll(1, 0), operand2: .roll(1, 0), expected: .roll(2, 0)),
      (operand1: .roll(1, 2), operand2: .roll(1, 2), expected: .roll(2, 2)),
      (operand1: .roll(1, 32), operand2: .roll(1, 32), expected: .roll(2, 32)),

      (operand1: .roll(9, 0), operand2: .roll(9, 0), expected: .roll(18, 0)),
      (operand1: .roll(9, 8), operand2: .roll(9, 8), expected: .roll(18, 8)),
      (operand1: .roll(9, 78), operand2: .roll(9, 78), expected: .roll(18, 78)),

      (operand1: .roll(Int.max, 0), operand2: .roll(0, 0), expected: .roll(Int.max, 0)),
      (operand1: .roll(Int.max, 1), operand2: .roll(0, 1), expected: .roll(Int.max, 1)),
      (
        operand1: .roll(Int.max, Int.max),
        operand2: .roll(0, Int.max),
        expected: .roll(Int.max, Int.max)
      ),

      (operand1: .roll(0, -0), operand2: .roll(0, -0), expected: .roll(0, -0)),
      (operand1: .roll(0, -1), operand2: .roll(0, -1), expected: .roll(0, -1)),
      (operand1: .roll(0, -21), operand2: .roll(0, -21), expected: .roll(0, -21)),

      (operand1: .roll(1, -0), operand2: .roll(1, -0), expected: .roll(2, -0)),
      (operand1: .roll(1, -2), operand2: .roll(1, -2), expected: .roll(2, -2)),
      (operand1: .roll(1, -32), operand2: .roll(1, -32), expected: .roll(2, -32)),

      (operand1: .roll(9, -0), operand2: .roll(9, -0), expected: .roll(18, -0)),
      (operand1: .roll(9, -8), operand2: .roll(9, -8), expected: .roll(18, -8)),
      (operand1: .roll(9, -78), operand2: .roll(9, -78), expected: .roll(18, -78)),

      (operand1: .roll(Int.max, -0), operand2: .roll(0, -0), expected: .roll(Int.max, -0)),
      (operand1: .roll(Int.max, -1), operand2: .roll(0, -1), expected: .roll(Int.max, -1)),
      (
        operand1: .roll(Int.max, Int.min),
        operand2: .roll(0, Int.min),
        expected: .roll(Int.max, Int.min)
      ),

      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 2), operand2: .roll(-0, 2), expected: .roll(-0, 2)),
      (operand1: .roll(-0, 32), operand2: .roll(-0, 32), expected: .roll(-0, 32)),

      (operand1: .roll(-1, 0), operand2: .roll(-1, 0), expected: .roll(-2, 0)),
      (operand1: .roll(-1, 2), operand2: .roll(-1, 2), expected: .roll(-2, 2)),
      (operand1: .roll(-1, 32), operand2: .roll(-1, 32), expected: .roll(-2, 32)),

      (operand1: .roll(-9, 0), operand2: .roll(-9, 0), expected: .roll(-18, 0)),
      (operand1: .roll(-9, 8), operand2: .roll(-9, 8), expected: .roll(-18, 8)),
      (operand1: .roll(-9, 78), operand2: .roll(-9, 78), expected: .roll(-18, 78)),

      (operand1: .roll(Int.min, 0), operand2: .roll(-0, 0), expected: .roll(Int.min, 0)),
      (operand1: .roll(Int.min, 1), operand2: .roll(-0, 1), expected: .roll(Int.min, 1)),
      (
        operand1: .roll(Int.min, Int.max),
        operand2: .roll(-0, Int.max),
        expected: .roll(Int.min, Int.max)
      ),

      (operand1: .roll(-0, -0), operand2: .roll(-0, -0), expected: .roll(-0, -0)),
      (operand1: .roll(-0, -2), operand2: .roll(-0, -2), expected: .roll(-0, -2)),
      (operand1: .roll(-0, -32), operand2: .roll(-0, -32), expected: .roll(-0, -32)),

      (operand1: .roll(-1, -0), operand2: .roll(-1, -0), expected: .roll(-2, -0)),
      (operand1: .roll(-1, -2), operand2: .roll(-1, -2), expected: .roll(-2, -2)),
      (operand1: .roll(-1, -32), operand2: .roll(-1, -32), expected: .roll(-2, -32)),

      (operand1: .roll(-9, -0), operand2: .roll(-9, -0), expected: .roll(-18, -0)),
      (operand1: .roll(-9, -8), operand2: .roll(-9, -8), expected: .roll(-18, -8)),
      (operand1: .roll(-9, -78), operand2: .roll(-9, -78), expected: .roll(-18, -78)),

      (operand1: .roll(Int.min, -0), operand2: .roll(-0, -0), expected: .roll(Int.min, -0)),
      (operand1: .roll(Int.min, -1), operand2: .roll(-0, -1), expected: .roll(Int.min, -1)),
      (
        operand1: .roll(Int.min, Int.min),
        operand2: .roll(-0, Int.min),
        expected: .roll(Int.min, Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollWithInvalidRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching sides value
      (operand1: .roll(1, 0), operand2: .roll(1, 1)),
      (operand1: .roll(1, 1), operand2: .roll(1, 0)),
      (operand1: .roll(1, 0), operand2: .roll(1, Int.max)),
      (operand1: .roll(1, Int.max), operand2: .roll(1, 0)),

      (operand1: .roll(1, -0), operand2: .roll(1, -1)),
      (operand1: .roll(1, -1), operand2: .roll(1, -0)),
      (operand1: .roll(1, -0), operand2: .roll(1, Int.min)),
      (operand1: .roll(1, Int.min), operand2: .roll(1, -0)),

      // Overflowing integer addition
      (operand1: .roll(Int.max, 1), operand2: .roll(1, 1)),
      (operand1: .roll(1, 1), operand2: .roll(Int.max, 1)),
      (operand1: .roll(Int.min, 1), operand2: .roll(-1, 1)),
      (operand1: .roll(-1, 1), operand2: .roll(Int.min, 1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollWithRollNegativeSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: .roll(0, -0), operand2: .rollNegativeSides(0)),
      (operand1: .roll(0, -1), operand2: .rollNegativeSides(0)),
      (operand1: .roll(0, -21), operand2: .rollNegativeSides(0)),

      (operand1: .roll(1, -0), operand2: .rollNegativeSides(1)),
      (operand1: .roll(1, -2), operand2: .rollNegativeSides(1)),
      (operand1: .roll(1, -32), operand2: .rollNegativeSides(1)),

      (operand1: .roll(9, -0), operand2: .rollNegativeSides(9)),
      (operand1: .roll(9, -8), operand2: .rollNegativeSides(9)),
      (operand1: .roll(9, -78), operand2: .rollNegativeSides(9)),

      (operand1: .roll(0, -0), operand2: .rollNegativeSides(Int.max)),
      (operand1: .roll(0, -1), operand2: .rollNegativeSides(Int.max)),
      (operand1: .roll(0, Int.min), operand2: .rollNegativeSides(Int.max)),

      (operand1: .roll(-1, -0), operand2: .rollNegativeSides(-1)),
      (operand1: .roll(-1, -2), operand2: .rollNegativeSides(-1)),
      (operand1: .roll(-1, -32), operand2: .rollNegativeSides(-1)),

      (operand1: .roll(-9, -0), operand2: .rollNegativeSides(-9)),
      (operand1: .roll(-9, -8), operand2: .rollNegativeSides(-9)),
      (operand1: .roll(-9, -78), operand2: .rollNegativeSides(-9)),

      (operand1: .roll(-0, -0), operand2: .rollNegativeSides(Int.min)),
      (operand1: .roll(-0, -1), operand2: .rollNegativeSides(Int.min)),
      (operand1: .roll(-0, Int.min), operand2: .rollNegativeSides(Int.min)),

      // Mis-matching sides signage
      (operand1: .roll(1, 1), operand2: .rollNegativeSides(1)),
      (operand1: .roll(1, Int.max), operand2: .rollNegativeSides(1)),

      // Overflowing integer addition
      (operand1: .roll(Int.max, -1), operand2: .rollNegativeSides(1)),
      (operand1: .roll(Int.min, -1), operand2: .rollNegativeSides(-1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollWithRollPositiveSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: .roll(0, 0), operand2: .rollPositiveSides(0)),
      (operand1: .roll(0, 1), operand2: .rollPositiveSides(0)),
      (operand1: .roll(0, 21), operand2: .rollPositiveSides(0)),

      (operand1: .roll(1, 0), operand2: .rollPositiveSides(1)),
      (operand1: .roll(1, 2), operand2: .rollPositiveSides(1)),
      (operand1: .roll(1, 32), operand2: .rollPositiveSides(1)),

      (operand1: .roll(9, 0), operand2: .rollPositiveSides(9)),
      (operand1: .roll(9, 8), operand2: .rollPositiveSides(9)),
      (operand1: .roll(9, 78), operand2: .rollPositiveSides(9)),

      (operand1: .roll(0, 0), operand2: .rollPositiveSides(Int.max)),
      (operand1: .roll(0, 1), operand2: .rollPositiveSides(Int.max)),
      (operand1: .roll(0, Int.max), operand2: .rollPositiveSides(Int.max)),

      (operand1: .roll(-1, 0), operand2: .rollPositiveSides(-1)),
      (operand1: .roll(-1, 2), operand2: .rollPositiveSides(-1)),
      (operand1: .roll(-1, 32), operand2: .rollPositiveSides(-1)),

      (operand1: .roll(-9, 0), operand2: .rollPositiveSides(-9)),
      (operand1: .roll(-9, 8), operand2: .rollPositiveSides(-9)),
      (operand1: .roll(-9, 78), operand2: .rollPositiveSides(-9)),

      (operand1: .roll(-0, 0), operand2: .rollPositiveSides(Int.min)),
      (operand1: .roll(-0, 1), operand2: .rollPositiveSides(Int.min)),
      (operand1: .roll(-0, Int.max), operand2: .rollPositiveSides(Int.min)),

      // Mis-matching sides signage
      (operand1: .roll(1, -1), operand2: .rollPositiveSides(1)),
      (operand1: .roll(1, Int.min), operand2: .rollPositiveSides(1)),

      // Overflowing integer addition
      (operand1: .roll(Int.max, 1), operand2: .rollPositiveSides(1)),
      (operand1: .roll(Int.min, 1), operand2: .rollPositiveSides(-1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  // MARK: - RollNegativeSides

  func testCombinedRollNegativeSidesWithConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .rollNegativeSides(0), operand2: .constant(0), expected: .roll(0, -0)),
      (operand1: .rollNegativeSides(1), operand2: .constant(1), expected: .roll(1, -1)),
      (operand1: .rollNegativeSides(9), operand2: .constant(9), expected: .roll(9, -9)),
      (operand1: .rollNegativeSides(1), operand2: .constant(Int.max), expected: .roll(1, -Int.max)),

      (operand1: .rollNegativeSides(-0), operand2: .constant(0), expected: .roll(-0, -0)),
      (operand1: .rollNegativeSides(-1), operand2: .constant(1), expected: .roll(-1, -1)),
      (operand1: .rollNegativeSides(-9), operand2: .constant(9), expected: .roll(-9, -9)),
      (
        operand1: .rollNegativeSides(-1),
        operand2: .constant(Int.max),
        expected: .roll(-1, -Int.max)
      ),

      (operand1: .rollNegativeSides(0), operand2: .constant(-0), expected: .roll(0, -0)),
      (operand1: .rollNegativeSides(1), operand2: .constant(-1), expected: .roll(1, 1)),
      (operand1: .rollNegativeSides(9), operand2: .constant(-9), expected: .roll(9, 9)),
      (operand1: .rollNegativeSides(1), operand2: .constant(-Int.max), expected: .roll(1, Int.max)),

      (operand1: .rollNegativeSides(-0), operand2: .constant(-0), expected: .roll(-0, -0)),
      (operand1: .rollNegativeSides(-1), operand2: .constant(-1), expected: .roll(-1, 1)),
      (operand1: .rollNegativeSides(-9), operand2: .constant(-9), expected: .roll(-9, 9)),
      (
        operand1: .rollNegativeSides(-1),
        operand2: .constant(-Int.max),
        expected: .roll(-1, Int.max)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollNegativeSidesWithInvalidConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Overflow negation
      (operand1: .rollNegativeSides(1), operand2: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollNegativeSidesWithRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: .rollNegativeSides(0), operand2: .roll(0, -0)),
      (operand1: .rollNegativeSides(0), operand2: .roll(0, -1)),
      (operand1: .rollNegativeSides(0), operand2: .roll(0, -21)),

      (operand1: .rollNegativeSides(1), operand2: .roll(1, -0)),
      (operand1: .rollNegativeSides(1), operand2: .roll(1, -2)),
      (operand1: .rollNegativeSides(1), operand2: .roll(1, -32)),

      (operand1: .rollNegativeSides(9), operand2: .roll(9, -0)),
      (operand1: .rollNegativeSides(9), operand2: .roll(9, -8)),
      (operand1: .rollNegativeSides(9), operand2: .roll(9, -78)),

      (operand1: .rollNegativeSides(Int.max), operand2: .roll(0, -0)),
      (operand1: .rollNegativeSides(Int.max), operand2: .roll(0, -1)),
      (operand1: .rollNegativeSides(Int.max), operand2: .roll(0, Int.min)),

      (operand1: .rollNegativeSides(-0), operand2: .roll(-0, -0)),
      (operand1: .rollNegativeSides(-0), operand2: .roll(-0, -2)),
      (operand1: .rollNegativeSides(-0), operand2: .roll(-0, -32)),

      (operand1: .rollNegativeSides(-1), operand2: .roll(-1, -0)),
      (operand1: .rollNegativeSides(-1), operand2: .roll(-1, -2)),
      (operand1: .rollNegativeSides(-1), operand2: .roll(-1, -32)),

      (operand1: .rollNegativeSides(-9), operand2: .roll(-9, -0)),
      (operand1: .rollNegativeSides(-9), operand2: .roll(-9, -8)),
      (operand1: .rollNegativeSides(-9), operand2: .roll(-9, -78)),

      (operand1: .rollNegativeSides(Int.min), operand2: .roll(-0, -0)),
      (operand1: .rollNegativeSides(Int.min), operand2: .roll(-0, -1)),
      (operand1: .rollNegativeSides(Int.min), operand2: .roll(-0, Int.min)),

      // Mis-matching sides signage
      (operand1: .rollNegativeSides(1), operand2: .roll(1, 1)),
      (operand1: .rollNegativeSides(1), operand2: .roll(1, Int.max)),

      // Overflowing integer addition
      (operand1: .rollNegativeSides(1), operand2: .roll(Int.max, -1)),
      (operand1: .rollNegativeSides(-1), operand2: .roll(Int.min, -1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollNegativeSidesWithRollNegativeSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (
        operand1: .rollNegativeSides(0),
        operand2: .rollNegativeSides(0),
        expected: .rollNegativeSides(0)
      ),

      (
        operand1: .rollNegativeSides(1),
        operand2: .rollNegativeSides(1),
        expected: .rollNegativeSides(2)
      ),

      (
        operand1: .rollNegativeSides(9),
        operand2: .rollNegativeSides(9),
        expected: .rollNegativeSides(18)
      ),

      (
        operand1: .rollNegativeSides(Int.max),
        operand2: .rollNegativeSides(0),
        expected: .rollNegativeSides(Int.max)
      ),

      (
        operand1: .rollNegativeSides(-0),
        operand2: .rollNegativeSides(-0),
        expected: .rollNegativeSides(-0)
      ),

      (
        operand1: .rollNegativeSides(-1),
        operand2: .rollNegativeSides(-1),
        expected: .rollNegativeSides(-2)
      ),

      (
        operand1: .rollNegativeSides(-9),
        operand2: .rollNegativeSides(-9),
        expected: .rollNegativeSides(-18)
      ),

      (
        operand1: .rollNegativeSides(Int.min),
        operand2: .rollNegativeSides(-0),
        expected: .rollNegativeSides(Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollNegativeSidesWithInvalidRollNegativeSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Overflowing integer addition
      (operand1: .rollNegativeSides(Int.max), operand2: .rollNegativeSides(1)),
      (operand1: .rollNegativeSides(1), operand2: .rollNegativeSides(Int.max)),
      (operand1: .rollNegativeSides(Int.min), operand2: .rollNegativeSides(-1)),
      (operand1: .rollNegativeSides(-1), operand2: .rollNegativeSides(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollNegativeSidesWithRollPositiveSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching sides signage
      (operand1: .rollNegativeSides(1), operand2: .rollPositiveSides(1)),
      (operand1: .rollNegativeSides(-1), operand2: .rollPositiveSides(-1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  // MARK: - RollPositiveSides

  func testCombinedRollPositiveSidesWithConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .rollPositiveSides(0), operand2: .constant(0), expected: .roll(0, 0)),
      (operand1: .rollPositiveSides(1), operand2: .constant(1), expected: .roll(1, 1)),
      (operand1: .rollPositiveSides(9), operand2: .constant(9), expected: .roll(9, 9)),
      (operand1: .rollPositiveSides(1), operand2: .constant(Int.max), expected: .roll(1, Int.max)),

      (operand1: .rollPositiveSides(-0), operand2: .constant(0), expected: .roll(-0, 0)),
      (operand1: .rollPositiveSides(-1), operand2: .constant(1), expected: .roll(-1, 1)),
      (operand1: .rollPositiveSides(-9), operand2: .constant(9), expected: .roll(-9, 9)),
      (
        operand1: .rollPositiveSides(-1),
        operand2: .constant(Int.max),
        expected: .roll(-1, Int.max)
      ),

      (operand1: .rollPositiveSides(0), operand2: .constant(-0), expected: .roll(0, 0)),
      (operand1: .rollPositiveSides(1), operand2: .constant(-1), expected: .roll(1, -1)),
      (operand1: .rollPositiveSides(9), operand2: .constant(-9), expected: .roll(9, -9)),
      (operand1: .rollPositiveSides(1), operand2: .constant(Int.min), expected: .roll(1, Int.min)),

      (operand1: .rollPositiveSides(-0), operand2: .constant(-0), expected: .roll(-0, 0)),
      (operand1: .rollPositiveSides(-1), operand2: .constant(-1), expected: .roll(-1, -1)),
      (operand1: .rollPositiveSides(-9), operand2: .constant(-9), expected: .roll(-9, -9)),
      (
        operand1: .rollPositiveSides(-1),
        operand2: .constant(Int.min),
        expected: .roll(-1, Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollPositiveSidesWithRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching roll types
      (operand1: .rollPositiveSides(0), operand2: .roll(0, 0)),
      (operand1: .rollPositiveSides(0), operand2: .roll(0, 1)),
      (operand1: .rollPositiveSides(0), operand2: .roll(0, 21)),

      (operand1: .rollPositiveSides(1), operand2: .roll(1, 0)),
      (operand1: .rollPositiveSides(1), operand2: .roll(1, 2)),
      (operand1: .rollPositiveSides(1), operand2: .roll(1, 32)),

      (operand1: .rollPositiveSides(9), operand2: .roll(9, 0)),
      (operand1: .rollPositiveSides(9), operand2: .roll(9, 8)),
      (operand1: .rollPositiveSides(9), operand2: .roll(9, 78)),

      (operand1: .rollPositiveSides(Int.max), operand2: .roll(0, 0)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(0, 1)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(0, Int.max)),

      (operand1: .rollPositiveSides(-0), operand2: .roll(-0, 0)),
      (operand1: .rollPositiveSides(-0), operand2: .roll(-0, 2)),
      (operand1: .rollPositiveSides(-0), operand2: .roll(-0, 32)),

      (operand1: .rollPositiveSides(-1), operand2: .roll(-1, 0)),
      (operand1: .rollPositiveSides(-1), operand2: .roll(-1, 2)),
      (operand1: .rollPositiveSides(-1), operand2: .roll(-1, 32)),

      (operand1: .rollPositiveSides(-9), operand2: .roll(-9, 0)),
      (operand1: .rollPositiveSides(-9), operand2: .roll(-9, 8)),
      (operand1: .rollPositiveSides(-9), operand2: .roll(-9, 78)),

      (operand1: .rollPositiveSides(Int.min), operand2: .roll(-0, 0)),
      (operand1: .rollPositiveSides(Int.min), operand2: .roll(-0, 1)),
      (operand1: .rollPositiveSides(Int.min), operand2: .roll(-0, Int.max)),

      // Mis-matching sides signage
      (operand1: .rollPositiveSides(1), operand2: .roll(1, -1)),
      (operand1: .rollPositiveSides(1), operand2: .roll(1, Int.min)),

      // Overflowing integer addition
      (operand1: .rollPositiveSides(1), operand2: .roll(Int.max, 1)),
      (operand1: .rollPositiveSides(-1), operand2: .roll(Int.min, 1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollPositiveSidesWithRollPositiveSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (
        operand1: .rollPositiveSides(0),
        operand2: .rollPositiveSides(0),
        expected: .rollPositiveSides(0)
      ),

      (
        operand1: .rollPositiveSides(1),
        operand2: .rollPositiveSides(1),
        expected: .rollPositiveSides(2)
      ),

      (
        operand1: .rollPositiveSides(9),
        operand2: .rollPositiveSides(9),
        expected: .rollPositiveSides(18)
      ),

      (
        operand1: .rollPositiveSides(Int.max),
        operand2: .rollPositiveSides(0),
        expected: .rollPositiveSides(Int.max)
      ),

      (
        operand1: .rollPositiveSides(-0),
        operand2: .rollPositiveSides(-0),
        expected: .rollPositiveSides(-0)
      ),

      (
        operand1: .rollPositiveSides(-1),
        operand2: .rollPositiveSides(-1),
        expected: .rollPositiveSides(-2)
      ),

      (
        operand1: .rollPositiveSides(-9),
        operand2: .rollPositiveSides(-9),
        expected: .rollPositiveSides(-18)
      ),

      (
        operand1: .rollPositiveSides(Int.min),
        operand2: .rollPositiveSides(-0),
        expected: .rollPositiveSides(Int.min)
      ),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollPositiveSidesWithInvalidRollPositiveSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Overflowing integer addition
      (operand1: .rollPositiveSides(Int.max), operand2: .rollPositiveSides(1)),
      (operand1: .rollPositiveSides(1), operand2: .rollPositiveSides(Int.max)),
      (operand1: .rollPositiveSides(Int.min), operand2: .rollPositiveSides(-1)),
      (operand1: .rollPositiveSides(-1), operand2: .rollPositiveSides(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedRollPositiveSidesWithRollNegativeSides() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Mis-matching sides signage
      (operand1: .rollPositiveSides(1), operand2: .rollNegativeSides(1)),
      (operand1: .rollPositiveSides(-1), operand2: .rollNegativeSides(-1)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = ExpressionError.invalidCombinationOperands(
        String(describing: operand1),
        String(describing: operand2)
      )

      XCTAssertThrowsError(try operand1.combined(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Exclusion

extension OperandTests {
  // MARK: - Constant

  func testDroppedFromConstantToNil() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand?
    )

    let fixtures: [Fixture] = [
      (operand: .constant(0), expected: nil),
      (operand: .constant(1), expected: nil),
      (operand: .constant(9), expected: nil),

      (operand: .constant(-0), expected: nil),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  func testDroppedFromConstantToConstant() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand?
    )

    let fixtures: [Fixture] = [
      (operand: .constant(10), expected: Operand.constant(1)),
      (operand: .constant(210), expected: Operand.constant(21)),

      (operand: .constant(21), expected: Operand.constant(2)),
      (operand: .constant(321), expected: Operand.constant(32)),

      (operand: .constant(89), expected: Operand.constant(8)),
      (operand: .constant(789), expected: Operand.constant(78)),

      (operand: .constant(Int.max), expected: Operand.constant(922337203685477580)),

      (operand: .constant(-10), expected: Operand.constant(-1)),
      (operand: .constant(-210), expected: Operand.constant(-21)),

      (operand: .constant(-21), expected: Operand.constant(-2)),
      (operand: .constant(-321), expected: Operand.constant(-32)),

      (operand: .constant(-89), expected: Operand.constant(-8)),
      (operand: .constant(-789), expected: Operand.constant(-78)),

      (operand: .constant(Int.min), expected: Operand.constant(-922337203685477580)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  func testDroppedFromConstantToOperator() {
    typealias Fixture = (
      operand: Operand,
      expected: Operator?
    )

    let fixtures: [Fixture] = [
      (operand: .constant(-1), expected: Operator.subtraction),
      (operand: .constant(-9), expected: Operator.subtraction),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operator, "operand: \(operand)")
    }
  }

  // MARK: - Roll

  func testDroppedFromRollToRoll() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .roll(0, 10), expected: .roll(0, 1)),
      (operand: .roll(0, 210), expected: .roll(0, 21)),

      (operand: .roll(1, 21), expected: .roll(1, 2)),
      (operand: .roll(1, 321), expected: .roll(1, 32)),

      (operand: .roll(9, 89), expected: .roll(9, 8)),
      (operand: .roll(9, 789), expected: .roll(9, 78)),

      (operand: .roll(1, Int.max), expected: .roll(1, 922337203685477580)),

      (operand: .roll(0, -10), expected: .roll(0, -1)),
      (operand: .roll(0, -210), expected: .roll(0, -21)),

      (operand: .roll(1, -21), expected: .roll(1, -2)),
      (operand: .roll(1, -321), expected: .roll(1, -32)),

      (operand: .roll(9, -89), expected: .roll(9, -8)),
      (operand: .roll(9, -789), expected: .roll(9, -78)),

      (operand: .roll(1, Int.min), expected: .roll(1, -922337203685477580)),

      (operand: .roll(-0, 10), expected: .roll(-0, 1)),
      (operand: .roll(-0, 210), expected: .roll(-0, 21)),

      (operand: .roll(-1, 21), expected: .roll(-1, 2)),
      (operand: .roll(-1, 321), expected: .roll(-1, 32)),

      (operand: .roll(-9, 89), expected: .roll(-9, 8)),
      (operand: .roll(-9, 789), expected: .roll(-9, 78)),

      (operand: .roll(-1, Int.max), expected: .roll(-1, 922337203685477580)),

      (operand: .roll(-0, -10), expected: .roll(-0, -1)),
      (operand: .roll(-0, -210), expected: .roll(-0, -21)),

      (operand: .roll(-1, -21), expected: .roll(-1, -2)),
      (operand: .roll(-1, -321), expected: .roll(-1, -32)),

      (operand: .roll(-9, -89), expected: .roll(-9, -8)),
      (operand: .roll(-9, -789), expected: .roll(-9, -78)),

      (operand: .roll(-1, Int.min), expected: .roll(-1, -922337203685477580)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  func testDroppedFromRollToRollNegativeSides() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .roll(1, -1), expected: .rollNegativeSides(1)),
      (operand: .roll(9, -9), expected: .rollNegativeSides(9)),

      (operand: .roll(-1, -1), expected: .rollNegativeSides(-1)),
      (operand: .roll(-9, -9), expected: .rollNegativeSides(-9)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  func testDroppedFromRollToRollPositiveSides() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .roll(0, 0), expected: .rollPositiveSides(0)),
      (operand: .roll(1, 1), expected: .rollPositiveSides(1)),
      (operand: .roll(9, 9), expected: .rollPositiveSides(9)),

      (operand: .roll(0, -0), expected: .rollPositiveSides(0)),

      (operand: .roll(-0, 0), expected: .rollPositiveSides(-0)),
      (operand: .roll(-1, 1), expected: .rollPositiveSides(-1)),
      (operand: .roll(-9, 9), expected: .rollPositiveSides(-9)),

      (operand: .roll(-0, -0), expected: .rollPositiveSides(0)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  // MARK: - RollNegativeSides

  func testDroppedFromRollNegativeSidesToRollPositiveSides() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .rollNegativeSides(0), expected: .rollPositiveSides(0)),
      (operand: .rollNegativeSides(1), expected: .rollPositiveSides(1)),
      (operand: .rollNegativeSides(9), expected: .rollPositiveSides(9)),

      (operand: .rollNegativeSides(Int.max), expected: .rollPositiveSides(Int.max)),

      (operand: .rollNegativeSides(-0), expected: .rollPositiveSides(-0)),
      (operand: .rollNegativeSides(-1), expected: .rollPositiveSides(-1)),
      (operand: .rollNegativeSides(-9), expected: .rollPositiveSides(-9)),

      (operand: .rollNegativeSides(Int.min), expected: .rollPositiveSides(Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  // MARK: - RollPositiveSides

  func testDroppedFromRollPositiveSidesToConstant() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .rollPositiveSides(0), expected: .constant(0)),
      (operand: .rollPositiveSides(1), expected: .constant(1)),
      (operand: .rollPositiveSides(9), expected: .constant(9)),

      (operand: .rollPositiveSides(Int.max), expected: .constant(Int.max)),

      (operand: .rollPositiveSides(-0), expected: .constant(-0)),
      (operand: .rollPositiveSides(-1), expected: .constant(-1)),
      (operand: .rollPositiveSides(-9), expected: .constant(-9)),

      (operand: .rollPositiveSides(Int.min), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }
}

// MARK: - Evaluation

extension OperandTests {
  func testValueConstant() {
    typealias Fixture = (
      operand: Operand,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand: .constant(42), expected: 42),
      (operand: .constant(-42), expected: -42),
      (operand: .constant(0), expected: 0),
      (operand: .constant(-0), expected: 0),
      (operand: .constant(Int.max), expected: Int.max),
      (operand: .constant(Int.min), expected: Int.min),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.value()

      XCTAssertEqual(expected, actual)
    }
  }

  func testValueRoll() {
    typealias Fixture = (
      operand: Operand,
      expected: CountableClosedRange<Int>
    )

    let fixtures: [Fixture] = [
      (operand: .roll(1, 3), expected: 1...3),
      (operand: .roll(2, 4), expected: 2...8),
      (operand: .roll(3, 6), expected: 3...18),
      (operand: .roll(4, 8), expected: 4...32),
      (operand: .roll(5, 10), expected: 5...50),
      (operand: .roll(6, 12), expected: 6...72),
      (operand: .roll(7, 20), expected: 7...140),

      (operand: .roll(-1, 3), expected: -3...(-1)),
      (operand: .roll(-2, 4), expected: -8...(-2)),
      (operand: .roll(-3, 6), expected: -18...(-3)),
      (operand: .roll(-4, 8), expected: -32...(-4)),
      (operand: .roll(-5, 10), expected: -50...(-5)),
      (operand: .roll(-6, 12), expected: -72...(-6)),
      (operand: .roll(-7, 20), expected: -140...(-7)),

      (operand: .roll(1, -3), expected: -3...(-1)),
      (operand: .roll(2, -4), expected: -8...(-2)),
      (operand: .roll(3, -6), expected: -18...(-3)),
      (operand: .roll(4, -8), expected: -32...(-4)),
      (operand: .roll(5, -10), expected: -50...(-5)),
      (operand: .roll(6, -12), expected: -72...(-6)),
      (operand: .roll(7, -20), expected: -140...(-7)),

      (operand: .roll(-1, -3), expected: 1...3),
      (operand: .roll(-2, -4), expected: 2...8),
      (operand: .roll(-3, -6), expected: 3...18),
      (operand: .roll(-4, -8), expected: 4...32),
      (operand: .roll(-5, -10), expected: 5...50),
      (operand: .roll(-6, -12), expected: 6...72),
      (operand: .roll(-7, -20), expected: 7...140),

      (operand: .roll(0, 3), expected: 0...0),
      (operand: .roll(0, 4), expected: 0...0),
      (operand: .roll(0, 6), expected: 0...0),
      (operand: .roll(0, 8), expected: 0...0),
      (operand: .roll(0, 10), expected: 0...0),
      (operand: .roll(0, 12), expected: 0...0),
      (operand: .roll(0, 20), expected: 0...0),

      (operand: .roll(-0, 3), expected: 0...0),
      (operand: .roll(-0, 4), expected: 0...0),
      (operand: .roll(-0, 6), expected: 0...0),
      (operand: .roll(-0, 8), expected: 0...0),
      (operand: .roll(-0, 10), expected: 0...0),
      (operand: .roll(-0, 12), expected: 0...0),
      (operand: .roll(-0, 20), expected: 0...0),

      (operand: .roll(1, 0), expected: 0...0),
      (operand: .roll(2, 0), expected: 0...0),
      (operand: .roll(3, 0), expected: 0...0),
      (operand: .roll(4, 0), expected: 0...0),
      (operand: .roll(5, 0), expected: 0...0),
      (operand: .roll(6, 0), expected: 0...0),
      (operand: .roll(7, 0), expected: 0...0),

      (operand: .roll(1, -0), expected: 0...0),
      (operand: .roll(2, -0), expected: 0...0),
      (operand: .roll(3, -0), expected: 0...0),
      (operand: .roll(4, -0), expected: 0...0),
      (operand: .roll(5, -0), expected: 0...0),
      (operand: .roll(6, -0), expected: 0...0),
      (operand: .roll(7, -0), expected: 0...0),

      (operand: .roll(0, 0), expected: 0...0),
      (operand: .roll(-0, 0), expected: 0...0),
      (operand: .roll(0, -0), expected: 0...0),
      (operand: .roll(-0, -0), expected: 0...0),

      (operand: .roll(1, Int.max), expected: 1...Int.max),
      (operand: .roll(1, Int.min + 1), expected: (Int.min + 1)...(-1)),

//      Near infinite loops
//      (operand: .roll(Int.max, 1), expected: Int.max...Int.max),
//      (operand: .roll(Int.min + 1, 1), expected: (Int.min + 1)...(Int.min + 1)),
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

  func testValueRollWithOverflow() {
    let fixtures: [Operand] = [
      .roll(1, Int.min),
      .roll(Int.min, 4),
      .roll(Int.min, Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand = fixture

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testValueRollNegativeSides() {
    let fixtures: [Operand] = [
      .rollNegativeSides(0),
      .rollNegativeSides(1),
      .rollNegativeSides(9),

      .rollNegativeSides(Int.max),

      .rollNegativeSides(-0),
      .rollNegativeSides(-1),
      .rollNegativeSides(-9),

      .rollNegativeSides(Int.min),
    ]

    let expected = ExpressionError.missingOperandRollSides

    for fixture in fixtures {
      let operand = fixture

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testValueRollPositiveSides() {
    let fixtures: [Operand] = [
      .rollPositiveSides(0),
      .rollPositiveSides(1),
      .rollPositiveSides(9),

      .rollPositiveSides(Int.max),

      .rollPositiveSides(-0),
      .rollPositiveSides(-1),
      .rollPositiveSides(-9),

      .rollPositiveSides(Int.min),
    ]

    let expected = ExpressionError.missingOperandRollSides

    for fixture in fixtures {
      let operand = fixture

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Operation

extension OperandTests {
  // MARK: - Addition

  func testAddedConstantToConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(1), operand2: .constant(2), expected: .constant(3)),
      (operand1: .constant(-1), operand2: .constant(2), expected: .constant(1)),
      (operand1: .constant(1), operand2: .constant(-2), expected: .constant(-1)),
      (operand1: .constant(-1), operand2: .constant(-2), expected: .constant(-3)),

      (operand1: .constant(2), operand2: .constant(1), expected: .constant(3)),
      (operand1: .constant(-2), operand2: .constant(1), expected: .constant(-1)),
      (operand1: .constant(2), operand2: .constant(-1), expected: .constant(1)),
      (operand1: .constant(-2), operand2: .constant(-1), expected: .constant(-3)),

      (operand1: .constant(1), operand2: .constant(0), expected: .constant(1)),
      (operand1: .constant(-1), operand2: .constant(0), expected: .constant(-1)),
      (operand1: .constant(1), operand2: .constant(-0), expected: .constant(1)),
      (operand1: .constant(-1), operand2: .constant(-0), expected: .constant(-1)),

      (operand1: .constant(0), operand2: .constant(1), expected: .constant(1)),
      (operand1: .constant(-0), operand2: .constant(1), expected: .constant(1)),
      (operand1: .constant(0), operand2: .constant(-1), expected: .constant(-1)),
      (operand1: .constant(-0), operand2: .constant(-1), expected: .constant(-1)),

      (operand1: .constant(0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .constant(0), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (operand1: .constant(-0), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .constant(0), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .constant(-0), expected: .constant(Int.max)),

      (operand1: .constant(0), operand2: .constant(Int.min), expected: .constant(Int.min)),
      (operand1: .constant(-0), operand2: .constant(Int.min), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .constant(0), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .constant(-0), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.added(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testAddedConstantToConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(Int.max), operand2: .constant(1)),
      (operand1: .constant(1), operand2: .constant(Int.max)),

      (operand1: .constant(Int.min), operand2: .constant(-1)),
      (operand1: .constant(-1), operand2: .constant(Int.min)),
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

  func testAddedConstantToRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(2), operand2: .roll(1, 1), expected: .constant(3)),
      (operand1: .constant(-2), operand2: .roll(1, 1), expected: .constant(-1)),
      (operand1: .constant(2), operand2: .roll(-1, 1), expected: .constant(1)),
      (operand1: .constant(-2), operand2: .roll(-1, 1), expected: .constant(-3)),

      (operand1: .constant(0), operand2: .roll(1, 1), expected: .constant(1)),
      (operand1: .constant(-0), operand2: .roll(1, 1), expected: .constant(1)),
      (operand1: .constant(0), operand2: .roll(-1, 1), expected: .constant(-1)),
      (operand1: .constant(-0), operand2: .roll(-1, 1), expected: .constant(-1)),

      (operand1: .constant(Int.max), operand2: .roll(0, 0), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .roll(-0, 0), expected: .constant(Int.max)),
      (operand1: .constant(Int.min), operand2: .roll(0, 0), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .roll(-0, 0), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.added(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testAddedConstantToRollWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(Int.max), operand2: .roll(1, 1)),
      (operand1: .constant(Int.min), operand2: .roll(-1, 1)),
      (operand1: .constant(0), operand2: .roll(1, Int.min)),
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

  func testAddedRollToConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .constant(2), expected: .constant(3)),
      (operand1: .roll(-1, 1), operand2: .constant(2), expected: .constant(1)),
      (operand1: .roll(1, 1), operand2: .constant(-2), expected: .constant(-1)),
      (operand1: .roll(-1, 1), operand2: .constant(-2), expected: .constant(-3)),

      (operand1: .roll(1, 1), operand2: .constant(0), expected: .constant(1)),
      (operand1: .roll(-1, 1), operand2: .constant(0), expected: .constant(-1)),
      (operand1: .roll(1, 1), operand2: .constant(-0), expected: .constant(1)),
      (operand1: .roll(-1, 1), operand2: .constant(-0), expected: .constant(-1)),

      (operand1: .roll(0, 0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .roll(0, 0), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (operand1: .roll(-0, 0), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (operand1: .roll(0, 0), operand2: .constant(Int.min), expected: .constant(Int.min)),
      (operand1: .roll(-0, 0), operand2: .constant(Int.min), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.added(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testAddedRollToRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .roll(1, 1), expected: .constant(2)),
      (operand1: .roll(-1, 1), operand2: .roll(1, 1), expected: .constant(0)),
      (operand1: .roll(1, 1), operand2: .roll(-1, 1), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .roll(-1, 1), expected: .constant(-2)),

      (operand1: .roll(1, 1), operand2: .roll(0, 0), expected: .constant(1)),
      (operand1: .roll(-1, 1), operand2: .roll(0, 0), expected: .constant(-1)),
      (operand1: .roll(1, 1), operand2: .roll(-0, 0), expected: .constant(1)),
      (operand1: .roll(-1, 1), operand2: .roll(-0, 0), expected: .constant(-1)),

      (operand1: .roll(0, 0), operand2: .roll(1, 1), expected: .constant(1)),
      (operand1: .roll(-0, 0), operand2: .roll(1, 1), expected: .constant(1)),
      (operand1: .roll(0, 0), operand2: .roll(-1, 1), expected: .constant(-1)),
      (operand1: .roll(-0, 0), operand2: .roll(-1, 1), expected: .constant(-1)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .roll(-0, 0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .constant(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.added(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testAddedRollToConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .constant(Int.max)),
      (operand1: .roll(-1, 1), operand2: .constant(Int.min)),
      (operand1: .roll(1, Int.min), operand2: .constant(0)),
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

  // MARK: - Division

  func testDividedConstantByConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(1), operand2: .constant(2), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(2), expected: .constant(0)),
      (operand1: .constant(1), operand2: .constant(-2), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(-2), expected: .constant(0)),

      (operand1: .constant(2), operand2: .constant(1), expected: .constant(2)),
      (operand1: .constant(-2), operand2: .constant(1), expected: .constant(-2)),
      (operand1: .constant(2), operand2: .constant(-1), expected: .constant(-2)),
      (operand1: .constant(-2), operand2: .constant(-1), expected: .constant(2)),

      (operand1: .constant(0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .constant(0), operand2: .constant(-2), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(-2), expected: .constant(0)),

      (operand1: .constant(1), operand2: .constant(Int.max), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(Int.max), expected: .constant(0)),
      (operand1: .constant(Int.max), operand2: .constant(1), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .constant(-1), expected: .constant(-Int.max)),

      (operand1: .constant(1), operand2: .constant(Int.min), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(Int.min), expected: .constant(0)),
      (operand1: .constant(Int.min), operand2: .constant(1), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.divided(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testDividedConstantByConstantZero() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(1), operand2: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(0)),
      (operand1: .constant(1), operand2: .constant(-0)),
      (operand1: .constant(-1), operand2: .constant(-0)),

      (operand1: .constant(0), operand2: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(0)),
      (operand1: .constant(0), operand2: .constant(-0)),
      (operand1: .constant(-0), operand2: .constant(-0)),
    ]

    let expected = ExpressionError.divisionByZero

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1.divided(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDividedConstantByConstantWithOverflow() {
    let operand1 = Operand.constant(Int.min)
    let operand2 = Operand.constant(-1)
    let expected = ExpressionError.operationOverflow

    XCTAssertThrowsError(try operand1.divided(operand2)) { error in
      XCTAssertEqual(expected, error as? ExpressionError)
    }
  }

  func testDividedConstantByRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(2), operand2: .roll(1, 1), expected: .constant(2)),
      (operand1: .constant(-2), operand2: .roll(1, 1), expected: .constant(-2)),
      (operand1: .constant(2), operand2: .roll(-1, 1), expected: .constant(-2)),
      (operand1: .constant(-2), operand2: .roll(-1, 1), expected: .constant(2)),

      (operand1: .constant(Int.max), operand2: .roll(1, 1), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .roll(-1, 1), expected: .constant(-Int.max)),
      (operand1: .constant(Int.min), operand2: .roll(1, 1), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.divided(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testDividedConstantByRollWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(Int.min), operand2: .roll(-1, 1)),
      (operand1: .constant(1), operand2: .roll(1, Int.min)),
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

  func testDividedRollByConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .constant(2), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .constant(2), expected: .constant(0)),
      (operand1: .roll(1, 1), operand2: .constant(-2), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .constant(-2), expected: .constant(0)),

      (operand1: .roll(0, 0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .constant(-2), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(-2), expected: .constant(0)),

      (operand1: .roll(1, 1), operand2: .constant(Int.max), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .constant(Int.max), expected: .constant(0)),
      (operand1: .roll(1, 1), operand2: .constant(Int.min), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .constant(Int.min), expected: .constant(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.divided(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testDividedRollByConstantZero() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .constant(0)),
      (operand1: .roll(1, 1), operand2: .constant(-0)),
      (operand1: .roll(-1, 1), operand2: .constant(-0)),

      (operand1: .roll(0, 0), operand2: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(0)),
      (operand1: .roll(0, 0), operand2: .constant(-0)),
      (operand1: .roll(-0, 0), operand2: .constant(-0)),
    ]

    let expected = ExpressionError.divisionByZero

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1.divided(operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDividedRollByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, Int.min), operand2: .constant(1)),
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

  func testDividedRollByRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .roll(2, 1), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .roll(2, 1), expected: .constant(0)),
      (operand1: .roll(1, 1), operand2: .roll(-2, 1), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .roll(-2, 1), expected: .constant(0)),

      (operand1: .roll(2, 1), operand2: .roll(1, 1), expected: .constant(2)),
      (operand1: .roll(-2, 1), operand2: .roll(1, 1), expected: .constant(-2)),
      (operand1: .roll(2, 1), operand2: .roll(-1, 1), expected: .constant(-2)),
      (operand1: .roll(-2, 1), operand2: .roll(-1, 1), expected: .constant(2)),

      (operand1: .roll(0, 0), operand2: .roll(2, 1), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(2, 1), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .roll(-2, 1), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-2, 1), expected: .constant(0)),
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

  func testMultipliedConstantByConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(1), operand2: .constant(2), expected: .constant(2)),
      (operand1: .constant(-1), operand2: .constant(2), expected: .constant(-2)),
      (operand1: .constant(1), operand2: .constant(-2), expected: .constant(-2)),
      (operand1: .constant(-1), operand2: .constant(-2), expected: .constant(2)),

      (operand1: .constant(2), operand2: .constant(1), expected: .constant(2)),
      (operand1: .constant(-2), operand2: .constant(1), expected: .constant(-2)),
      (operand1: .constant(2), operand2: .constant(-1), expected: .constant(-2)),
      (operand1: .constant(-2), operand2: .constant(-1), expected: .constant(2)),

      (operand1: .constant(0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .constant(0), operand2: .constant(-2), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(-2), expected: .constant(0)),

      (operand1: .constant(1), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(1), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .constant(0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .constant(1), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (operand1: .constant(-1), operand2: .constant(Int.max), expected: .constant(-Int.max)),
      (operand1: .constant(Int.max), operand2: .constant(1), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .constant(-1), expected: .constant(-Int.max)),

      (operand1: .constant(1), operand2: .constant(Int.min), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .constant(1), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.multiplied(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultipliedConstantByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(Int.max), operand2: .constant(2)),
      (operand1: .constant(-Int.max), operand2: .constant(2)),
      (operand1: .constant(Int.max), operand2: .constant(-2)),
      (operand1: .constant(-Int.max), operand2: .constant(-2)),

      (operand1: .constant(2), operand2: .constant(Int.max)),
      (operand1: .constant(-2), operand2: .constant(Int.max)),
      (operand1: .constant(2), operand2: .constant(-Int.max)),
      (operand1: .constant(-2), operand2: .constant(-Int.max)),

      (operand1: .constant(Int.min), operand2: .constant(-1)),
      (operand1: .constant(-1), operand2: .constant(Int.min)),
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

  func testMultipliedConstantByRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(2), operand2: .roll(1, 1), expected: .constant(2)),
      (operand1: .constant(-2), operand2: .roll(1, 1), expected: .constant(-2)),
      (operand1: .constant(2), operand2: .roll(-1, 1), expected: .constant(-2)),
      (operand1: .constant(-2), operand2: .roll(-1, 1), expected: .constant(2)),

      (operand1: .constant(1), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .constant(1), operand2: .roll(-0, 0), expected: .constant(0)),
      (operand1: .constant(-1), operand2: .roll(-0, 0), expected: .constant(0)),

      (operand1: .constant(Int.max), operand2: .roll(1, 1), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .roll(-1, 1), expected: .constant(-Int.max)),
      (operand1: .constant(Int.min), operand2: .roll(1, 1), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.multiplied(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultipliedRollByConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .constant(2), expected: .constant(2)),
      (operand1: .roll(-1, 1), operand2: .constant(2), expected: .constant(-2)),
      (operand1: .roll(1, 1), operand2: .constant(-2), expected: .constant(-2)),
      (operand1: .roll(-1, 1), operand2: .constant(-2), expected: .constant(2)),

      (operand1: .roll(0, 0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(2), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .constant(-2), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(-2), expected: .constant(0)),

      (operand1: .roll(0, 0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .roll(1, 1), operand2: .constant(Int.max), expected: .constant(Int.max)),
      (operand1: .roll(-1, 1), operand2: .constant(Int.max), expected: .constant(-Int.max)),
      (operand1: .roll(1, 1), operand2: .constant(Int.min), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.multiplied(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultipliedRollByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, Int.max), operand2: .constant(Int.max)),
      (operand1: .roll(1, -Int.max), operand2: .constant(Int.max)),
      (operand1: .roll(1, Int.max), operand2: .constant(-Int.max)),
      (operand1: .roll(1, -Int.max), operand2: .constant(-Int.max)),

      (operand1: .roll(2, 1), operand2: .constant(Int.max)),
      (operand1: .roll(-2, 1), operand2: .constant(Int.max)),
      (operand1: .roll(2, 1), operand2: .constant(-Int.max)),
      (operand1: .roll(-2, 1), operand2: .constant(-Int.max)),

      (operand1: .roll(-1, 1), operand2: .constant(Int.min)),

//       Near infinite loop
//       (operand1: .roll(Int.min, 1), operand2: .constant(-1)),
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

  func testMultipliedRollByRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .roll(2, 1), expected: .constant(2)),
      (operand1: .roll(-1, 1), operand2: .roll(2, 1), expected: .constant(-2)),
      (operand1: .roll(1, 1), operand2: .roll(-2, 1), expected: .constant(-2)),
      (operand1: .roll(-1, 1), operand2: .roll(-2, 1), expected: .constant(2)),

      (operand1: .roll(2, 1), operand2: .roll(1, 1), expected: .constant(2)),
      (operand1: .roll(-2, 1), operand2: .roll(1, 1), expected: .constant(-2)),
      (operand1: .roll(2, 1), operand2: .roll(-1, 1), expected: .constant(-2)),
      (operand1: .roll(-2, 1), operand2: .roll(-1, 1), expected: .constant(2)),

      (operand1: .roll(0, 0), operand2: .roll(2, 1), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(2, 1), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .roll(-2, 1), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-2, 1), expected: .constant(0)),

      (operand1: .roll(1, 1), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(1, 1), operand2: .roll(-0, 0), expected: .constant(0)),
      (operand1: .roll(-1, 1), operand2: .roll(-0, 0), expected: .constant(0)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(0, 0), operand2: .roll(-0, 0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .constant(0)),
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

  func testSubtractedConstantByConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(1), operand2: .constant(2), expected: .constant(-1)),
      (operand1: .constant(-1), operand2: .constant(2), expected: .constant(-3)),
      (operand1: .constant(1), operand2: .constant(-2), expected: .constant(3)),
      (operand1: .constant(-1), operand2: .constant(-2), expected: .constant(1)),

      (operand1: .constant(2), operand2: .constant(1), expected: .constant(1)),
      (operand1: .constant(-2), operand2: .constant(1), expected: .constant(-3)),
      (operand1: .constant(2), operand2: .constant(-1), expected: .constant(3)),
      (operand1: .constant(-2), operand2: .constant(-1), expected: .constant(-1)),

      (operand1: .constant(0), operand2: .constant(2), expected: .constant(-2)),
      (operand1: .constant(-0), operand2: .constant(2), expected: .constant(-2)),
      (operand1: .constant(0), operand2: .constant(-2), expected: .constant(2)),
      (operand1: .constant(-0), operand2: .constant(-2), expected: .constant(2)),

      (operand1: .constant(1), operand2: .constant(0), expected: .constant(1)),
      (operand1: .constant(-1), operand2: .constant(0), expected: .constant(-1)),
      (operand1: .constant(1), operand2: .constant(-0), expected: .constant(1)),
      (operand1: .constant(-1), operand2: .constant(-0), expected: .constant(-1)),

      (operand1: .constant(0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .constant(0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .constant(-0), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .constant(Int.max), operand2: .constant(0), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .constant(-0), expected: .constant(Int.max)),
      (operand1: .constant(0), operand2: .constant(Int.max), expected: .constant(-Int.max)),
      (operand1: .constant(-0), operand2: .constant(Int.max), expected: .constant(-Int.max)),

      (operand1: .constant(Int.min), operand2: .constant(0), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .constant(-0), expected: .constant(Int.min)),
      (operand1: .constant(0), operand2: .constant(Int.min + 1), expected: .constant(Int.max)),
      (operand1: .constant(-0), operand2: .constant(Int.min + 1), expected: .constant(Int.max)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.subtracted(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractedConstantByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(Int.max), operand2: .constant(-1)),
      (operand1: .constant(-2), operand2: .constant(Int.max)),

      (operand1: .constant(Int.min), operand2: .constant(1)),
      (operand1: .constant(0), operand2: .constant(Int.min)),
      (operand1: .constant(-0), operand2: .constant(Int.min)),
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

  func testSubtractedConstantByRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(2), operand2: .roll(1, 1), expected: .constant(1)),
      (operand1: .constant(-2), operand2: .roll(1, 1), expected: .constant(-3)),
      (operand1: .constant(2), operand2: .roll(-1, 1), expected: .constant(3)),
      (operand1: .constant(-2), operand2: .roll(-1, 1), expected: .constant(-1)),

      (operand1: .constant(1), operand2: .roll(0, 0), expected: .constant(1)),
      (operand1: .constant(-1), operand2: .roll(0, 0), expected: .constant(-1)),
      (operand1: .constant(1), operand2: .roll(-0, 0), expected: .constant(1)),
      (operand1: .constant(-1), operand2: .roll(-0, 0), expected: .constant(-1)),

      (operand1: .constant(Int.max), operand2: .roll(0, 0), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .roll(-0, 0), expected: .constant(Int.max)),
      (operand1: .constant(Int.min), operand2: .roll(0, 0), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .roll(-0, 0), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.subtracted(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractedConstantByRollWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .constant(Int.max), operand2: .roll(-1, 1)),
      (operand1: .constant(Int.min), operand2: .roll(1, 1)),
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

  func testSubtractedRollByConstant() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .constant(2), expected: .constant(-1)),
      (operand1: .roll(-1, 1), operand2: .constant(2), expected: .constant(-3)),
      (operand1: .roll(1, 1), operand2: .constant(-2), expected: .constant(3)),
      (operand1: .roll(-1, 1), operand2: .constant(-2), expected: .constant(1)),

      (operand1: .roll(0, 0), operand2: .constant(2), expected: .constant(-2)),
      (operand1: .roll(-0, 0), operand2: .constant(2), expected: .constant(-2)),
      (operand1: .roll(0, 0), operand2: .constant(-2), expected: .constant(2)),
      (operand1: .roll(-0, 0), operand2: .constant(-2), expected: .constant(2)),

      (operand1: .roll(0, 0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(0), expected: .constant(0)),
      (operand1: .roll(0, -0), operand2: .constant(-0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .constant(-0), expected: .constant(0)),

      (operand1: .constant(Int.max), operand2: .roll(0, 0), expected: .constant(Int.max)),
      (operand1: .constant(Int.max), operand2: .roll(-0, 0), expected: .constant(Int.max)),
      (operand1: .constant(Int.min), operand2: .roll(0, 0), expected: .constant(Int.min)),
      (operand1: .constant(Int.min), operand2: .roll(-0, 0), expected: .constant(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.subtracted(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractedRollByConstantWithOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(-2, 1), operand2: .constant(Int.max)),

      (operand1: .roll(0, 0), operand2: .constant(Int.min)),
      (operand1: .roll(-0, 0), operand2: .constant(Int.min)),
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

  func testSubtractedRollByRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .roll(2, 1), expected: .constant(-1)),
      (operand1: .roll(-1, 1), operand2: .roll(2, 1), expected: .constant(-3)),
      (operand1: .roll(1, 1), operand2: .roll(-2, 1), expected: .constant(3)),
      (operand1: .roll(-1, 1), operand2: .roll(-2, 1), expected: .constant(1)),

      (operand1: .roll(2, 1), operand2: .roll(1, 1), expected: .constant(1)),
      (operand1: .roll(-2, 1), operand2: .roll(1, 1), expected: .constant(-3)),
      (operand1: .roll(2, 1), operand2: .roll(-1, 1), expected: .constant(3)),
      (operand1: .roll(-2, 1), operand2: .roll(-1, 1), expected: .constant(-1)),

      (operand1: .roll(0, 0), operand2: .roll(2, 1), expected: .constant(-2)),
      (operand1: .roll(-0, 0), operand2: .roll(2, 1), expected: .constant(-2)),
      (operand1: .roll(0, 0), operand2: .roll(-2, 1), expected: .constant(2)),
      (operand1: .roll(-0, 0), operand2: .roll(-2, 1), expected: .constant(2)),

      (operand1: .roll(1, 1), operand2: .roll(0, 0), expected: .constant(1)),
      (operand1: .roll(-1, 1), operand2: .roll(0, 0), expected: .constant(-1)),
      (operand1: .roll(1, 1), operand2: .roll(-0, 0), expected: .constant(1)),
      (operand1: .roll(-1, 1), operand2: .roll(-0, 0), expected: .constant(-1)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(0, 0), expected: .constant(0)),
      (operand1: .roll(0, -0), operand2: .roll(-0, 0), expected: .constant(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .constant(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.subtracted(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  // MARK: - Negation

  func testNegatedConstant() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .constant(1), expected: .constant(-1)),
      (operand: .constant(-1), expected: .constant(1)),

      (operand: .constant(0), expected: .constant(0)),
      (operand: .constant(-0), expected: .constant(0)),

      (operand: .constant(Int.max), expected: .constant(-Int.max)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated()

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegatedConstantWithOverflow() {
    let operands: [Operand] = [
      .constant(Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for operand in operands {
      XCTAssertThrowsError(try operand.negated()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testNegatedRoll() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .roll(1, 1), expected: .roll(1, -1)),
      (operand: .roll(1, -1), expected: .roll(1, 1)),
      (operand: .roll(-1, 1), expected: .roll(-1, -1)),
      (operand: .roll(-1, -1), expected: .roll(-1, 1)),

      (operand: .roll(0, 0), expected: .roll(0, 0)),
      (operand: .roll(0, -0), expected: .roll(0, 0)),
      (operand: .roll(-0, 0), expected: .roll(0, 0)),
      (operand: .roll(-0, -0), expected: .roll(0, 0)),

      (operand: .roll(Int.max, Int.max), expected: .roll(Int.max, -Int.max)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated()

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegatedRollWithOverflow() {
    let operands: [Operand] = [
      .roll(Int.min, Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for operand in operands {
      XCTAssertThrowsError(try operand.negated()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testNegatedRollNegativeSides() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .rollNegativeSides(1), expected: .rollPositiveSides(1)),
      (operand: .rollNegativeSides(-1), expected: .rollPositiveSides(-1)),

      (operand: .rollNegativeSides(0), expected: .rollPositiveSides(0)),
      (operand: .rollNegativeSides(-0), expected: .rollPositiveSides(0)),

      (operand: .rollNegativeSides(Int.max), expected: .rollPositiveSides(Int.max)),
      (operand: .rollNegativeSides(Int.min), expected: .rollPositiveSides(Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated()

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegatedRollPositiveSides() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .rollPositiveSides(1), expected: .rollNegativeSides(1)),
      (operand: .rollPositiveSides(-1), expected: .rollNegativeSides(-1)),

      (operand: .rollPositiveSides(0), expected: .rollNegativeSides(0)),
      (operand: .rollPositiveSides(-0), expected: .rollNegativeSides(0)),

      (operand: .rollPositiveSides(Int.max), expected: .rollNegativeSides(Int.max)),
      (operand: .rollPositiveSides(Int.min), expected: .rollNegativeSides(Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.negated()

      XCTAssertEqual(expected, actual)
    }
  }
}
