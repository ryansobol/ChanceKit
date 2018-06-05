@testable import Calculator
import XCTest

class OperandTests: XCTestCase {
  func testNumberValue() {
    typealias Fixture = (
      number: Operand,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (.number(42), 42),
      (.number(-42), -42),
      (.number(0), 0),
      (.number(-0), 0),
      (.number(Int.max), Int.max),
      (.number(Int.min), Int.min),
    ]

    for fixture in fixtures {
      let number = fixture.number
      let expected = fixture.expected
      let actual = try! number.value()

      XCTAssertEqual(expected, actual)
    }
  }

  func testRollValue() {
    typealias Fixture = (
      times: Int,
      sides: Int,
      expected: CountableClosedRange<Int>
    )

    let fixtures: [Fixture] = [
      (times: 1, sides: 3, expected: 1...3),
      (times: 2, sides: 4, expected: 2...8),
      (times: 3, sides: 6, expected: 3...18),
      (times: 4, sides: 8, expected: 4...32),
      (times: 5, sides: 10, expected: 5...50),
      (times: 6, sides: 12, expected: 6...72),
      (times: 7, sides: 20, expected: 7...140),

      (times: -1, sides: 3, expected: -3...(-1)),
      (times: -2, sides: 4, expected: -8...(-2)),
      (times: -3, sides: 6, expected: -18...(-3)),
      (times: -4, sides: 8, expected: -32...(-4)),
      (times: -5, sides: 10, expected: -50...(-5)),
      (times: -6, sides: 12, expected: -72...(-6)),
      (times: -7, sides: 20, expected: -140...(-7)),

      (times: 1, sides: -3, expected: -3...(-1)),
      (times: 2, sides: -4, expected: -8...(-2)),
      (times: 3, sides: -6, expected: -18...(-3)),
      (times: 4, sides: -8, expected: -32...(-4)),
      (times: 5, sides: -10, expected: -50...(-5)),
      (times: 6, sides: -12, expected: -72...(-6)),
      (times: 7, sides: -20, expected: -140...(-7)),

      (times: -1, sides: -3, expected: 1...3),
      (times: -2, sides: -4, expected: 2...8),
      (times: -3, sides: -6, expected: 3...18),
      (times: -4, sides: -8, expected: 4...32),
      (times: -5, sides: -10, expected: 5...50),
      (times: -6, sides: -12, expected: 6...72),
      (times: -7, sides: -20, expected: 7...140),

      (times: 0, sides: 3, expected: 0...0),
      (times: 0, sides: 4, expected: 0...0),
      (times: 0, sides: 6, expected: 0...0),
      (times: 0, sides: 8, expected: 0...0),
      (times: 0, sides: 10, expected: 0...0),
      (times: 0, sides: 12, expected: 0...0),
      (times: 0, sides: 20, expected: 0...0),

      (times: -0, sides: 3, expected: 0...0),
      (times: -0, sides: 4, expected: 0...0),
      (times: -0, sides: 6, expected: 0...0),
      (times: -0, sides: 8, expected: 0...0),
      (times: -0, sides: 10, expected: 0...0),
      (times: -0, sides: 12, expected: 0...0),
      (times: -0, sides: 20, expected: 0...0),

      (times: 1, sides: 0, expected: 0...0),
      (times: 2, sides: 0, expected: 0...0),
      (times: 3, sides: 0, expected: 0...0),
      (times: 4, sides: 0, expected: 0...0),
      (times: 5, sides: 0, expected: 0...0),
      (times: 6, sides: 0, expected: 0...0),
      (times: 7, sides: 0, expected: 0...0),

      (times: 1, sides: -0, expected: 0...0),
      (times: 2, sides: -0, expected: 0...0),
      (times: 3, sides: -0, expected: 0...0),
      (times: 4, sides: -0, expected: 0...0),
      (times: 5, sides: -0, expected: 0...0),
      (times: 6, sides: -0, expected: 0...0),
      (times: 7, sides: -0, expected: 0...0),

      (times: 0, sides: 0, expected: 0...0),
      (times: -0, sides: 0, expected: 0...0),
      (times: 0, sides: -0, expected: 0...0),
      (times: -0, sides: -0, expected: 0...0),

      (times: 1, sides: Int.max, expected: 1...Int.max),
      (times: 1, sides: Int.min + 1, expected: (Int.min + 1)...(-1)),

//      Near infinite loops
//      (times: Int.max, sides: 1, expected: Int.max...Int.max),
//      (times: Int.min + 1, sides: 1, expected: (Int.min + 1)...(Int.min + 1)),
    ]

    for fixture in fixtures {
      let operand = Operand.roll(fixture.times, fixture.sides)
      let expected = fixture.expected
      let actual = try! operand.value()

      XCTAssertTrue(expected.contains(actual), "expected: \(expected) actual: \(actual) operand: \(operand)")
    }
  }

