@testable import Calculator
import XCTest

class OperatorTests: XCTestCase {
  func testHasLowerOrEqualPrecedence() {
    typealias Fixture = (
      operator1: String,
      operator2: String,
      value: Bool
    )

    let operatorTests: [Fixture] = [
      ("+", "+", true),
      ("+", "-", true),
      ("+", "×", true),
      ("+", "÷", true),

      ("-", "+", true),
      ("-", "-", true),
      ("-", "×", true),
      ("-", "÷", true),

      ("×", "+", false),
      ("×", "-", false),
      ("×", "×", true),
      ("×", "÷", true),

      ("÷", "+", false),
      ("÷", "-", false),
      ("÷", "×", true),
      ("÷", "÷", true),
    ]

    for test in operatorTests {
      let operator1 = Operator(rawValue: test.operator1)!
      let operator2 = Operator(rawValue: test.operator2)!
      let expected = test.value
      let actual = operator1.hasLowerOrEqualPrecedence(operator2)

      XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operator1: \(operator1) operator2: \(operator2)")
    }
  }
}
