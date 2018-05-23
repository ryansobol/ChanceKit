@testable import Calculator
import XCTest

class OperandTests: XCTestCase {
  func testValue() {
    let expected = 42
    let operand = Operand.number(expected)
    let actual = operand.value()

    XCTAssertEqual(expected, actual)
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
