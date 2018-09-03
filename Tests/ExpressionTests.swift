import Calculator
import XCTest

class ExpressionTests: XCTestCase {
  typealias Fixture = (
    infixTokens: [String],
    expected: Int
  )

  let fixtures: [Fixture] = [
    // MARK: - A
    ([], 0),
    (["42"], 42),

    // MARK: - A + B
    (["1", "+", "2"], 3),
    (["4", "-", "3"], 1),
    (["5", "×", "6"], 30),
    (["8", "÷", "7"], 1),
    (["9", "×", "0"], 0),
    (["2", "÷", "1"], 2),

    // MARK: - A + B + C
    (["3", "-", "1", "+", "2"], 4),
    (["5", "÷", "7", "×", "6"], 0),
    (["8", "+", "0", "÷", "9"], 8),
    (["2", "×", "4", "-", "1"], 7),

    // MARK: - A + B + C + D
    (["7", "-", "5", "-", "3", "+", "8"], 7),
    (["6", "÷", "1", "×", "2", "×", "0"], 0),
    (["3", "+", "4", "÷", "2", "-", "7"], -2),
    (["8", "-", "9", "×", "5", "÷", "1"], -37),
    (["4", "×", "1", "÷", "6", "+", "0"], 0),
    (["0", "÷", "5", "+", "4", "×", "7"], 28),

    // MARK: - (A)
    (["(", ")"], 0),
    (["(", "42", ")"], 42),

    // MARK: - (A + B)
    (["(", "2", "+", "3", ")"], 5),
    (["(", "5", "-", "4", ")"], 1),
    (["(", "6", "×", "7", ")"], 42),
    (["(", "9", "÷", "8", ")"], 1),
    (["(", "0", "×", "1", ")"], 0),
    (["(", "3", "÷", "2", ")"], 1),

    // MARK: - ((A + B))
    (["(", "(", "2", "+", "3", ")", ")"], 5),
    (["(", "(", "5", "-", "4", ")", ")"], 1),
    (["(", "(", "6", "×", "7", ")", ")"], 42),
    (["(", "(", "9", "÷", "8", ")", ")"], 1),
    (["(", "(", "0", "×", "1", ")", ")"], 0),
    (["(", "(", "3", "÷", "2", ")", ")"], 1),

    // MARK: - (A + B) + C
    (["(", "5", "-", "4", ")", "+", "6"], 7),
    (["7", "-", "(", "9", "+", "8", ")"], -10),
    (["(", "3", "÷", "1", ")", "-", "0"], 3),
    (["4", "÷", "(", "2", "-", "5", ")"], -1),
    (["(", "2", "+", "8", ")", "×", "7"], 70),
    (["9", "+", "(", "0", "×", "1", ")"], 9),
    (["(", "1", "×", "3", ")", "÷", "4"], 0),
    (["6", "×", "(", "7", "÷", "5", ")"], 6),

    // MARK: - ((A + B) + C)
    (["(", "(", "5", "-", "4", ")", "+", "6", ")"], 7),
    (["(", "7", "-", "(", "9", "+", "8", ")", ")"], -10),
    (["(", "(", "3", "÷", "1", ")", "-", "0", ")"], 3),
    (["(", "4", "÷", "(", "2", "-", "5", ")", ")"], -1),
    (["(", "(", "2", "+", "8", ")", "×", "7", ")"], 70),
    (["(", "9", "+", "(", "0", "×", "1", ")", ")"], 9),
    (["(", "(", "1", "×", "3", ")", "÷", "4", ")"], 0),
    (["(", "6", "×", "(", "7", "÷", "5", ")", ")"], 6),

    // MARK: - (A + B) + (C + D)
    (["(", "4", "+", "1", ")", "-", "(", "8", "+", "5", ")"], -8),
    (["(", "2", "×", "4", ")", "÷", "(", "9", "×", "7", ")"], 0),
    (["(", "6", "÷", "1", ")", "+", "(", "8", "÷", "4", ")"], 8),
    (["(", "3", "-", "2", ")", "×", "(", "7", "-", "5", ")"], 2),
    (["(", "4", "+", "8", ")", "-", "(", "1", "×", "2", ")"], 10),
    (["(", "5", "÷", "7", ")", "+", "(", "6", "-", "9", ")"], -3),
    (["(", "0", "×", "9", ")", "÷", "(", "3", "+", "1", ")"], 0),
    (["(", "2", "-", "3", ")", "×", "(", "4", "÷", "5", ")"], 0),

    // MARK: - (A + (B + C) + D)
    (["(", "1", "+", "(", "9", "-", "4", ")", "-", "2", ")"], 4),
    (["(", "5", "×", "(", "0", "÷", "3", ")", "×", "7", ")"], 0),
    (["(", "8", "-", "(", "4", "×", "6", ")", "+", "1", ")"], -15),
    (["(", "3", "÷", "(", "9", "+", "2", ")", "÷", "6", ")"], 0),
    (["(", "0", "+", "(", "3", "-", "6", ")", "×", "4", ")"], -12),
    (["(", "2", "×", "(", "5", "+", "8", ")", "-", "1", ")"], 25),
    (["(", "9", "÷", "(", "7", "×", "1", ")", "+", "5", ")"], 6),
    (["(", "4", "-", "(", "6", "÷", "5", ")", "×", "3", ")"], 1),

    // MARK: - (A + B / C × (D + E) - F)
    (["(", "1", "+", "2", "÷", "3", "×", "(", "4", "+", "5", ")", "-", "6", ")"], -5),
  ]