  func testRollValueWithOverflow() {
    typealias Fixture = (
      times: Int,
      sides: Int
    )

    let fixtures: [Fixture] = [
      (times: 1, sides: Int.min),
      (times: Int.min, sides: 4),
      (times: Int.min, sides: Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand = Operand.roll(fixture.times, fixture.sides)

      XCTAssertThrowsError(try operand.value()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testAddition() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand1: 1, operand2: 2, expected: 3),
      (operand1: -1, operand2: 2, expected: 1),
      (operand1: 1, operand2: -2, expected: -1),
      (operand1: -1, operand2: -2, expected: -3),

      (operand1: 2, operand2: 1, expected: 3),
      (operand1: -2, operand2: 1, expected: -1),
      (operand1: 2, operand2: -1, expected: 1),
      (operand1: -2, operand2: -1, expected: -3),

      (operand1: 0, operand2: 2, expected: 2),
      (operand1: -0, operand2: 2, expected: 2),
      (operand1: 0, operand2: -2, expected: -2),
      (operand1: -0, operand2: -2, expected: -2),

      (operand1: 1, operand2: 0, expected: 1),
      (operand1: -1, operand2: 0, expected: -1),
      (operand1: 1, operand2: -0, expected: 1),
      (operand1: -1, operand2: -0, expected: -1),

      (operand1: 0, operand2: 0, expected: 0),
      (operand1: -0, operand2: 0, expected: 0),
      (operand1: 0, operand2: -0, expected: 0),
      (operand1: -0, operand2: -0, expected: 0),

      (operand1: Int.max, operand2: 0, expected: Int.max),
      (operand1: -Int.max, operand2: 0, expected: Int.min + 1),
      (operand1: Int.max, operand2: -0, expected: Int.max),
      (operand1: -Int.max, operand2: -0, expected: Int.min + 1),

      (operand1: 0, operand2: Int.max, expected: Int.max),
      (operand1: -0, operand2: Int.max, expected: Int.max),
      (operand1: 0, operand2: -Int.max, expected: Int.min + 1),
      (operand1: -0, operand2: -Int.max, expected: Int.min + 1),

      (operand1: Int.min, operand2: 0, expected: Int.min),
      (operand1: Int.min, operand2: -0, expected: Int.min),

      (operand1: 0, operand2: Int.min, expected: Int.min),
      (operand1: -0, operand2: Int.min, expected: Int.min),
    ]

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)
      let expected = Operand.number(fixture.expected)
      let actual = try! operand1 + operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testAdditionWithOverflow() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int
    )

