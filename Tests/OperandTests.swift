@testable import Calculator
import XCTest

class OperandTests: XCTestCase {
  func testValue() {
    let expected = 42
    let operand = Operand.number(expected)
    let actual = operand.value()

    XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operand: \(operand)")
  }

  func testAddition() {
    let operand1 = Operand.number(1)
    let operand2 = Operand.number(2)
    let expected = Operand.number(3)
    let actual = operand1 + operand2

    XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operand1: \(operand1) operand2: \(operand2)")
  }

  func testDivision() {
    let operand1 = Operand.number(4)
    let operand2 = Operand.number(5)
    let expected = Operand.number(0)
    let actual = operand1 / operand2

    XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operand1: \(operand1) operand2: \(operand2)")
  }

  func testMultiplication() {
    let operand1 = Operand.number(6)
    let operand2 = Operand.number(7)
    let expected = Operand.number(42)
    let actual = operand1 * operand2

    XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operand1: \(operand1) operand2: \(operand2)")
  }

  func testSubtraction() {
    let operand1 = Operand.number(8)
    let operand2 = Operand.number(9)
    let expected = Operand.number(-1)
    let actual = operand1 - operand2

    XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operand1: \(operand1) operand2: \(operand2)")
  }
}