  func testInit() {
    let fixtures: [[String]] = [
      [],
      ["("],
      [")"],
      ["+"],
      ["÷"],
      ["×"],
      ["-"],
      [String(Int.max)],
      [String(Int.min)],
    ]

    for fixture in fixtures {
      XCTAssertNoThrow(try Expression(fixture))
    }
  }

  func testInitError() {
    let fixtures = [
      ["="],
      ["["],
      ["{"],
      ["<"],
      ["."],
      [","],
      ["^"],
      ["**"],
      ["&"],
      ["|"],
      ["!"],
      ["~"],
      ["..<"],
      ["..."],
      ["<<"],
      [">>"],
      ["%"],
    ]

    for fixture in fixtures {
      XCTAssertThrowsError(try Expression(fixture)) { error in
        XCTAssertEqual(ExpressionError.invalidToken(fixture[0]), error as? ExpressionError)
      }
    }
  }

  func testEvaluate() {
    for fixture in fixtures {
      let expected = fixture.expected
      let expression = try! Expression(fixture.infixTokens)
      var actual: Int? = nil

      XCTAssertNoThrow(actual = try expression.evaluate())
      XCTAssertEqual(expected, actual, "infixTokens: \(fixture.infixTokens)")
    }
  }

  func testEvaluateError() {
    typealias Fixture = (
      infixTokens: [String],
      expressionError: ExpressionError
    )

    let fixtures: [Fixture] = [
      ([")"], .missingParenthesisOpen),
      (["("], .missingParenthesisClose),
      (["+"], .missingOperand),
      (["1", "+"], .missingOperand),
      (["1", "1"], .missingOperator),
      (["1", "0", "÷"], .divisionByZero),
      (["9223372036854775807", "1", "+"], .operationOverflow),
      (["-9223372036854775808", "-1", "÷"], .operationOverflow),
      (["-9223372036854775808", "-1", "×"], .operationOverflow),
      (["9223372036854775807", "-1", "-"], .operationOverflow),
    ]

    for fixture in fixtures {
      let expression = try! Expression(fixture.infixTokens)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(fixture.expressionError, error as? ExpressionError)
      }
    }
  }

  func testEvaluatePerformance() {
    self.measure {
      for fixture in fixtures {
        let expected = fixture.expected
        let expression = try! Expression(fixture.infixTokens)
        let actual = try! expression.evaluate()

        XCTAssertEqual(expected, actual, "infixTokens: \(fixture.infixTokens)")
      }
    }
  }
}
