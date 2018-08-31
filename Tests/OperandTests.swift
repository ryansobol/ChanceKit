@testable import Calculator
import XCTest

class OperandTests: XCTestCase {
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
