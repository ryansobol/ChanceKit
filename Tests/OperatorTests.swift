@testable import Calculator
import XCTest

class OperatorTests: XCTestCase {
  func testHasPrecedence() {
    typealias Fixture = (
      operator1: String,
      operator2: String,
      expected: Bool
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
      let expected = fixture.expected
      let actual = operator1.hasPrecedence(operator2)

      XCTAssertEqual(expected, actual, "operator1: \(operator1) operator2: \(operator2)")
    }
  }

  func testEvaluate() {
    typealias Fixture = (
      operation: Operator,
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (Operator(rawValue: "+")!, .number(1), .number(2), .number(3)),
      (Operator(rawValue: "-")!, .number(5), .number(4), .number(1)),
      (Operator(rawValue: "×")!, .number(6), .number(7), .number(42)),
      (Operator(rawValue: "÷")!, .number(8), .number(2), .number(4)),
    ]

    for fixture in fixtures {
      let operation = fixture.operation
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operation.evaluate(operand1, operand2)

      XCTAssertEqual(expected, actual, "operator: \(operation) operand1: \(operand1) operand2: \(operand2)")
    }
  }

  func testEvaluateDivisionByZero() {
    let operation = Operator(rawValue: "÷")!
    let operand1 = Operand.number(1)
    let operand2 = Operand.number(0)
    let expected = ExpressionError.divisionByZero

    XCTAssertThrowsError(try operation.evaluate(operand1, operand2)) { error in
      XCTAssertEqual(expected, error as? ExpressionError)
    }
  }

  func testEvaluateOperationOverflow() {
    typealias Fixture = (
      operation: Operator,
      operand1: Operand,
      operand2: Operand
    )

    let fixtures: [Fixture] = [
      (Operator(rawValue: "+")!, .number(Int.max), .number(1)),
      (Operator(rawValue: "÷")!, .number(Int.min), .number(-1)),
      (Operator(rawValue: "×")!, .number(Int.min), .number(-1)),
      (Operator(rawValue: "-")!, .number(Int.max), .number(-1)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let operation = fixture.operation
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try operation.evaluate(operand1, operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