    let fixtures: [Fixture] = [
      (operand1: Int.max, operand2: 1),
      (operand1: 1, operand2: Int.max),

      (operand1: Int.min, operand2: -1),
      (operand1: -1, operand2: Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)

      XCTAssertThrowsError(try operand1 + operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDivision() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand1: 1, operand2: 2, expected: 0),
      (operand1: -1, operand2: 2, expected: 0),
      (operand1: 1, operand2: -2, expected: 0),
      (operand1: -1, operand2: -2, expected: 0),

      (operand1: 2, operand2: 1, expected: 2),
      (operand1: -2, operand2: 1, expected: -2),
      (operand1: 2, operand2: -1, expected: -2),
      (operand1: -2, operand2: -1, expected: 2),

      (operand1: 0, operand2: 2, expected: 0),
      (operand1: -0, operand2: 2, expected: 0),
      (operand1: 0, operand2: -2, expected: 0),
      (operand1: -0, operand2: -2, expected: 0),

      (operand1: Int.max, operand2: 1, expected: Int.max),
      (operand1: -Int.max, operand2: 1, expected: Int.min + 1),
      (operand1: Int.max, operand2: -1, expected: Int.min + 1),
      (operand1: -Int.max, operand2: -1, expected: Int.max),

      (operand1: 1, operand2: Int.max, expected: 0),
      (operand1: -1, operand2: Int.max, expected: 0),
      (operand1: 1, operand2: -Int.max, expected: 0),
      (operand1: -1, operand2: -Int.max, expected: 0),

      (operand1: Int.min, operand2: 1, expected: Int.min),

      (operand1: 1, operand2: Int.min, expected: 0),
      (operand1: -1, operand2: Int.min, expected: 0),
    ]

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)
      let expected = Operand.number(fixture.expected)
      let actual = try! operand1 / operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testDivisionByZero() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int
    )

    let fixtures: [Fixture] = [
      (operand1: 1, operand2: 0),
      (operand1: -1, operand2: 0),
      (operand1: 1, operand2: -0),
      (operand1: -1, operand2: -0),

      (operand1: 0, operand2: 0),
      (operand1: -0, operand2: 0),
      (operand1: 0, operand2: -0),
      (operand1: -0, operand2: -0),
    ]

    let expected = ExpressionError.divisionByZero

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)

      XCTAssertThrowsError(try operand1 / operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testDivisionWithOverflow() {
    let operand1 = Operand.number(Int.min)
    let operand2 = Operand.number(-1)
    let expected = ExpressionError.operationOverflow

    XCTAssertThrowsError(try operand1 / operand2) { error in
      XCTAssertEqual(expected, error as? ExpressionError)
    }
  }

  func testMultiplication() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand1: 6, operand2: 7, expected: 42),
      (operand1: -6, operand2: 7, expected: -42),
      (operand1: 6, operand2: -7, expected: -42),
      (operand1: -6, operand2: -7, expected: 42),

      (operand1: 7, operand2: 6, expected: 42),
      (operand1: -7, operand2: 6, expected: -42),
      (operand1: 7, operand2: -6, expected: -42),
      (operand1: -7, operand2: -6, expected: 42),

      (operand1: 0, operand2: 7, expected: 0),
      (operand1: -0, operand2: 7, expected: 0),
      (operand1: 0, operand2: -7, expected: 0),
      (operand1: -0, operand2: -7, expected: 0),

      (operand1: 6, operand2: 0, expected: 0),
      (operand1: -6, operand2: 0, expected: 0),
      (operand1: 6, operand2: -0, expected: 0),
      (operand1: -6, operand2: -0, expected: 0),

      (operand1: 0, operand2: 0, expected: 0),
      (operand1: -0, operand2: 0, expected: 0),
      (operand1: 0, operand2: -0, expected: 0),
      (operand1: -0, operand2: -0, expected: 0),

      (operand1: Int.max, operand2: 1, expected: Int.max),
      (operand1: -Int.max, operand2: 1, expected: Int.min + 1),
      (operand1: Int.max, operand2: -1, expected: Int.min + 1),
      (operand1: -Int.max, operand2: -1, expected: Int.max),

      (operand1: 1, operand2: Int.max, expected: Int.max),
      (operand1: -1, operand2: Int.max, expected: Int.min + 1),
      (operand1: 1, operand2: -Int.max, expected: Int.min + 1),
      (operand1: -1, operand2: -Int.max, expected: Int.max),

      (operand1: Int.min, operand2: 1, expected: Int.min),

      (operand1: 1, operand2: Int.min, expected: Int.min),
    ]

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)
      let expected = Operand.number(fixture.expected)
      let actual = try! operand1 * operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testMultiplicationWithOverflow() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int
    )

    let fixtures: [Fixture] = [
      (operand1: Int.max, operand2: 2),
      (operand1: -Int.max, operand2: 2),
      (operand1: Int.max, operand2: -2),
      (operand1: -Int.max, operand2: -2),

      (operand1: 2, operand2: Int.max),
      (operand1: -2, operand2: Int.max),
      (operand1: 2, operand2: -Int.max),
      (operand1: -2, operand2: -Int.max),

      (operand1: Int.min, operand2: -1),
      (operand1: -1, operand2: Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)

      XCTAssertThrowsError(try operand1 * operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testSubtraction() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int,
      expected: Int
    )

    let fixtures: [Fixture] = [
      (operand1: 1, operand2: 2, expected: -1),
      (operand1: -1, operand2: 2, expected: -3),
      (operand1: 1, operand2: -2, expected: 3),
      (operand1: -1, operand2: -2, expected: 1),

      (operand1: 2, operand2: 1, expected: 1),
      (operand1: -2, operand2: 1, expected: -3),
      (operand1: 2, operand2: -1, expected: 3),
      (operand1: -2, operand2: -1, expected: -1),

      (operand1: 0, operand2: 2, expected: -2),
      (operand1: -0, operand2: 2, expected: -2),
      (operand1: 0, operand2: -2, expected: 2),
      (operand1: -0, operand2: -2, expected: 2),

      (operand1: 1, operand2: 0, expected: 1),
      (operand1: -1, operand2: 0, expected: -1),
      (operand1: 1, operand2: -0, expected: 1),
      (operand1: -1, operand2: -0, expected: -1),

      (operand1: 0, operand2: 0, expected: 0),
      (operand1: -0, operand2: 0, expected: 0),
      (operand1: 0, operand2: -0, expected: 0),
      (operand1: -0, operand2: -0, expected: 0),

      (operand1: Int.max, operand2: 0, expected: Int.max),
      (operand1: -Int.max, operand2: 0, expected: Int.min + 1),
      (operand1: Int.max, operand2: -0, expected: Int.max),
      (operand1: -Int.max, operand2: -0, expected: Int.min + 1),

      (operand1: 0, operand2: Int.max, expected: Int.min + 1),
      (operand1: -0, operand2: Int.max, expected: Int.min + 1),
      (operand1: 0, operand2: -Int.max, expected: Int.max),
      (operand1: -0, operand2: -Int.max, expected: Int.max),

      (operand1: Int.min, operand2: 0, expected: Int.min),
      (operand1: Int.min, operand2: -0, expected: Int.min),

      (operand1: 0, operand2: Int.max, expected: Int.min + 1),
      (operand1: -0, operand2: Int.max, expected: Int.min + 1),
    ]

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)
      let expected = Operand.number(fixture.expected)
      let actual = try! operand1 - operand2

      XCTAssertEqual(expected, actual)
    }
  }

  func testSubtractionWithOverflow() {
    typealias Fixture = (
      operand1: Int,
      operand2: Int
    )

    let fixtures: [Fixture] = [
      (operand1: Int.max, operand2: -1),
      (operand1: -2, operand2: Int.max),

      (operand1: Int.min, operand2: 1),
      (operand1: 0, operand2: Int.min),
      (operand1: -0, operand2: Int.min),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operand1 = Operand.number(fixture.operand1)
      let operand2 = Operand.number(fixture.operand2)

      XCTAssertThrowsError(try operand1 - operand2) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
