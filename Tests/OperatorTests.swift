@testable import Calculator
import XCTest

class OperatorTests: XCTestCase {
  func testHasPrecedence() {
    typealias Fixture = (
      operator1: String,
      operator2: String,
      value: Bool
    )

    let operatorTests: [Fixture] = [
      ("+", "+", false),
      ("+", "-", false),
      ("+", "×", false),
      ("+", "÷", false),
      ("+", "(", false),
      ("+", ")", false),

      ("-", "+", false),
      ("-", "-", false),
      ("-", "×", false),
      ("-", "÷", false),
      ("-", "(", false),
      ("-", ")", false),

      ("×", "+", true),
      ("×", "-", true),
      ("×", "×", false),
      ("×", "÷", false),
      ("×", "(", false),
      ("×", ")", false),

      ("÷", "+", true),
      ("÷", "-", true),
      ("÷", "×", false),
      ("÷", "÷", false),
      ("÷", "(", false),
      ("÷", ")", false),

      ("(", "+", true),
      ("(", "-", true),
      ("(", "×", true),
      ("(", "÷", true),
      ("(", "(", false),
      ("(", ")", false),

      (")", "+", true),
      (")", "-", true),
      (")", "×", true),
      (")", "÷", true),
      (")", "(", false),
      (")", ")", false),
    ]

    for test in operatorTests {
      let operator1 = Operator(rawValue: test.operator1)!
      let operator2 = Operator(rawValue: test.operator2)!
      let expected = test.value
      let actual = operator1.hasPrecedence(operator2)

      XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operator1: \(operator1) operator2: \(operator2)")
    }
  }
}
