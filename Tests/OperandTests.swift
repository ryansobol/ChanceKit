@testable import ChanceKit
import XCTest

class OperandTests: XCTestCase {}

// MARK - Initialization

extension OperandTests {
  func testInitWithValidRawLexeme() {
    typealias Fixture = (
      rawLexeme: String,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (rawLexeme: "0", expected: .number(0)),
      (rawLexeme: "1", expected: .number(1)),
      (rawLexeme: "9", expected: .number(9)),

      (rawLexeme: String(Int.max), expected: .number(Int.max)),

      (rawLexeme: "-0", expected: .number(-0)),
      (rawLexeme: "-1", expected: .number(-1)),
      (rawLexeme: "-9", expected: .number(-9)),

      (rawLexeme: String(Int.min), expected: .number(Int.min)),

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

      (rawLexeme: "0d", expected: .rollPositiveSides(0)),
      (rawLexeme: "1d", expected: .rollPositiveSides(1)),
      (rawLexeme: "9d", expected: .rollPositiveSides(9)),

      (rawLexeme: "\(Int.max)d", expected: .rollPositiveSides(Int.max)),

      (rawLexeme: "-0d", expected: .rollPositiveSides(-0)),
      (rawLexeme: "-1d", expected: .rollPositiveSides(-1)),
      (rawLexeme: "-9d", expected: .rollPositiveSides(-9)),

      (rawLexeme: "\(Int.min)d", expected: .rollPositiveSides(Int.min)),

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
      (operand: .number(0), expected: "0"),
      (operand: .number(Int.max), expected: String(Int.max)),
      (operand: .number(Int.min), expected: String(Int.min)),

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
  func testPushedToNumber() {
    typealias Fixture = (
      operand: Operand,
      suffix: Int,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .number(1), suffix: 0, expected: .number(10)),
      (operand: .number(21), suffix: 0, expected: .number(210)),

      (operand: .number(2), suffix: 1, expected: .number(21)),
      (operand: .number(32), suffix: 1, expected: .number(321)),

      (operand: .number(8), suffix: 9, expected: .number(89)),
      (operand: .number(78), suffix: 9, expected: .number(789)),

      (operand: .number(0), suffix: Int.max, expected: .number(Int.max)),
      (operand: .number(9), suffix: 223372036854775807, expected: .number(Int.max)),
      (operand: .number(922337203685477580), suffix: 7, expected: .number(Int.max)),

      (operand: .number(-1), suffix: 0, expected: .number(-10)),
      (operand: .number(-21), suffix: 0, expected: .number(-210)),

      (operand: .number(-2), suffix: 1, expected: .number(-21)),
      (operand: .number(-32), suffix: 1, expected: .number(-321)),

      (operand: .number(-8), suffix: 9, expected: .number(-89)),
      (operand: .number(-78), suffix: 9, expected: .number(-789)),

      (operand: .number(-9), suffix: 223372036854775808, expected: .number(Int.min)),
      (operand: .number(-922337203685477580), suffix: 8, expected: .number(Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let suffix = fixture.suffix
      let expected = fixture.expected
      let actual = try! operand.pushed(suffix)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedNumberIntoNumber() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(1), operand2: .number(0), expected: .number(10)),
      (operand1: .number(21), operand2: .number(0), expected: .number(210)),

      (operand1: .number(0), operand2: .number(1), expected: .number(1)),
      (operand1: .number(2), operand2: .number(1), expected: .number(21)),
      (operand1: .number(32), operand2: .number(1), expected: .number(321)),

      (operand1: .number(0), operand2: .number(9), expected: .number(9)),
      (operand1: .number(8), operand2: .number(9), expected: .number(89)),
      (operand1: .number(78), operand2: .number(9), expected: .number(789)),

      (operand1: .number(0), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .number(9), operand2: .number(223372036854775807), expected: .number(Int.max)),
      (operand1: .number(922337203685477580), operand2: .number(7), expected: .number(Int.max)),

      (operand1: .number(-0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(0), expected: .number(-10)),
      (operand1: .number(-21), operand2: .number(0), expected: .number(-210)),

      (operand1: .number(-0), operand2: .number(1), expected: .number(1)),
      (operand1: .number(-2), operand2: .number(1), expected: .number(-21)),
      (operand1: .number(-32), operand2: .number(1), expected: .number(-321)),

      (operand1: .number(-0), operand2: .number(9), expected: .number(9)),
      (operand1: .number(-8), operand2: .number(9), expected: .number(-89)),
      (operand1: .number(-78), operand2: .number(9), expected: .number(-789)),

      (operand1: .number(-0), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .number(-9), operand2: .number(223372036854775807), expected: .number(-Int.max)),
      (operand1: .number(-922337203685477580), operand2: .number(7), expected: .number(-Int.max)),

      (operand1: .number(0), operand2: .number(-0), expected: .number(0)),
      (operand1: .number(1), operand2: .number(-0), expected: .number(10)),
      (operand1: .number(21), operand2: .number(-0), expected: .number(210)),

      (operand1: .number(-0), operand2: .number(-0), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(-0), expected: .number(-10)),
      (operand1: .number(-21), operand2: .number(-0), expected: .number(-210)),

      (operand1: .number(-9), operand2: .number(223372036854775808), expected: .number(Int.min)),
      (operand1: .number(-922337203685477580), operand2: .number(8), expected: .number(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedToNumberWithInvalidLexeme() {
    typealias Fixture = (
      operand: Operand,
      suffix: Int
    )

    let fixtures: [Fixture] = [
      (operand: .number(1), suffix: -1),
      (operand: .number(1), suffix: Int.min),

      (operand: .number(922337203685477580), suffix: 8),
      (operand: .number(Int.max), suffix: 0),

      (operand: .number(-922337203685477580), suffix: 9),
      (operand: .number(Int.min), suffix: 0),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let suffix = fixture.suffix
      let expected = ExpressionError.invalidLexeme(String(suffix))

      XCTAssertThrowsError(try operand.pushed(suffix)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedNumberIntoNumberWithInvalidCombinationOperands() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Invalid format
      (operand1: .number(0), operand2: .number(-1)),
      (operand1: .number(2), operand2: .number(-1)),
      (operand1: .number(32), operand2: .number(-1)),

      (operand1: .number(0), operand2: .number(-9)),
      (operand1: .number(8), operand2: .number(-9)),
      (operand1: .number(78), operand2: .number(-9)),

      (operand1: .number(0), operand2: .number(Int.min)),
      (operand1: .number(9), operand2: .number(-223372036854775807)),
      (operand1: .number(922337203685477580), operand2: .number(-7)),

      (operand1: .number(-0), operand2: .number(-1)),
      (operand1: .number(-2), operand2: .number(-1)),
      (operand1: .number(-32), operand2: .number(-1)),

      (operand1: .number(-0), operand2: .number(-9)),
      (operand1: .number(-8), operand2: .number(-9)),
      (operand1: .number(-78), operand2: .number(-9)),

      (operand1: .number(-0), operand2: .number(Int.min)),
      (operand1: .number(-9), operand2: .number(-223372036854775807)),
      (operand1: .number(-922337203685477580), operand2: .number(-7)),

      // Out of range
      (operand1: .number(922337203685477580), operand2: .number(8)),
      (operand1: .number(Int.max), operand2: .number(0)),

      (operand1: .number(-922337203685477580), operand2: .number(9)),
      (operand1: .number(Int.min), operand2: .number(0)),
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

  func testPushedToRoll() {
    typealias Fixture = (
      operand: Operand,
      suffix: Int,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .rollPositiveSides(0), suffix: 0, expected: .roll(0, 0)),
      (operand: .roll(0, 1), suffix: 0, expected: .roll(0, 10)),
      (operand: .roll(0, 21), suffix: 0, expected: .roll(0, 210)),

      (operand: .rollPositiveSides(1), suffix: 1, expected: .roll(1, 1)),
      (operand: .roll(1, 2), suffix: 1, expected: .roll(1, 21)),
      (operand: .roll(1, 32), suffix: 1, expected: .roll(1, 321)),

      (operand: .rollPositiveSides(9), suffix: 9, expected: .roll(9, 9)),
      (operand: .roll(9, 8), suffix: 9, expected: .roll(9, 89)),
      (operand: .roll(9, 78), suffix: 9, expected: .roll(9, 789)),

      (operand: .rollPositiveSides(1), suffix: Int.max, expected: .roll(1, Int.max)),
      (operand: .roll(1, 0), suffix: Int.max, expected: .roll(1, Int.max)),
      (operand: .roll(1, 9), suffix: 223372036854775807, expected: .roll(1, Int.max)),
      (operand: .roll(1, 922337203685477580), suffix: 7, expected: .roll(1, Int.max)),

      (operand: .rollNegativeSides(0), suffix: 0, expected: .roll(0, -0)),
      (operand: .roll(0, -1), suffix: 0, expected: .roll(0, -10)),
      (operand: .roll(0, -21), suffix: 0, expected: .roll(0, -210)),

      (operand: .rollNegativeSides(1), suffix: 1, expected: .roll(1, -1)),
      (operand: .roll(1, -2), suffix: 1, expected: .roll(1, -21)),
      (operand: .roll(1, -32), suffix: 1, expected: .roll(1, -321)),

      (operand: .rollNegativeSides(9), suffix: 9, expected: .roll(9, -9)),
      (operand: .roll(9, -8), suffix: 9, expected: .roll(9, -89)),
      (operand: .roll(9, -78), suffix: 9, expected: .roll(9, -789)),

      (operand: .rollNegativeSides(1), suffix: Int.max, expected: .roll(1, Int.min + 1)),
      (operand: .roll(1, -9), suffix: 223372036854775808, expected: .roll(1, Int.min)),
      (operand: .roll(1, -922337203685477580), suffix: 8, expected: .roll(1, Int.min)),

      (operand: .rollPositiveSides(-0), suffix: 0, expected: .roll(-0, 0)),
      (operand: .roll(-0, 1), suffix: 0, expected: .roll(-0, 10)),
      (operand: .roll(-0, 21), suffix: 0, expected: .roll(-0, 210)),

      (operand: .rollPositiveSides(-1), suffix: 1, expected: .roll(-1, 1)),
      (operand: .roll(-1, 2), suffix: 1, expected: .roll(-1, 21)),
      (operand: .roll(-1, 32), suffix: 1, expected: .roll(-1, 321)),

      (operand: .rollPositiveSides(-9), suffix: 9, expected: .roll(-9, 9)),
      (operand: .roll(-9, 8), suffix: 9, expected: .roll(-9, 89)),
      (operand: .roll(-9, 78), suffix: 9, expected: .roll(-9, 789)),

      (operand: .rollPositiveSides(-1), suffix: Int.max, expected: .roll(-1, Int.max)),
      (operand: .roll(-1, 0), suffix: Int.max, expected: .roll(-1, Int.max)),
      (operand: .roll(-1, 9), suffix: 223372036854775807, expected: .roll(-1, Int.max)),
      (operand: .roll(-1, 922337203685477580), suffix: 7, expected: .roll(-1, Int.max)),

      (operand: .rollNegativeSides(-0), suffix: 0, expected: .roll(-0, -0)),
      (operand: .roll(-0, -1), suffix: 0, expected: .roll(-0, -10)),
      (operand: .roll(-0, -21), suffix: 0, expected: .roll(-0, -210)),

      (operand: .rollNegativeSides(-1), suffix: 1, expected: .roll(-1, -1)),
      (operand: .roll(-1, -2), suffix: 1, expected: .roll(-1, -21)),
      (operand: .roll(-1, -32), suffix: 1, expected: .roll(-1, -321)),

      (operand: .rollNegativeSides(-9), suffix: 9, expected: .roll(-9, -9)),
      (operand: .roll(-9, -8), suffix: 9, expected: .roll(-9, -89)),
      (operand: .roll(-9, -78), suffix: 9, expected: .roll(-9, -789)),

      (operand: .rollNegativeSides(-1), suffix: Int.max, expected: .roll(-1, Int.min + 1)),
      (operand: .roll(-1, -9), suffix: 223372036854775808, expected: .roll(-1, Int.min)),
      (operand: .roll(-1, -922337203685477580), suffix: 8, expected: .roll(-1, Int.min)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let suffix = fixture.suffix
      let expected = fixture.expected
      let actual = try! operand.pushed(suffix)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedNumberIntoRoll() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .rollPositiveSides(0), operand2: .number(0), expected: .roll(0, 0)),
      (operand1: .roll(0, 0), operand2: .number(0), expected: .roll(0, 0)),
      (operand1: .roll(0, 1), operand2: .number(0), expected: .roll(0, 10)),
      (operand1: .roll(0, 21), operand2: .number(0), expected: .roll(0, 210)),

      (operand1: .rollPositiveSides(1), operand2: .number(1), expected: .roll(1, 1)),
      (operand1: .roll(1, 0), operand2: .number(1), expected: .roll(1, 1)),
      (operand1: .roll(1, 2), operand2: .number(1), expected: .roll(1, 21)),
      (operand1: .roll(1, 32), operand2: .number(1), expected: .roll(1, 321)),

      (operand1: .rollPositiveSides(9), operand2: .number(9), expected: .roll(9, 9)),
      (operand1: .roll(9, 0), operand2: .number(9), expected: .roll(9, 9)),
      (operand1: .roll(9, 8), operand2: .number(9), expected: .roll(9, 89)),
      (operand1: .roll(9, 78), operand2: .number(9), expected: .roll(9, 789)),

      (operand1: .rollPositiveSides(1), operand2: .number(Int.max), expected: .roll(1, Int.max)),
      (operand1: .roll(1, 0), operand2: .number(Int.max), expected: .roll(1, Int.max)),
      (operand1: .roll(1, 9), operand2: .number(223372036854775807), expected: .roll(1, Int.max)),
      (operand1: .roll(1, 922337203685477580), operand2: .number(7), expected: .roll(1, Int.max)),

      (operand1: .rollNegativeSides(0), operand2: .number(0), expected: .roll(0, -0)),
      (operand1: .roll(0, -0), operand2: .number(0), expected: .roll(0, 0)),
      (operand1: .roll(0, -1), operand2: .number(0), expected: .roll(0, -10)),
      (operand1: .roll(0, -21), operand2: .number(0), expected: .roll(0, -210)),

      (operand1: .rollNegativeSides(1), operand2: .number(1), expected: .roll(1, -1)),
      (operand1: .roll(1, -0), operand2: .number(1), expected: .roll(1, 1)),
      (operand1: .roll(1, -2), operand2: .number(1), expected: .roll(1, -21)),
      (operand1: .roll(1, -32), operand2: .number(1), expected: .roll(1, -321)),

      (operand1: .rollNegativeSides(9), operand2: .number(9), expected: .roll(9, -9)),
      (operand1: .roll(9, -0), operand2: .number(9), expected: .roll(9, 9)),
      (operand1: .roll(9, -8), operand2: .number(9), expected: .roll(9, -89)),
      (operand1: .roll(9, -78), operand2: .number(9), expected: .roll(9, -789)),

      (operand1: .rollNegativeSides(1), operand2: .number(Int.max), expected: .roll(1, -Int.max)),
      (operand1: .roll(1, -0), operand2: .number(Int.max), expected: .roll(1, Int.max)),
      (operand1: .roll(1, -9), operand2: .number(223372036854775808), expected: .roll(1, Int.min)),
      (operand1: .roll(1, -922337203685477580), operand2: .number(8), expected: .roll(1, Int.min)),

      (operand1: .rollPositiveSides(-0), operand2: .number(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 0), operand2: .number(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 1), operand2: .number(0), expected: .roll(-0, 10)),
      (operand1: .roll(-0, 21), operand2: .number(0), expected: .roll(-0, 210)),

      (operand1: .rollPositiveSides(-1), operand2: .number(1), expected: .roll(-1, 1)),
      (operand1: .roll(-1, 0), operand2: .number(1), expected: .roll(-1, 1)),
      (operand1: .roll(-1, 2), operand2: .number(1), expected: .roll(-1, 21)),
      (operand1: .roll(-1, 32), operand2: .number(1), expected: .roll(-1, 321)),

      (operand1: .rollPositiveSides(-9), operand2: .number(9), expected: .roll(-9, 9)),
      (operand1: .roll(-9, 0), operand2: .number(9), expected: .roll(-9, 9)),
      (operand1: .roll(-9, 8), operand2: .number(9), expected: .roll(-9, 89)),
      (operand1: .roll(-9, 78), operand2: .number(9), expected: .roll(-9, 789)),

      (operand1: .rollPositiveSides(-1), operand2: .number(Int.max), expected: .roll(-1, Int.max)),
      (operand1: .roll(-1, 0), operand2: .number(Int.max), expected: .roll(-1, Int.max)),
      (operand1: .roll(-1, 9), operand2: .number(223372036854775807), expected: .roll(-1, Int.max)),
      (operand1: .roll(-1, 922337203685477580), operand2: .number(7), expected: .roll(-1, Int.max)),

      (operand1: .rollNegativeSides(-0), operand2: .number(0), expected: .roll(-0, -0)),
      (operand1: .roll(-0, -0), operand2: .number(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, -1), operand2: .number(0), expected: .roll(-0, -10)),
      (operand1: .roll(-0, -21), operand2: .number(0), expected: .roll(-0, -210)),

      (operand1: .rollNegativeSides(-1), operand2: .number(1), expected: .roll(-1, -1)),
      (operand1: .roll(-1, -0), operand2: .number(1), expected: .roll(-1, 1)),
      (operand1: .roll(-1, -2), operand2: .number(1), expected: .roll(-1, -21)),
      (operand1: .roll(-1, -32), operand2: .number(1), expected: .roll(-1, -321)),

      (operand1: .rollNegativeSides(-9), operand2: .number(9), expected: .roll(-9, -9)),
      (operand1: .roll(-9, -0), operand2: .number(9), expected: .roll(-9, 9)),
      (operand1: .roll(-9, -8), operand2: .number(9), expected: .roll(-9, -89)),
      (operand1: .roll(-9, -78), operand2: .number(9), expected: .roll(-9, -789)),

      (operand1: .rollNegativeSides(-1), operand2: .number(Int.max), expected: .roll(-1, -Int.max)),
      (operand1: .roll(-1, -0), operand2: .number(Int.max), expected: .roll(-1, Int.max)),
      (operand1: .roll(-1, -9), operand2: .number(223372036854775808), expected: .roll(-1, Int.min)),
      (operand1: .roll(-1, -922337203685477580), operand2: .number(8), expected: .roll(-1, Int.min)),

      (operand1: .rollPositiveSides(0), operand2: .number(-0), expected: .roll(0, 0)),
      (operand1: .roll(0, 0), operand2: .number(-0), expected: .roll(0, 0)),
      (operand1: .roll(0, 1), operand2: .number(-0), expected: .roll(0, 10)),
      (operand1: .roll(0, 21), operand2: .number(-0), expected: .roll(0, 210)),

      (operand1: .rollPositiveSides(1), operand2: .number(-1), expected: .roll(1, -1)),

      (operand1: .rollPositiveSides(9), operand2: .number(-9), expected: .roll(9, -9)),

      (operand1: .rollPositiveSides(1), operand2: .number(Int.min), expected: .roll(1, Int.min)),

      (operand1: .rollNegativeSides(0), operand2: .number(0), expected: .roll(0, -0)),
      (operand1: .roll(0, -0), operand2: .number(0), expected: .roll(0, 0)),
      (operand1: .roll(0, -1), operand2: .number(0), expected: .roll(0, -10)),
      (operand1: .roll(0, -21), operand2: .number(0), expected: .roll(0, -210)),

      (operand1: .rollNegativeSides(1), operand2: .number(-1), expected: .roll(1, 1)),

      (operand1: .rollNegativeSides(9), operand2: .number(-9), expected: .roll(9, 9)),

      (operand1: .rollNegativeSides(1), operand2: .number(-Int.max), expected: .roll(1, Int.max)),

      (operand1: .rollPositiveSides(-0), operand2: .number(-0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 0), operand2: .number(-0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, 1), operand2: .number(-0), expected: .roll(-0, 10)),
      (operand1: .roll(-0, 21), operand2: .number(-0), expected: .roll(-0, 210)),

      (operand1: .rollPositiveSides(-1), operand2: .number(-1), expected: .roll(-1, -1)),

      (operand1: .rollPositiveSides(-9), operand2: .number(-9), expected: .roll(-9, -9)),

      (operand1: .rollPositiveSides(-1), operand2: .number(Int.min), expected: .roll(-1, Int.min)),

      (operand1: .rollNegativeSides(-0), operand2: .number(0), expected: .roll(-0, -0)),
      (operand1: .roll(-0, -0), operand2: .number(0), expected: .roll(-0, 0)),
      (operand1: .roll(-0, -1), operand2: .number(0), expected: .roll(-0, -10)),
      (operand1: .roll(-0, -21), operand2: .number(0), expected: .roll(-0, -210)),

      (operand1: .rollNegativeSides(-1), operand2: .number(-1), expected: .roll(-1, 1)),

      (operand1: .rollNegativeSides(-9), operand2: .number(-9), expected: .roll(-9, 9)),

      (operand1: .rollNegativeSides(-1), operand2: .number(-Int.max), expected: .roll(-1, Int.max)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedToRollWithInvalidLexeme() {
    typealias Fixture = (
      operand: Operand,
      suffix: Int
    )

    let fixtures: [Fixture] = [
      (operand: .roll(2, 2), suffix: -1),
      (operand: .roll(2, 2), suffix: Int.min),

      (operand: .roll(1, 922337203685477580), suffix: 8),
      (operand: .roll(1, Int.max), suffix: 0),

      (operand: .roll(1, -922337203685477580), suffix: 9),
      (operand: .roll(1, Int.min), suffix: 0),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let suffix = fixture.suffix
      let expected = ExpressionError.invalidLexeme(String(suffix))

      XCTAssertThrowsError(try operand.pushed(suffix)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testCombinedNumberIntoRollWithInvalidCombinationOperands() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      // Invalid format
      (operand1: .roll(1, 0), operand2: .number(-1)),
      (operand1: .roll(1, 2), operand2: .number(-1)),
      (operand1: .roll(1, 32), operand2: .number(-1)),

      (operand1: .roll(9, 0), operand2: .number(-9)),
      (operand1: .roll(9, 8), operand2: .number(-9)),
      (operand1: .roll(9, 78), operand2: .number(-9)),

      (operand1: .roll(1, 0), operand2: .number(Int.min)),
      (operand1: .roll(1, 9), operand2: .number(-223372036854775808)),
      (operand1: .roll(1, 922337203685477580), operand2: .number(-8)),

      (operand1: .roll(1, -0), operand2: .number(-1)),
      (operand1: .roll(1, -2), operand2: .number(-1)),
      (operand1: .roll(1, -32), operand2: .number(-1)),

      (operand1: .roll(9, -0), operand2: .number(-9)),
      (operand1: .roll(9, -8), operand2: .number(-9)),
      (operand1: .roll(9, -78), operand2: .number(-9)),

      (operand1: .roll(1, -0), operand2: .number(Int.min)),
      (operand1: .roll(1, -9), operand2: .number(-223372036854775808)),
      (operand1: .roll(1, -922337203685477580), operand2: .number(-8)),

      (operand1: .roll(-1, 0), operand2: .number(-1)),
      (operand1: .roll(-1, 2), operand2: .number(-1)),
      (operand1: .roll(-1, 32), operand2: .number(-1)),

      (operand1: .roll(-9, 0), operand2: .number(-9)),
      (operand1: .roll(-9, 8), operand2: .number(-9)),
      (operand1: .roll(-9, 78), operand2: .number(-9)),

      (operand1: .roll(-1, 0), operand2: .number(Int.min)),
      (operand1: .roll(-1, 9), operand2: .number(-223372036854775808)),
      (operand1: .roll(-1, 922337203685477580), operand2: .number(-8)),

      (operand1: .roll(-1, -0), operand2: .number(-1)),
      (operand1: .roll(-1, -2), operand2: .number(-1)),
      (operand1: .roll(-1, -32), operand2: .number(-1)),

      (operand1: .roll(-9, -0), operand2: .number(-9)),
      (operand1: .roll(-9, -8), operand2: .number(-9)),
      (operand1: .roll(-9, -78), operand2: .number(-9)),

      (operand1: .roll(-1, -0), operand2: .number(Int.min)),
      (operand1: .roll(-1, -9), operand2: .number(-223372036854775808)),
      (operand1: .roll(-1, -922337203685477580), operand2: .number(-8)),

      // Out of range
      (operand1: .roll(1, 922337203685477580), operand2: .number(8)),
      (operand1: .roll(1, Int.max), operand2: .number(0)),

      (operand1: .roll(1, -922337203685477580), operand2: .number(9)),
      (operand1: .roll(1, Int.min), operand2: .number(0)),

      // Overflow negation
      (operand1: .rollNegativeSides(1), operand2: .number(Int.min)),
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

  func testCombinedRollIntoNumberWithInvalidCombinationOperands() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(0), operand2: .rollPositiveSides(0)),
      (operand1: .number(0), operand2: .roll(0, 0)),
      (operand1: .number(0), operand2: .roll(0, 1)),
      (operand1: .number(0), operand2: .roll(0, 21)),

      (operand1: .number(1), operand2: .rollPositiveSides(1)),
      (operand1: .number(1), operand2: .roll(1, 0)),
      (operand1: .number(1), operand2: .roll(1, 2)),
      (operand1: .number(1), operand2: .roll(1, 32)),

      (operand1: .number(9), operand2: .rollPositiveSides(9)),
      (operand1: .number(9), operand2: .roll(9, 0)),
      (operand1: .number(9), operand2: .roll(9, 8)),
      (operand1: .number(9), operand2: .roll(9, 78)),

      (operand1: .number(Int.max), operand2: .rollPositiveSides(1)),
      (operand1: .number(Int.max), operand2: .roll(1, 0)),
      (operand1: .number(922337203685477580), operand2: .roll(1, 7)),
      (operand1: .number(9), operand2: .roll(1, 223372036854775807)),

      (operand1: .number(0), operand2: .rollNegativeSides(0)),
      (operand1: .number(0), operand2: .roll(0, -0)),
      (operand1: .number(0), operand2: .roll(0, -1)),
      (operand1: .number(0), operand2: .roll(0, -21)),

      (operand1: .number(1), operand2: .rollNegativeSides(1)),
      (operand1: .number(1), operand2: .roll(1, -0)),
      (operand1: .number(1), operand2: .roll(1, -2)),
      (operand1: .number(1), operand2: .roll(1, -32)),

      (operand1: .number(9), operand2: .rollNegativeSides(9)),
      (operand1: .number(9), operand2: .roll(9, -0)),
      (operand1: .number(9), operand2: .roll(9, -8)),
      (operand1: .number(9), operand2: .roll(9, -78)),

      (operand1: .number(Int.max), operand2: .rollNegativeSides(1)),
      (operand1: .number(Int.max), operand2: .roll(1, -0)),
      (operand1: .number(922337203685477580), operand2: .roll(1, -7)),
      (operand1: .number(9), operand2: .roll(1, -223372036854775807)),

      (operand1: .number(0), operand2: .rollPositiveSides(-0)),
      (operand1: .number(0), operand2: .roll(-0, 0)),
      (operand1: .number(0), operand2: .roll(-0, 1)),
      (operand1: .number(0), operand2: .roll(-0, 21)),

      (operand1: .number(1), operand2: .rollPositiveSides(-1)),
      (operand1: .number(1), operand2: .roll(-1, 0)),
      (operand1: .number(1), operand2: .roll(-1, 2)),
      (operand1: .number(1), operand2: .roll(-1, 32)),

      (operand1: .number(9), operand2: .rollPositiveSides(-9)),
      (operand1: .number(9), operand2: .roll(-9, 0)),
      (operand1: .number(9), operand2: .roll(-9, 8)),
      (operand1: .number(9), operand2: .roll(-9, 78)),

      (operand1: .number(Int.max), operand2: .rollPositiveSides(-1)),
      (operand1: .number(Int.max), operand2: .roll(-1, 0)),
      (operand1: .number(922337203685477580), operand2: .roll(-1, 7)),
      (operand1: .number(9), operand2: .roll(-1, 223372036854775807)),

      (operand1: .number(0), operand2: .rollNegativeSides(-0)),
      (operand1: .number(0), operand2: .roll(-0, -0)),
      (operand1: .number(0), operand2: .roll(-0, -1)),
      (operand1: .number(0), operand2: .roll(-0, -21)),

      (operand1: .number(1), operand2: .rollNegativeSides(-1)),
      (operand1: .number(1), operand2: .roll(-1, -0)),
      (operand1: .number(1), operand2: .roll(-1, -2)),
      (operand1: .number(1), operand2: .roll(-1, -32)),

      (operand1: .number(9), operand2: .rollNegativeSides(-9)),
      (operand1: .number(9), operand2: .roll(-9, -0)),
      (operand1: .number(9), operand2: .roll(-9, -8)),
      (operand1: .number(9), operand2: .roll(-9, -78)),

      (operand1: .number(Int.max), operand2: .rollNegativeSides(-1)),
      (operand1: .number(Int.max), operand2: .roll(-1, -0)),
      (operand1: .number(922337203685477580), operand2: .roll(-1, -7)),
      (operand1: .number(9), operand2: .roll(-1, -223372036854775807)),

      (operand1: .number(-0), operand2: .rollPositiveSides(0)),
      (operand1: .number(-0), operand2: .roll(0, 0)),
      (operand1: .number(-0), operand2: .roll(0, 1)),
      (operand1: .number(-0), operand2: .roll(0, 21)),

      (operand1: .number(-1), operand2: .rollPositiveSides(1)),
      (operand1: .number(-1), operand2: .roll(1, 0)),
      (operand1: .number(-1), operand2: .roll(1, 2)),
      (operand1: .number(-1), operand2: .roll(1, 32)),

      (operand1: .number(-9), operand2: .rollPositiveSides(9)),
      (operand1: .number(-9), operand2: .roll(9, 0)),
      (operand1: .number(-9), operand2: .roll(9, 8)),
      (operand1: .number(-9), operand2: .roll(9, 78)),

      (operand1: .number(Int.min), operand2: .rollPositiveSides(1)),
      (operand2: .number(Int.min), operand1: .roll(1, 0)),
      (operand2: .number(-922337203685477580), operand1: .roll(1, 8)),
      (operand2: .number(-9), operand1: .roll(1, 223372036854775808)),

      (operand1: .number(0), operand2: .rollNegativeSides(0)),
      (operand1: .number(0), operand2: .roll(0, -0)),
      (operand1: .number(0), operand2: .roll(0, -1)),
      (operand1: .number(0), operand2: .roll(0, -21)),

      (operand1: .number(-1), operand2: .rollNegativeSides(1)),
      (operand1: .number(-1), operand2: .roll(1, -0)),
      (operand1: .number(-1), operand2: .roll(1, -2)),
      (operand1: .number(-1), operand2: .roll(1, -32)),

      (operand1: .number(-9), operand2: .rollNegativeSides(9)),
      (operand1: .number(-9), operand2: .roll(9, -0)),
      (operand1: .number(-9), operand2: .roll(9, -8)),
      (operand1: .number(-9), operand2: .roll(9, -78)),

      (operand1: .number(-Int.max), operand2: .rollNegativeSides(1)),
      (operand1: .number(Int.min), operand2: .roll(1, -0)),
      (operand1: .number(-922337203685477580), operand2: .roll(1, -8)),
      (operand1: .number(-9), operand2: .roll(1, -223372036854775808)),

      (operand1: .number(-0), operand2: .rollPositiveSides(-0)),
      (operand1: .number(-0), operand2: .roll(-0, 0)),
      (operand1: .number(-0), operand2: .roll(-0, 1)),
      (operand1: .number(-0), operand2: .roll(-0, 21)),

      (operand1: .number(-1), operand2: .rollPositiveSides(-1)),
      (operand1: .number(-1), operand2: .roll(-1, 0)),
      (operand1: .number(-1), operand2: .roll(-1, 2)),
      (operand1: .number(-1), operand2: .roll(-1, 32)),

      (operand1: .number(-9), operand2: .rollPositiveSides(-9)),
      (operand1: .number(-9), operand2: .roll(-9, 0)),
      (operand1: .number(-9), operand2: .roll(-9, 8)),
      (operand1: .number(-9), operand2: .roll(-9, 78)),

      (operand1: .number(Int.min), operand2: .rollPositiveSides(-1)),
      (operand1: .number(Int.min), operand2: .roll(-1, 0)),
      (operand1: .number(-92337203685477580), operand2: .roll(-1, 8)),
      (operand1: .number(-9), operand2: .roll(-1, 223372036854775808)),

      (operand1: .number(0), operand2: .rollNegativeSides(-0)),
      (operand1: .number(0), operand2: .roll(-0, -0)),
      (operand1: .number(0), operand2: .roll(-0, -1)),
      (operand1: .number(0), operand2: .roll(-0, -21)),

      (operand1: .number(-1), operand2: .rollNegativeSides(-1)),
      (operand1: .number(-1), operand2: .roll(-1, -0)),
      (operand1: .number(-1), operand2: .roll(-1, -2)),
      (operand1: .number(-1), operand2: .roll(-1, -32)),

      (operand1: .number(-9), operand2: .rollNegativeSides(-9)),
      (operand1: .number(-9), operand2: .roll(-9, -0)),
      (operand1: .number(-9), operand2: .roll(-9, -8)),
      (operand1: .number(-9), operand2: .roll(-9, -78)),

      (operand1: .number(-Int.max), operand2: .rollNegativeSides(-1)),
      (operand1: .number(Int.min), operand2: .roll(-1, -0)),
      (operand1: .number(-922337203685477580), operand2: .roll(-1, -8)),
      (operand1: .number(-9), operand2: .roll(-1, -223372036854775808)),

      (operand1: .number(9), operand2: .roll(1, 223372036854775808)),
      (operand1: .number(0), operand2: .roll(1, Int.max)),

      (operand1: .number(-9), operand2: .roll(1, -223372036854775809)),
      (operand1: .number(-0), operand2: .roll(1, Int.min)),
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

  func testCombinedRollIntoRoll() {
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
      (operand1: .rollPositiveSides(0), operand2: .roll(0, 0), expected: .roll(0, 0)),
      (operand1: .rollPositiveSides(0), operand2: .roll(0, 1), expected: .roll(0, 1)),
      (operand1: .rollPositiveSides(0), operand2: .roll(0, 21), expected: .roll(0, 21)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .roll(0, 0)),

      (operand1: .roll(0, 1), operand2: .roll(0, 1), expected: .roll(0, 1)),

      (operand1: .roll(0, 21), operand2: .roll(0, 21), expected: .roll(0, 21)),

      (
        operand1: .rollPositiveSides(1),
        operand2: .rollPositiveSides(1),
        expected: .rollPositiveSides(2)
      ),
      (operand1: .rollPositiveSides(1), operand2: .roll(1, 0), expected: .roll(2, 0)),
      (operand1: .rollPositiveSides(1), operand2: .roll(1, 2), expected: .roll(2, 2)),
      (operand1: .rollPositiveSides(1), operand2: .roll(1, 32), expected: .roll(2, 32)),

      (operand1: .roll(1, 0), operand2: .roll(1, 0), expected: .roll(2, 0)),

      (operand1: .roll(1, 2), operand2: .roll(1, 2), expected: .roll(2, 2)),

      (operand1: .roll(1, 32), operand2: .roll(1, 32), expected: .roll(2, 32)),

      (
        operand1: .rollPositiveSides(9),
        operand2: .rollPositiveSides(9),
        expected: .rollPositiveSides(18)
      ),
      (operand1: .rollPositiveSides(9), operand2: .roll(9, 0), expected: .roll(18, 0)),
      (operand1: .rollPositiveSides(9), operand2: .roll(9, 8), expected: .roll(18, 8)),
      (operand1: .rollPositiveSides(9), operand2: .roll(9, 78), expected: .roll(18, 78)),

      (operand1: .roll(9, 0), operand2: .roll(9, 0), expected: .roll(18, 0)),

      (operand1: .roll(9, 8), operand2: .roll(9, 8), expected: .roll(18, 8)),

      (operand1: .roll(9, 78), operand2: .roll(9, 78), expected: .roll(18, 78)),

      (
        operand1: .rollPositiveSides(Int.max),
        operand2: .rollPositiveSides(0),
        expected: .rollPositiveSides(Int.max)
      ),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(0, 0), expected: .roll(Int.max, 0)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(0, 1), expected: .roll(Int.max, 1)),
      (
        operand1: .rollPositiveSides(Int.max),
        operand2: .roll(0, Int.max),
        expected: .roll(Int.max, Int.max)
      ),

      (operand1: .roll(Int.max, 0), operand2: .roll(0, 0), expected: .roll(Int.max, 0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1.combined(operand2)

      XCTAssertEqual(expected, actual)
    }
  }

  func testCombinedRollIntoRollWithInvalidCombinationOperands() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(0, 0), operand2: .rollPositiveSides(0)),
      (operand1: .roll(0, 0), operand2: .roll(0, 1)),
      (operand1: .roll(0, 0), operand2: .roll(0, 21)),

      (operand1: .roll(0, 1), operand2: .rollPositiveSides(0)),
      (operand1: .roll(0, 1), operand2: .roll(0, 0)),
      (operand1: .roll(0, 1), operand2: .roll(0, 21)),

      (operand1: .roll(0, 21), operand2: .rollPositiveSides(0)),
      (operand1: .roll(0, 21), operand2: .roll(0, 0)),
      (operand1: .roll(0, 21), operand2: .roll(0, 1)),

      (operand1: .roll(1, 0), operand2: .rollPositiveSides(1)),
      (operand1: .roll(1, 0), operand2: .roll(1, 2)),
      (operand1: .roll(1, 0), operand2: .roll(1, 32)),

      (operand1: .roll(1, 2), operand2: .rollPositiveSides(1)),
      (operand1: .roll(1, 2), operand2: .roll(1, 0)),
      (operand1: .roll(1, 2), operand2: .roll(1, 32)),

      (operand1: .roll(1, 32), operand2: .rollPositiveSides(1)),
      (operand1: .roll(1, 32), operand2: .roll(1, 0)),
      (operand1: .roll(1, 32), operand2: .roll(1, 2)),

      (operand1: .roll(9, 0), operand2: .rollPositiveSides(9)),
      (operand1: .roll(9, 0), operand2: .roll(9, 8)),
      (operand1: .roll(9, 0), operand2: .roll(9, 78)),

      (operand1: .roll(9, 8), operand2: .rollPositiveSides(9)),
      (operand1: .roll(9, 8), operand2: .roll(9, 0)),
      (operand1: .roll(9, 8), operand2: .roll(9, 78)),

      (operand1: .roll(9, 78), operand2: .rollPositiveSides(9)),
      (operand1: .roll(9, 78), operand2: .roll(9, 0)),
      (operand1: .roll(9, 78), operand2: .roll(9, 8)),

      (operand1: .rollPositiveSides(Int.max), operand2: .rollPositiveSides(1)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(1, 0)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(1, 1)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(1, Int.max)),

      (operand1: .rollPositiveSides(Int.max), operand2: .rollPositiveSides(Int.max)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(Int.max, 0)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(Int.max, 1)),
      (operand1: .rollPositiveSides(Int.max), operand2: .roll(Int.max, Int.max)),

      (operand1: .roll(Int.max, 0), operand2: .rollPositiveSides(0)),
      (operand1: .roll(Int.max, 0), operand2: .roll(0, 1)),
      (operand1: .roll(Int.max, 0), operand2: .roll(0, Int.max)),

      (operand1: .roll(Int.max, 1), operand2: .rollPositiveSides(1)),
      (operand1: .roll(Int.max, 1), operand2: .roll(1, 0)),
      (operand1: .roll(Int.max, 1), operand2: .roll(1, 1)),
      (operand1: .roll(Int.max, 1), operand2: .roll(1, Int.max)),

      (operand1: .roll(Int.max, Int.max), operand2: .rollPositiveSides(Int.max)),
      (operand1: .roll(Int.max, Int.max), operand2: .roll(Int.max, 0)),
      (operand1: .roll(Int.max, Int.max), operand2: .roll(Int.max, 1)),
      (operand1: .roll(Int.max, Int.max), operand2: .roll(Int.max, Int.max)),

//      (operand1: .number(Int.max), operand2: .rollPositiveSides(1)),
//      (operand1: .number(Int.max), operand2: .roll(1, 0)),
//      (operand1: .number(922337203685477580), operand2: .roll(1, 7)),
//      (operand1: .number(9), operand2: .roll(1, 223372036854775807)),
//
//      (operand1: .number(0), operand2: .rollNegativeSides(0)),
//      (operand1: .number(0), operand2: .roll(0, -0)),
//      (operand1: .number(0), operand2: .roll(0, -1)),
//      (operand1: .number(0), operand2: .roll(0, -21)),
//
//      (operand1: .number(1), operand2: .rollNegativeSides(1)),
//      (operand1: .number(1), operand2: .roll(1, -0)),
//      (operand1: .number(1), operand2: .roll(1, -2)),
//      (operand1: .number(1), operand2: .roll(1, -32)),
//
//      (operand1: .number(9), operand2: .rollNegativeSides(9)),
//      (operand1: .number(9), operand2: .roll(9, -0)),
//      (operand1: .number(9), operand2: .roll(9, -8)),
//      (operand1: .number(9), operand2: .roll(9, -78)),
//
//      (operand1: .number(Int.max), operand2: .rollNegativeSides(1)),
//      (operand1: .number(Int.max), operand2: .roll(1, -0)),
//      (operand1: .number(922337203685477580), operand2: .roll(1, -7)),
//      (operand1: .number(9), operand2: .roll(1, -223372036854775807)),
//
//      (operand1: .number(0), operand2: .rollPositiveSides(-0)),
//      (operand1: .number(0), operand2: .roll(-0, 0)),
//      (operand1: .number(0), operand2: .roll(-0, 1)),
//      (operand1: .number(0), operand2: .roll(-0, 21)),
//
//      (operand1: .number(1), operand2: .rollPositiveSides(-1)),
//      (operand1: .number(1), operand2: .roll(-1, 0)),
//      (operand1: .number(1), operand2: .roll(-1, 2)),
//      (operand1: .number(1), operand2: .roll(-1, 32)),
//
//      (operand1: .number(9), operand2: .rollPositiveSides(-9)),
//      (operand1: .number(9), operand2: .roll(-9, 0)),
//      (operand1: .number(9), operand2: .roll(-9, 8)),
//      (operand1: .number(9), operand2: .roll(-9, 78)),
//
//      (operand1: .number(Int.max), operand2: .rollPositiveSides(-1)),
//      (operand1: .number(Int.max), operand2: .roll(-1, 0)),
//      (operand1: .number(922337203685477580), operand2: .roll(-1, 7)),
//      (operand1: .number(9), operand2: .roll(-1, 223372036854775807)),
//
//      (operand1: .number(0), operand2: .rollNegativeSides(-0)),
//      (operand1: .number(0), operand2: .roll(-0, -0)),
//      (operand1: .number(0), operand2: .roll(-0, -1)),
//      (operand1: .number(0), operand2: .roll(-0, -21)),
//
//      (operand1: .number(1), operand2: .rollNegativeSides(-1)),
//      (operand1: .number(1), operand2: .roll(-1, -0)),
//      (operand1: .number(1), operand2: .roll(-1, -2)),
//      (operand1: .number(1), operand2: .roll(-1, -32)),
//
//      (operand1: .number(9), operand2: .rollNegativeSides(-9)),
//      (operand1: .number(9), operand2: .roll(-9, -0)),
//      (operand1: .number(9), operand2: .roll(-9, -8)),
//      (operand1: .number(9), operand2: .roll(-9, -78)),
//
//      (operand1: .number(Int.max), operand2: .rollNegativeSides(-1)),
//      (operand1: .number(Int.max), operand2: .roll(-1, -0)),
//      (operand1: .number(922337203685477580), operand2: .roll(-1, -7)),
//      (operand1: .number(9), operand2: .roll(-1, -223372036854775807)),
//
//      (operand1: .number(-0), operand2: .rollPositiveSides(0)),
//      (operand1: .number(-0), operand2: .roll(0, 0)),
//      (operand1: .number(-0), operand2: .roll(0, 1)),
//      (operand1: .number(-0), operand2: .roll(0, 21)),
//
//      (operand1: .number(-1), operand2: .rollPositiveSides(1)),
//      (operand1: .number(-1), operand2: .roll(1, 0)),
//      (operand1: .number(-1), operand2: .roll(1, 2)),
//      (operand1: .number(-1), operand2: .roll(1, 32)),
//
//      (operand1: .number(-9), operand2: .rollPositiveSides(9)),
//      (operand1: .number(-9), operand2: .roll(9, 0)),
//      (operand1: .number(-9), operand2: .roll(9, 8)),
//      (operand1: .number(-9), operand2: .roll(9, 78)),
//
//      (operand1: .number(Int.min), operand2: .rollPositiveSides(1)),
//      (operand2: .number(Int.min), operand1: .roll(1, 0)),
//      (operand2: .number(-922337203685477580), operand1: .roll(1, 8)),
//      (operand2: .number(-9), operand1: .roll(1, 223372036854775808)),
//
//      (operand1: .number(0), operand2: .rollNegativeSides(0)),
//      (operand1: .number(0), operand2: .roll(0, -0)),
//      (operand1: .number(0), operand2: .roll(0, -1)),
//      (operand1: .number(0), operand2: .roll(0, -21)),
//
//      (operand1: .number(-1), operand2: .rollNegativeSides(1)),
//      (operand1: .number(-1), operand2: .roll(1, -0)),
//      (operand1: .number(-1), operand2: .roll(1, -2)),
//      (operand1: .number(-1), operand2: .roll(1, -32)),
//
//      (operand1: .number(-9), operand2: .rollNegativeSides(9)),
//      (operand1: .number(-9), operand2: .roll(9, -0)),
//      (operand1: .number(-9), operand2: .roll(9, -8)),
//      (operand1: .number(-9), operand2: .roll(9, -78)),
//
//      (operand1: .number(-Int.max), operand2: .rollNegativeSides(1)),
//      (operand1: .number(Int.min), operand2: .roll(1, -0)),
//      (operand1: .number(-922337203685477580), operand2: .roll(1, -8)),
//      (operand1: .number(-9), operand2: .roll(1, -223372036854775808)),
//
//      (operand1: .number(-0), operand2: .rollPositiveSides(-0)),
//      (operand1: .number(-0), operand2: .roll(-0, 0)),
//      (operand1: .number(-0), operand2: .roll(-0, 1)),
//      (operand1: .number(-0), operand2: .roll(-0, 21)),
//
//      (operand1: .number(-1), operand2: .rollPositiveSides(-1)),
//      (operand1: .number(-1), operand2: .roll(-1, 0)),
//      (operand1: .number(-1), operand2: .roll(-1, 2)),
//      (operand1: .number(-1), operand2: .roll(-1, 32)),
//
//      (operand1: .number(-9), operand2: .rollPositiveSides(-9)),
//      (operand1: .number(-9), operand2: .roll(-9, 0)),
//      (operand1: .number(-9), operand2: .roll(-9, 8)),
//      (operand1: .number(-9), operand2: .roll(-9, 78)),
//
//      (operand1: .number(Int.min), operand2: .rollPositiveSides(-1)),
//      (operand1: .number(Int.min), operand2: .roll(-1, 0)),
//      (operand1: .number(-92337203685477580), operand2: .roll(-1, 8)),
//      (operand1: .number(-9), operand2: .roll(-1, 223372036854775808)),
//
//      (operand1: .number(0), operand2: .rollNegativeSides(-0)),
//      (operand1: .number(0), operand2: .roll(-0, -0)),
//      (operand1: .number(0), operand2: .roll(-0, -1)),
//      (operand1: .number(0), operand2: .roll(-0, -21)),
//
//      (operand1: .number(-1), operand2: .rollNegativeSides(-1)),
//      (operand1: .number(-1), operand2: .roll(-1, -0)),
//      (operand1: .number(-1), operand2: .roll(-1, -2)),
//      (operand1: .number(-1), operand2: .roll(-1, -32)),
//
//      (operand1: .number(-9), operand2: .rollNegativeSides(-9)),
//      (operand1: .number(-9), operand2: .roll(-9, -0)),
//      (operand1: .number(-9), operand2: .roll(-9, -8)),
//      (operand1: .number(-9), operand2: .roll(-9, -78)),
//
//      (operand1: .number(-Int.max), operand2: .rollNegativeSides(-1)),
//      (operand1: .number(Int.min), operand2: .roll(-1, -0)),
//      (operand1: .number(-922337203685477580), operand2: .roll(-1, -8)),
//      (operand1: .number(-9), operand2: .roll(-1, -223372036854775808)),
//
//      (operand1: .number(9), operand2: .roll(1, 223372036854775808)),
//      (operand1: .number(0), operand2: .roll(1, Int.max)),
//
//      (operand1: .number(-9), operand2: .roll(1, -223372036854775809)),
//      (operand1: .number(-0), operand2: .roll(1, Int.min)),
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
  func testDroppedFromNumberToOperand() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand?
    )

    let fixtures: [Fixture] = [
      (operand: .number(0), expected: nil),
      (operand: .number(10), expected: Operand.number(1)),
      (operand: .number(210), expected: Operand.number(21)),

      (operand: .number(1), expected: nil),
      (operand: .number(21), expected: Operand.number(2)),
      (operand: .number(321), expected: Operand.number(32)),

      (operand: .number(9), expected: nil),
      (operand: .number(89), expected: Operand.number(8)),
      (operand: .number(789), expected: Operand.number(78)),

      (operand: .number(Int.max), expected: Operand.number(922337203685477580)),

      (operand: .number(-10), expected: Operand.number(-1)),
      (operand: .number(-210), expected: Operand.number(-21)),

      (operand: .number(-21), expected: Operand.number(-2)),
      (operand: .number(-321), expected: Operand.number(-32)),

      (operand: .number(-89), expected: Operand.number(-8)),
      (operand: .number(-789), expected: Operand.number(-78)),

      (operand: .number(Int.min), expected: Operand.number(-922337203685477580)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operand, "operand: \(operand)")
    }
  }

  func testDroppedFromNumberToOperator() {
    typealias Fixture = (
      operand: Operand,
      expected: Operator?
    )

    let fixtures: [Fixture] = [
      (operand: .number(-0), expected: nil),
      (operand: .number(-1), expected: Operator.subtraction),
      (operand: .number(-9), expected: Operator.subtraction),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = operand.dropped()

      XCTAssertEqual(expected, actual as? Operator, "operand: \(operand)")
    }
  }

  func testDroppedFromRollToOperand() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .roll(0, 0), expected: .rollPositiveSides(0)),
      (operand: .roll(0, 10), expected: .roll(0, 1)),
      (operand: .roll(0, 210), expected: .roll(0, 21)),

      (operand: .roll(1, 1), expected: .rollPositiveSides(1)),
      (operand: .roll(1, 21), expected: .roll(1, 2)),
      (operand: .roll(1, 321), expected: .roll(1, 32)),

      (operand: .roll(9, 9), expected: .rollPositiveSides(9)),
      (operand: .roll(9, 89), expected: .roll(9, 8)),
      (operand: .roll(9, 789), expected: .roll(9, 78)),

      (operand: .roll(1, Int.max), expected: .roll(1, 922337203685477580)),

      (operand: .roll(0, -0), expected: .rollPositiveSides(0)),
      (operand: .roll(0, -10), expected: .roll(0, -1)),
      (operand: .roll(0, -210), expected: .roll(0, -21)),

      (operand: .roll(1, -1), expected: .rollNegativeSides(1)),
      (operand: .roll(1, -21), expected: .roll(1, -2)),
      (operand: .roll(1, -321), expected: .roll(1, -32)),

      (operand: .roll(9, -9), expected: .rollNegativeSides(9)),
      (operand: .roll(9, -89), expected: .roll(9, -8)),
      (operand: .roll(9, -789), expected: .roll(9, -78)),

      (operand: .roll(1, Int.min), expected: .roll(1, -922337203685477580)),

      (operand: .roll(-0, 0), expected: .rollPositiveSides(-0)),
      (operand: .roll(-0, 10), expected: .roll(-0, 1)),
      (operand: .roll(-0, 210), expected: .roll(-0, 21)),

      (operand: .roll(-1, 1), expected: .rollPositiveSides(-1)),
      (operand: .roll(-1, 21), expected: .roll(-1, 2)),
      (operand: .roll(-1, 321), expected: .roll(-1, 32)),

      (operand: .roll(-9, 9), expected: .rollPositiveSides(-9)),
      (operand: .roll(-9, 89), expected: .roll(-9, 8)),
      (operand: .roll(-9, 789), expected: .roll(-9, 78)),

      (operand: .roll(-1, Int.max), expected: .roll(-1, 922337203685477580)),

      (operand: .roll(-0, -0), expected: .rollPositiveSides(0)),
      (operand: .roll(-0, -10), expected: .roll(-0, -1)),
      (operand: .roll(-0, -210), expected: .roll(-0, -21)),

      (operand: .roll(-1, -1), expected: .rollNegativeSides(-1)),
      (operand: .roll(-1, -21), expected: .roll(-1, -2)),
      (operand: .roll(-1, -321), expected: .roll(-1, -32)),

      (operand: .roll(-9, -9), expected: .rollNegativeSides(-9)),
      (operand: .roll(-9, -89), expected: .roll(-9, -8)),
      (operand: .roll(-9, -789), expected: .roll(-9, -78)),

      (operand: .roll(-1, Int.min), expected: .roll(-1, -922337203685477580)),

      (operand: .rollPositiveSides(0), expected: .number(0)),
      (operand: .rollPositiveSides(1), expected: .number(1)),
      (operand: .rollPositiveSides(9), expected: .number(9)),

      (operand: .rollPositiveSides(Int.max), expected: .number(Int.max)),

      (operand: .rollPositiveSides(-0), expected: .number(-0)),
      (operand: .rollPositiveSides(-1), expected: .number(-1)),
      (operand: .rollPositiveSides(-9), expected: .number(-9)),

      (operand: .rollPositiveSides(Int.min), expected: .number(Int.min)),

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
}

// MARK: - Evaluation

extension OperandTests {
  func testNumberValue() {
    typealias Fixture = (
      operand: Operand,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand: .number(42), expected: 42),
      (operand: .number(-42), expected: -42),
      (operand: .number(0), expected: 0),
      (operand: .number(-0), expected: 0),
      (operand: .number(Int.max), expected: Int.max),
      (operand: .number(Int.min), expected: Int.min),    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! operand.value()

      XCTAssertEqual(expected, actual)
    }
  }

  func testRollValue() {
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

      XCTAssertTrue(expected.contains(actual), "expected: \(expected) actual: \(actual) operand: \(operand)")
    }
  }

  func testRollValueWithOverflow() {
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

  func testRollWithNegativeSidesValue() {
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

  func testRollWithPositiveSidesValue() {
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
  func testAdditionWithNumbers() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(1), operand2: .number(2), expected: .number(3)),
      (operand1: .number(-1), operand2: .number(2), expected: .number(1)),
      (operand1: .number(1), operand2: .number(-2), expected: .number(-1)),
      (operand1: .number(-1), operand2: .number(-2), expected: .number(-3)),

      (operand1: .number(2), operand2: .number(1), expected: .number(3)),
      (operand1: .number(-2), operand2: .number(1), expected: .number(-1)),
      (operand1: .number(2), operand2: .number(-1), expected: .number(1)),
      (operand1: .number(-2), operand2: .number(-1), expected: .number(-3)),

      (operand1: .number(1), operand2: .number(0), expected: .number(1)),
      (operand1: .number(-1), operand2: .number(0), expected: .number(-1)),
      (operand1: .number(1), operand2: .number(-0), expected: .number(1)),
      (operand1: .number(-1), operand2: .number(-0), expected: .number(-1)),

      (operand1: .number(0), operand2: .number(1), expected: .number(1)),
      (operand1: .number(-0), operand2: .number(1), expected: .number(1)),
      (operand1: .number(0), operand2: .number(-1), expected: .number(-1)),
      (operand1: .number(-0), operand2: .number(-1), expected: .number(-1)),

      (operand1: .number(0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(0), operand2: .number(-0), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(-0), expected: .number(0)),

      (operand1: .number(0), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .number(-0), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .number(0), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .number(-0), expected: .number(Int.max)),

      (operand1: .number(0), operand2: .number(Int.min), expected: .number(Int.min)),
      (operand1: .number(-0), operand2: .number(Int.min), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .number(0), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .number(-0), expected: .number(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 + operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testAdditionWithNumbersAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.max), operand2: .number(1)),
      (operand1: .number(1), operand2: .number(Int.max)),

      (operand1: .number(Int.min), operand2: .number(-1)),
      (operand1: .number(-1), operand2: .number(Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 + operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testAdditionWithRolls() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .number(2), expected: .number(3)),
      (operand1: .roll(-1, 1), operand2: .number(2), expected: .number(1)),
      (operand1: .roll(1, 1), operand2: .number(-2), expected: .number(-1)),
      (operand1: .roll(-1, 1), operand2: .number(-2), expected: .number(-3)),

      (operand1: .number(2), operand2: .roll(1, 1), expected: .number(3)),
      (operand1: .number(-2), operand2: .roll(1, 1), expected: .number(-1)),
      (operand1: .number(2), operand2: .roll(-1, 1), expected: .number(1)),
      (operand1: .number(-2), operand2: .roll(-1, 1), expected: .number(-3)),

      (operand1: .roll(1, 1), operand2: .number(0), expected: .number(1)),
      (operand1: .roll(-1, 1), operand2: .number(0), expected: .number(-1)),
      (operand1: .roll(1, 1), operand2: .number(-0), expected: .number(1)),
      (operand1: .roll(-1, 1), operand2: .number(-0), expected: .number(-1)),

      (operand1: .number(0), operand2: .roll(1, 1), expected: .number(1)),
      (operand1: .number(-0), operand2: .roll(1, 1), expected: .number(1)),
      (operand1: .number(0), operand2: .roll(-1, 1), expected: .number(-1)),
      (operand1: .number(-0), operand2: .roll(-1, 1), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .number(0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(0), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .number(-0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(-0), expected: .number(0)),

      (operand1: .roll(0, 0), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .roll(-0, 0), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .roll(0, 0), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .roll(-0, 0), expected: .number(Int.max)),

      (operand1: .roll(0, 0), operand2: .number(Int.min), expected: .number(Int.min)),
      (operand1: .roll(-0, 0), operand2: .number(Int.min), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .roll(0, 0), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .roll(-0, 0), expected: .number(Int.min)),

      (operand1: .roll(1, 1), operand2: .roll(1, 1), expected: .number(2)),
      (operand1: .roll(-1, 1), operand2: .roll(1, 1), expected: .number(0)),
      (operand1: .roll(1, 1), operand2: .roll(-1, 1), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .roll(-1, 1), expected: .number(-2)),

      (operand1: .roll(1, 1), operand2: .roll(0, 0), expected: .number(1)),
      (operand1: .roll(-1, 1), operand2: .roll(0, 0), expected: .number(-1)),
      (operand1: .roll(1, 1), operand2: .roll(-0, 0), expected: .number(1)),
      (operand1: .roll(-1, 1), operand2: .roll(-0, 0), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .roll(1, 1), expected: .number(1)),
      (operand1: .roll(-0, 0), operand2: .roll(1, 1), expected: .number(1)),
      (operand1: .roll(0, 0), operand2: .roll(-1, 1), expected: .number(-1)),
      (operand1: .roll(-0, 0), operand2: .roll(-1, 1), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .roll(-0, 0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .number(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 + operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testAdditionWithRollsAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.max), operand2: .roll(1, 1)),
      (operand1: .roll(1, 1), operand2: .number(Int.max)),

      (operand1: .number(Int.min), operand2: .roll(-1, 1)),
      (operand1: .roll(-1, 1), operand2: .number(Int.min)),

      (operand1: .roll(1, Int.min), operand2: .number(0)),
      (operand1: .number(0), operand2: .roll(1, Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 + operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDivisionWithNumbers() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(1), operand2: .number(2), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(2), expected: .number(0)),
      (operand1: .number(1), operand2: .number(-2), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(-2), expected: .number(0)),

      (operand1: .number(2), operand2: .number(1), expected: .number(2)),
      (operand1: .number(-2), operand2: .number(1), expected: .number(-2)),
      (operand1: .number(2), operand2: .number(-1), expected: .number(-2)),
      (operand1: .number(-2), operand2: .number(-1), expected: .number(2)),

      (operand1: .number(0), operand2: .number(2), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(2), expected: .number(0)),
      (operand1: .number(0), operand2: .number(-2), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(-2), expected: .number(0)),

      (operand1: .number(1), operand2: .number(Int.max), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(Int.max), expected: .number(0)),
      (operand1: .number(Int.max), operand2: .number(1), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .number(-1), expected: .number(-Int.max)),

      (operand1: .number(1), operand2: .number(Int.min), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(Int.min), expected: .number(0)),
      (operand1: .number(Int.min), operand2: .number(1), expected: .number(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 / operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testDivisionByZeroWithNumbers() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(1), operand2: .number(0)),
      (operand1: .number(-1), operand2: .number(0)),
      (operand1: .number(1), operand2: .number(-0)),
      (operand1: .number(-1), operand2: .number(-0)),

      (operand1: .number(0), operand2: .number(0)),
      (operand1: .number(-0), operand2: .number(0)),
      (operand1: .number(0), operand2: .number(-0)),
      (operand1: .number(-0), operand2: .number(-0)),
    ]

    let expected = ExpressionError.divisionByZero

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 / operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDivisionWithNumbersAndOverflow() {
    let operand1 = Operand.number(Int.min)
    let operand2 = Operand.number(-1)
    let expected = ExpressionError.operationOverflow

    XCTAssertThrowsError(try operand1 / operand2) { error in
      XCTAssertEqual(expected, error as? ExpressionError)
    }
  }

  func testDivisionWithRolls() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .number(2), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .number(2), expected: .number(0)),
      (operand1: .roll(1, 1), operand2: .number(-2), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .number(-2), expected: .number(0)),

      (operand1: .number(2), operand2: .roll(1, 1), expected: .number(2)),
      (operand1: .number(-2), operand2: .roll(1, 1), expected: .number(-2)),
      (operand1: .number(2), operand2: .roll(-1, 1), expected: .number(-2)),
      (operand1: .number(-2), operand2: .roll(-1, 1), expected: .number(2)),

      (operand1: .roll(0, 0), operand2: .number(2), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(2), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .number(-2), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(-2), expected: .number(0)),

      (operand1: .roll(1, 1), operand2: .number(Int.max), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .number(Int.max), expected: .number(0)),
      (operand1: .number(Int.max), operand2: .roll(1, 1), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .roll(-1, 1), expected: .number(-Int.max)),

      (operand1: .roll(1, 1), operand2: .number(Int.min), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .number(Int.min), expected: .number(0)),
      (operand1: .number(Int.min), operand2: .roll(1, 1), expected: .number(Int.min)),

      (operand1: .roll(1, 1), operand2: .roll(2, 1), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .roll(2, 1), expected: .number(0)),
      (operand1: .roll(1, 1), operand2: .roll(-2, 1), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .roll(-2, 1), expected: .number(0)),

      (operand1: .roll(2, 1), operand2: .roll(1, 1), expected: .number(2)),
      (operand1: .roll(-2, 1), operand2: .roll(1, 1), expected: .number(-2)),
      (operand1: .roll(2, 1), operand2: .roll(-1, 1), expected: .number(-2)),
      (operand1: .roll(-2, 1), operand2: .roll(-1, 1), expected: .number(2)),

      (operand1: .roll(0, 0), operand2: .roll(2, 1), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(2, 1), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .roll(-2, 1), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-2, 1), expected: .number(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 / operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testDivisionByZeroWithRolls() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .number(0)),
      (operand1: .roll(-1, 1), operand2: .number(0)),
      (operand1: .roll(1, 1), operand2: .number(-0)),
      (operand1: .roll(-1, 1), operand2: .number(-0)),

      (operand1: .roll(0, 0), operand2: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(0)),
      (operand1: .roll(0, 0), operand2: .number(-0)),
      (operand1: .roll(-0, 0), operand2: .number(-0)),
    ]

    let expected = ExpressionError.divisionByZero

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 / operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDivisionWithRollsAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.min), operand2: .roll(-1, 1)),

      (operand1: .roll(1, Int.min), operand2: .number(1)),
      (operand1: .number(1), operand2: .roll(1, Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 / operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testMultiplicationWithNumbers() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(1), operand2: .number(2), expected: .number(2)),
      (operand1: .number(-1), operand2: .number(2), expected: .number(-2)),
      (operand1: .number(1), operand2: .number(-2), expected: .number(-2)),
      (operand1: .number(-1), operand2: .number(-2), expected: .number(2)),

      (operand1: .number(2), operand2: .number(1), expected: .number(2)),
      (operand1: .number(-2), operand2: .number(1), expected: .number(-2)),
      (operand1: .number(2), operand2: .number(-1), expected: .number(-2)),
      (operand1: .number(-2), operand2: .number(-1), expected: .number(2)),

      (operand1: .number(0), operand2: .number(2), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(2), expected: .number(0)),
      (operand1: .number(0), operand2: .number(-2), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(-2), expected: .number(0)),

      (operand1: .number(1), operand2: .number(0), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(0), expected: .number(0)),
      (operand1: .number(1), operand2: .number(-0), expected: .number(0)),
      (operand1: .number(-1), operand2: .number(-0), expected: .number(0)),

      (operand1: .number(0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(0), operand2: .number(-0), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(-0), expected: .number(0)),

      (operand1: .number(1), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .number(-1), operand2: .number(Int.max), expected: .number(-Int.max)),
      (operand1: .number(Int.max), operand2: .number(1), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .number(-1), expected: .number(-Int.max)),

      (operand1: .number(1), operand2: .number(Int.min), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .number(1), expected: .number(Int.min)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 * operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultiplicationWithNumbersAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.max), operand2: .number(2)),
      (operand1: .number(-Int.max), operand2: .number(2)),
      (operand1: .number(Int.max), operand2: .number(-2)),
      (operand1: .number(-Int.max), operand2: .number(-2)),

      (operand1: .number(2), operand2: .number(Int.max)),
      (operand1: .number(-2), operand2: .number(Int.max)),
      (operand1: .number(2), operand2: .number(-Int.max)),
      (operand1: .number(-2), operand2: .number(-Int.max)),

      (operand1: .number(Int.min), operand2: .number(-1)),
      (operand1: .number(-1), operand2: .number(Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 * operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testMultiplicationWithRolls() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .number(2), expected: .number(2)),
      (operand1: .roll(-1, 1), operand2: .number(2), expected: .number(-2)),
      (operand1: .roll(1, 1), operand2: .number(-2), expected: .number(-2)),
      (operand1: .roll(-1, 1), operand2: .number(-2), expected: .number(2)),

      (operand1: .number(2), operand2: .roll(1, 1), expected: .number(2)),
      (operand1: .number(-2), operand2: .roll(1, 1), expected: .number(-2)),
      (operand1: .number(2), operand2: .roll(-1, 1), expected: .number(-2)),
      (operand1: .number(-2), operand2: .roll(-1, 1), expected: .number(2)),

      (operand1: .roll(0, 0), operand2: .number(2), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(2), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .number(-2), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(-2), expected: .number(0)),

      (operand1: .number(1), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .number(-1), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .number(1), operand2: .roll(-0, 0), expected: .number(0)),
      (operand1: .number(-1), operand2: .roll(-0, 0), expected: .number(0)),

      (operand1: .roll(0, 0), operand2: .number(0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(0), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .number(-0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(-0), expected: .number(0)),

      (operand1: .roll(1, 1), operand2: .number(Int.max), expected: .number(Int.max)),
      (operand1: .roll(-1, 1), operand2: .number(Int.max), expected: .number(-Int.max)),
      (operand1: .number(Int.max), operand2: .roll(1, 1), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .roll(-1, 1), expected: .number(-Int.max)),

      (operand1: .roll(1, 1), operand2: .number(Int.min), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .roll(1, 1), expected: .number(Int.min)),

      (operand1: .roll(1, 1), operand2: .roll(2, 1), expected: .number(2)),
      (operand1: .roll(-1, 1), operand2: .roll(2, 1), expected: .number(-2)),
      (operand1: .roll(1, 1), operand2: .roll(-2, 1), expected: .number(-2)),
      (operand1: .roll(-1, 1), operand2: .roll(-2, 1), expected: .number(2)),

      (operand1: .roll(2, 1), operand2: .roll(1, 1), expected: .number(2)),
      (operand1: .roll(-2, 1), operand2: .roll(1, 1), expected: .number(-2)),
      (operand1: .roll(2, 1), operand2: .roll(-1, 1), expected: .number(-2)),
      (operand1: .roll(-2, 1), operand2: .roll(-1, 1), expected: .number(2)),

      (operand1: .roll(0, 0), operand2: .roll(2, 1), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(2, 1), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .roll(-2, 1), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-2, 1), expected: .number(0)),

      (operand1: .roll(1, 1), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(1, 1), operand2: .roll(-0, 0), expected: .number(0)),
      (operand1: .roll(-1, 1), operand2: .roll(-0, 0), expected: .number(0)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(0, 0), operand2: .roll(-0, 0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .number(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 * operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultiplicationWithRollsAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.max), operand2: .number(2)),
      (operand1: .number(-Int.max), operand2: .number(2)),
      (operand1: .number(Int.max), operand2: .number(-2)),
      (operand1: .number(-Int.max), operand2: .number(-2)),

      (operand1: .number(2), operand2: .number(Int.max)),
      (operand1: .number(-2), operand2: .number(Int.max)),
      (operand1: .number(2), operand2: .number(-Int.max)),
      (operand1: .number(-2), operand2: .number(-Int.max)),

      (operand1: .number(Int.min), operand2: .number(-1)),
      (operand1: .number(-1), operand2: .number(Int.min)),
      ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 * operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testSubtractionWithNumbers() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(1), operand2: .number(2), expected: .number(-1)),
      (operand1: .number(-1), operand2: .number(2), expected: .number(-3)),
      (operand1: .number(1), operand2: .number(-2), expected: .number(3)),
      (operand1: .number(-1), operand2: .number(-2), expected: .number(1)),

      (operand1: .number(2), operand2: .number(1), expected: .number(1)),
      (operand1: .number(-2), operand2: .number(1), expected: .number(-3)),
      (operand1: .number(2), operand2: .number(-1), expected: .number(3)),
      (operand1: .number(-2), operand2: .number(-1), expected: .number(-1)),

      (operand1: .number(0), operand2: .number(2), expected: .number(-2)),
      (operand1: .number(-0), operand2: .number(2), expected: .number(-2)),
      (operand1: .number(0), operand2: .number(-2), expected: .number(2)),
      (operand1: .number(-0), operand2: .number(-2), expected: .number(2)),

      (operand1: .number(1), operand2: .number(0), expected: .number(1)),
      (operand1: .number(-1), operand2: .number(0), expected: .number(-1)),
      (operand1: .number(1), operand2: .number(-0), expected: .number(1)),
      (operand1: .number(-1), operand2: .number(-0), expected: .number(-1)),

      (operand1: .number(0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(0), expected: .number(0)),
      (operand1: .number(0), operand2: .number(-0), expected: .number(0)),
      (operand1: .number(-0), operand2: .number(-0), expected: .number(0)),

      (operand1: .number(Int.max), operand2: .number(0), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .number(-0), expected: .number(Int.max)),
      (operand1: .number(0), operand2: .number(Int.max), expected: .number(-Int.max)),
      (operand1: .number(-0), operand2: .number(Int.max), expected: .number(-Int.max)),

      (operand1: .number(Int.min), operand2: .number(0), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .number(-0), expected: .number(Int.min)),
      (operand1: .number(0), operand2: .number(Int.min + 1), expected: .number(Int.max)),
      (operand1: .number(-0), operand2: .number(Int.min + 1), expected: .number(Int.max)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 - operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractionWithNumbersAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.max), operand2: .number(-1)),
      (operand1: .number(-2), operand2: .number(Int.max)),

      (operand1: .number(Int.min), operand2: .number(1)),
      (operand1: .number(0), operand2: .number(Int.min)),
      (operand1: .number(-0), operand2: .number(Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 - operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testSubtractionWithRolls() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .roll(1, 1), operand2: .number(2), expected: .number(-1)),
      (operand1: .roll(-1, 1), operand2: .number(2), expected: .number(-3)),
      (operand1: .roll(1, 1), operand2: .number(-2), expected: .number(3)),
      (operand1: .roll(-1, 1), operand2: .number(-2), expected: .number(1)),

      (operand1: .number(2), operand2: .roll(1, 1), expected: .number(1)),
      (operand1: .number(-2), operand2: .roll(1, 1), expected: .number(-3)),
      (operand1: .number(2), operand2: .roll(-1, 1), expected: .number(3)),
      (operand1: .number(-2), operand2: .roll(-1, 1), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .number(2), expected: .number(-2)),
      (operand1: .roll(-0, 0), operand2: .number(2), expected: .number(-2)),
      (operand1: .roll(0, 0), operand2: .number(-2), expected: .number(2)),
      (operand1: .roll(-0, 0), operand2: .number(-2), expected: .number(2)),

      (operand1: .number(1), operand2: .roll(0, 0), expected: .number(1)),
      (operand1: .number(-1), operand2: .roll(0, 0), expected: .number(-1)),
      (operand1: .number(1), operand2: .roll(-0, 0), expected: .number(1)),
      (operand1: .number(-1), operand2: .roll(-0, 0), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .number(0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(0), expected: .number(0)),
      (operand1: .roll(0, -0), operand2: .number(-0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .number(-0), expected: .number(0)),

      (operand1: .roll(0, 0), operand2: .number(Int.max), expected: .number(-Int.max)),
      (operand1: .roll(-0, 0), operand2: .number(Int.max), expected: .number(-Int.max)),
      (operand1: .number(Int.max), operand2: .roll(0, 0), expected: .number(Int.max)),
      (operand1: .number(Int.max), operand2: .roll(-0, 0), expected: .number(Int.max)),

      (operand1: .roll(0, 0), operand2: .number(Int.min + 1), expected: .number(Int.max)),
      (operand1: .roll(-0, 0), operand2: .number(Int.min + 1), expected: .number(Int.max)),
      (operand1: .number(Int.min), operand2: .roll(0, 0), expected: .number(Int.min)),
      (operand1: .number(Int.min), operand2: .roll(-0, 0), expected: .number(Int.min)),

      (operand1: .roll(1, 1), operand2: .roll(2, 1), expected: .number(-1)),
      (operand1: .roll(-1, 1), operand2: .roll(2, 1), expected: .number(-3)),
      (operand1: .roll(1, 1), operand2: .roll(-2, 1), expected: .number(3)),
      (operand1: .roll(-1, 1), operand2: .roll(-2, 1), expected: .number(1)),

      (operand1: .roll(2, 1), operand2: .roll(1, 1), expected: .number(1)),
      (operand1: .roll(-2, 1), operand2: .roll(1, 1), expected: .number(-3)),
      (operand1: .roll(2, 1), operand2: .roll(-1, 1), expected: .number(3)),
      (operand1: .roll(-2, 1), operand2: .roll(-1, 1), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .roll(2, 1), expected: .number(-2)),
      (operand1: .roll(-0, 0), operand2: .roll(2, 1), expected: .number(-2)),
      (operand1: .roll(0, 0), operand2: .roll(-2, 1), expected: .number(2)),
      (operand1: .roll(-0, 0), operand2: .roll(-2, 1), expected: .number(2)),

      (operand1: .roll(1, 1), operand2: .roll(0, 0), expected: .number(1)),
      (operand1: .roll(-1, 1), operand2: .roll(0, 0), expected: .number(-1)),
      (operand1: .roll(1, 1), operand2: .roll(-0, 0), expected: .number(1)),
      (operand1: .roll(-1, 1), operand2: .roll(-0, 0), expected: .number(-1)),

      (operand1: .roll(0, 0), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(0, 0), expected: .number(0)),
      (operand1: .roll(0, -0), operand2: .roll(-0, 0), expected: .number(0)),
      (operand1: .roll(-0, 0), operand2: .roll(-0, 0), expected: .number(0)),
    ]

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operand1 - operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractionWithRollsAndOverflow() {
    typealias Fixture = (
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (operand1: .number(Int.max), operand2: .roll(-1, 1)),
      (operand1: .roll(-2, 1), operand2: .number(Int.max)),

      (operand1: .number(Int.min), operand2: .roll(1, 1)),
      (operand1: .roll(0, 0), operand2: .number(Int.min)),
      (operand1: .roll(-0, 0), operand2: .number(Int.min)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operand1 - operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testNegationWithNumbers() {
    typealias Fixture = (
      operand: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (operand: .number(1), expected: .number(-1)),
      (operand: .number(-1), expected: .number(1)),

      (operand: .number(0), expected: .number(0)),
      (operand: .number(-0), expected: .number(0)),

      (operand: .number(Int.max), expected: .number(-Int.max)),
    ]

    for fixture in fixtures {
      let operand = fixture.operand
      let expected = fixture.expected
      let actual = try! -operand

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegationWithNumbersAndOverflow() {
    let operands: [Operand] = [
      .number(Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for operand in operands {
      XCTAssertThrowsError(try -operand) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testNegationWithRoll() {
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

      (operand: .rollNegativeSides(1), expected: .rollPositiveSides(1)),
      (operand: .rollNegativeSides(-1), expected: .rollPositiveSides(-1)),

      (operand: .rollNegativeSides(0), expected: .rollPositiveSides(0)),
      (operand: .rollNegativeSides(-0), expected: .rollPositiveSides(0)),

      (operand: .rollNegativeSides(Int.max), expected: .rollPositiveSides(Int.max)),
      (operand: .rollNegativeSides(Int.min), expected: .rollPositiveSides(Int.min)),

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
      let actual = try! -operand

      XCTAssertEqual(expected, actual)
    }
  }

  func testNegationWithRollAndOverflow() {
    let operands: [Operand] = [
      .roll(Int.min, Int.min)
    ]

    let expected = ExpressionError.operationOverflow

    for operand in operands {
      XCTAssertThrowsError(try -operand) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
