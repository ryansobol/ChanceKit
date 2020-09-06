@testable import ChanceKit
import XCTest

class OperatorTests: XCTestCase {}

// MARK: - Markable

extension OperatorTests {
  func testDescription() {
    typealias Fixture = (
      operator: Operator,
      expected: String
    )

    let fixtures: [Fixture] = [
      (operator: .addition, expected: "+"),
      (operator: .division, expected: "÷"),
      (operator: .multiplication, expected: "×"),
      (operator: .subtraction, expected: "-"),
    ]

    for fixture in fixtures {
      let `operator` = fixture.operator
      let expected = fixture.expected
      let actual = String(describing: `operator`)

      XCTAssertEqual(expected, actual)
    }
  }
}

// MARK: - Comparison

extension OperatorTests {
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
}

// MARK: - Evaluation

extension OperatorTests {
  func testEvaluate() {
    typealias Fixture = (
      operation: Operator,
      operand1: Operand,
      operand2: Operand,
      expected: Operand
    )

    let fixtures: [Fixture] = [
      (Operator(rawValue: "+")!, .constant(1), .constant(2), .constant(3)),
      (Operator(rawValue: "-")!, .constant(5), .constant(4), .constant(1)),
      (Operator(rawValue: "×")!, .constant(6), .constant(7), .constant(42)),
      (Operator(rawValue: "÷")!, .constant(8), .constant(2), .constant(4)),
    ]

    for fixture in fixtures {
      let operation = fixture.operation
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! operation.evaluate(operand1, operand2)

      XCTAssertEqual(
        expected,
        actual,
        "operator: \(operation) operand1: \(operand1) operand2: \(operand2)"
      )
    }
  }

  func testEvaluateDivisionByZero() {
    let operation = Operator(rawValue: "÷")!
    let operand1 = Operand.constant(1)
    let operand2 = Operand.constant(0)
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
      (Operator(rawValue: "+")!, .constant(Int.max), .constant(1)),
      (Operator(rawValue: "÷")!, .constant(Int.min), .constant(-1)),
      (Operator(rawValue: "×")!, .constant(Int.min), .constant(-1)),
      (Operator(rawValue: "-")!, .constant(Int.max), .constant(-1)),
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

  func testEvaluateOperand2() {
    typealias Fixture = (
      operator: Operator,
      operand1: Constant,
      operand2: Constant,
      expected: Constant
    )

    let fixtures: [Fixture] = [
      (.addition, Constant(term: 1), Constant(term: 2), Constant(term: 3)),
      (.division, Constant(term: 8), Constant(term: 2), Constant(term: 4)),
      (.multiplication, Constant(term: 6), Constant(term: 7), Constant(term: 42)),
      (.subtraction, Constant(term: 5), Constant(term: 4), Constant(term: 1)),
    ]

    for fixture in fixtures {
      let `operator` = fixture.operator
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2
      let expected = fixture.expected
      let actual = try! `operator`.evaluate(operand1, operand2) as! Constant

      XCTAssertEqual(
        expected,
        actual,
        "operator: \(`operator`) operand1: \(operand1) operand2: \(operand2)"
      )
    }
  }

  func testEvaluateDivisionByZeroOperand2() {
    let `operator` = Operator.division
    let operand1 = Constant(term: 1)
    let operand2 = Constant(term: 0)
    let expected = ExpressionError.divisionByZero

    XCTAssertThrowsError(try `operator`.evaluate(operand1, operand2)) { error in
      XCTAssertEqual(expected, error as? ExpressionError)
    }
  }

  func testEvaluateOperationOverflowOperand2() {
    typealias Fixture = (
      operator: Operator,
      operand1: Constant,
      operand2: Constant
    )

    let fixtures: [Fixture] = [
      (.addition, Constant(term: Int.max), Constant(term: 1)),
      (.division, Constant(term: Int.min), Constant(term: -1)),
      (.multiplication, Constant(term: Int.min), Constant(term: -1)),
      (.subtraction, Constant(term: Int.max), Constant(term: -1)),
    ]

    let expected = ExpressionError.operationOverflow

    for fixture in fixtures {
      let `operator` = fixture.operator
      let operand1 = fixture.operand1
      let operand2 = fixture.operand2

      XCTAssertThrowsError(try `operator`.evaluate(operand1, operand2)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
