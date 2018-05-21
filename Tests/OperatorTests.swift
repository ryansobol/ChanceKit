@testable import Calculator
import XCTest

class OperatorTests: XCTestCase {
  func testHasPrecedence() {
    typealias Fixture = (
      operator1: String,
      operator2: String,
      value: Bool
    )

    let fixtures: [Fixture] = [
      ("+", "+", false),
      ("+", "-", false),
      ("+", "×", false),
      ("+", "÷", false),

      ("-", "+", false),
      ("-", "-", false),
      ("-", "×", false),
      ("-", "÷", false),

      ("×", "+", true),
      ("×", "-", true),
      ("×", "×", false),
      ("×", "÷", false),

      ("÷", "+", true),
      ("÷", "-", true),
      ("÷", "×", false),
      ("÷", "÷", false),
    ]

    for fixture in fixtures {
      let operator1 = Operator(rawValue: fixture.operator1)!
      let operator2 = Operator(rawValue: fixture.operator2)!
      let expected = fixture.value
      let actual = operator1.hasPrecedence(operator2)

      XCTAssertEqual(expected, actual, "operator1: \(operator1) operator2: \(operator2)")
    }
  }

  func testEvaluate() {
    typealias Fixture = (
      operator: Operator,
      operand1: Operand,
      operand2: Operand,
      value: Operand?
    )

    let fixtures: [Fixture] = [
      (
        Operator(rawValue: "+")!,
        Operand.number(1),
        Operand.number(2),
        Operand.number(3)
      ), (
        Operator(rawValue: "-")!,
        Operand.number(5),
        Operand.number(4),
        Operand.number(1)
      ), (
        Operator(rawValue: "×")!,
        Operand.number(6),
        Operand.number(7),
        Operand.number(42)
      ), (
        Operator(rawValue: "÷")!,
        Operand.number(8),
        Operand.number(2),
        Operand.number(4)
      )
    ]

    for fixture in fixtures {
      let operation = fixture.operator
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.value
      let actual = try! operation.evaluate(operand1, operand2)

      XCTAssertEqual(expected, actual, "operator: \(operation) operand1: \(operand1) operand2: \(operand2)")
    }
  }
}
