@testable import Dice
import XCTest

class DiceExpressionTests : XCTestCase {
  typealias Fixture = (
    infixTokens: [String],
    postfixTokens: [String],
    value: Int
  )

  let fixtures: [Fixture] = [
    // MARK: - A + B
    (
      infixTokens: ["1", "+", "2"],
      postfixTokens: ["1", "2", "+"],
      value: 3
    ), (
      infixTokens: ["4", "-", "3"],
      postfixTokens: ["4", "3", "-"],
      value: 1
    ), (
      infixTokens: ["5", "*", "6"],
      postfixTokens: ["5", "6", "*"],
      value: 30
    ), (
      infixTokens: ["8", "/", "7"],
      postfixTokens: ["8", "7", "/"],
      value: 1
    ), (
      infixTokens: ["9", "×", "0"],
      postfixTokens: ["9", "0", "×"],
      value: 0
    ), (
      infixTokens: ["2", "÷", "1"],
      postfixTokens: ["2", "1", "÷"],
      value: 2
    ),

    // MARK: - A + B + C
    (
      infixTokens: ["3", "-", "1", "+", "2"],
      postfixTokens: ["3", "1", "-", "2", "+"],
      value: 4
    ), (
      infixTokens: ["5", "/", "7", "*", "6"],
      postfixTokens: ["5", "7", "/", "6", "*"],
      value: 0
    ), (
      infixTokens: ["8", "+", "0", "/", "9"],
      postfixTokens: ["8", "0", "9", "/", "+"],
      value: 8
    ), (
      infixTokens: ["2", "*", "4", "-", "1"],
      postfixTokens: ["2", "4", "*", "1", "-"],
      value: 7
    ),

    // MARK: - A + B + C + D
    (
      infixTokens: ["7", "-", "5", "-", "3", "+", "8"],
      postfixTokens: ["7", "5", "-", "3", "-", "8", "+"],
      value: 7
    ), (
      infixTokens: ["6", "/", "1", "*", "2", "*", "0"],
      postfixTokens: ["6", "1", "/", "2", "*", "0", "*"],
      value: 0
    ), (
      infixTokens: ["3", "+", "4", "/", "2", "-", "7"],
      postfixTokens: ["3", "4", "2", "/", "+", "7", "-"],
      value: -2
    ), (
      infixTokens: ["8", "-", "9", "*", "5", "/", "1"],
      postfixTokens: ["8", "9", "5", "*", "1", "/", "-"],
      value: -37
    ), (
      infixTokens: ["4", "*", "1", "/", "6", "+", "0"],
      postfixTokens: ["4", "1", "*", "6", "/", "0", "+"],
      value: 0
    ), (
      infixTokens: ["0", "/", "5", "+", "4", "*", "7"],
      postfixTokens: ["0", "5", "/", "4", "7", "*", "+"],
      value: 28
    ),

    // MARK: - (A + B)
    (
      infixTokens: ["(", "2", "+", "3", ")"],
      postfixTokens: ["2", "3", "+"],
      value: 5
    ), (
      infixTokens: ["(", "5", "-", "4", ")"],
      postfixTokens: ["5", "4", "-"],
      value: 1
    ), (
      infixTokens: ["(", "6", "*", "7", ")"],
      postfixTokens: ["6", "7", "*"],
      value: 42
    ), (
      infixTokens: ["(", "9", "/", "8", ")"],
      postfixTokens: ["9", "8", "/"],
      value: 1
    ), (
      infixTokens: ["(", "0", "×", "1", ")"],
      postfixTokens: ["0", "1", "×"],
      value: 0
    ), (
      infixTokens: ["(", "3", "÷", "2", ")"],
      postfixTokens: ["3", "2", "÷"],
      value: 1
    ),

    // MARK: - ((A + B))
    (
      infixTokens: ["(", "(", "2", "+", "3", ")", ")"],
      postfixTokens: ["2", "3", "+"],
      value: 5
    ), (
      infixTokens: ["(", "(", "5", "-", "4", ")", ")"],
      postfixTokens: ["5", "4", "-"],
      value: 1
    ), (
      infixTokens: ["(", "(", "6", "*", "7", ")", ")"],
      postfixTokens: ["6", "7", "*"],
      value: 42
    ), (
      infixTokens: ["(", "(", "9", "/", "8", ")", ")"],
      postfixTokens: ["9", "8", "/"],
      value: 1
    ), (
      infixTokens: ["(", "(", "0", "×", "1", ")", ")"],
      postfixTokens: ["0", "1", "×"],
      value: 0
    ), (
      infixTokens: ["(", "(", "3", "÷", "2", ")", ")"],
      postfixTokens: ["3", "2", "÷"],
      value: 1
    ),

    // MARK: - (A + B) + C
    (
      infixTokens: ["(", "5", "-", "4", ")", "+", "6"],
      postfixTokens: ["5", "4", "-", "6", "+"],
      value: 7
    ), (
      infixTokens: ["7", "-", "(", "9", "+", "8", ")"],
      postfixTokens: ["7", "9", "8", "+", "-"],
      value: -10
    ), (
      infixTokens: ["(", "3", "/", "1", ")", "-", "0"],
      postfixTokens: ["3", "1", "/", "0", "-"],
      value: 3
    ), (
      infixTokens: ["4", "/", "(", "2", "-", "5", ")"],
      postfixTokens: ["4", "2", "5", "-", "/"],
      value: -1
    ), (
      infixTokens: ["(", "2", "+", "8", ")", "*", "7"],
      postfixTokens: ["2", "8", "+", "7", "*"],
      value: 70
    ), (
      infixTokens: ["9", "+", "(", "0", "*", "1", ")"],
      postfixTokens: ["9", "0", "1", "*", "+"],
      value: 9
    ), (
      infixTokens: ["(", "1", "*", "3", ")", "/", "4"],
      postfixTokens: ["1", "3", "*", "4", "/"],
      value: 0
    ), (
      infixTokens: ["6", "*", "(", "7", "/", "5", ")"],
      postfixTokens: ["6", "7", "5", "/", "*"],
      value: 6
    ),

    // MARK: - ((A + B) + C)
    (
      infixTokens: ["(", "(", "5", "-", "4", ")", "+", "6", ")"],
      postfixTokens: ["5", "4", "-", "6", "+"],
      value: 7
    ), (
      infixTokens: ["(", "7", "-", "(", "9", "+", "8", ")", ")"],
      postfixTokens: ["7", "9", "8", "+", "-"],
      value: -10
    ), (
      infixTokens: ["(", "(", "3", "/", "1", ")", "-", "0", ")"],
      postfixTokens: ["3", "1", "/", "0", "-"],
      value: 3
    ), (
      infixTokens: ["(", "4", "/", "(", "2", "-", "5", ")", ")"],
      postfixTokens: ["4", "2", "5", "-", "/"],
      value: -1
    ), (
      infixTokens: ["(", "(", "2", "+", "8", ")", "*", "7", ")"],
      postfixTokens: ["2", "8", "+", "7", "*"],
      value: 70
    ), (
      infixTokens: ["(", "9", "+", "(", "0", "*", "1", ")", ")"],
      postfixTokens: ["9", "0", "1", "*", "+"],
      value: 9
    ), (
      infixTokens: ["(", "(", "1", "*", "3", ")", "/", "4", ")"],
      postfixTokens: ["1", "3", "*", "4", "/"],
      value: 0
    ), (
      infixTokens: ["(", "6", "*", "(", "7", "/", "5", ")", ")"],
      postfixTokens: ["6", "7", "5", "/", "*"],
      value: 6
    ),

    // MARK: - (A + B) + (C + D)
    (
      infixTokens: ["(", "4", "+", "1", ")", "-", "(", "8", "+", "5", ")"],
      postfixTokens: ["4", "1", "+", "8", "5", "+", "-"],
      value: -8
    ), (
      infixTokens: ["(", "2", "*", "4", ")", "/", "(", "9", "*", "7", ")"],
      postfixTokens: ["2", "4", "*", "9", "7", "*", "/"],
      value: 0
    ), (
      infixTokens: ["(", "6", "/", "1", ")", "+", "(", "8", "/", "4", ")"],
      postfixTokens: ["6", "1", "/", "8", "4", "/", "+"],
      value: 8
    ), (
      infixTokens: ["(", "3", "-", "2", ")", "*", "(", "7", "-", "5", ")"],
      postfixTokens: ["3", "2", "-", "7", "5", "-", "*"],
      value: 2
    ), (
      infixTokens: ["(", "4", "+", "8", ")", "-", "(", "1", "*", "2", ")"],
      postfixTokens: ["4", "8", "+", "1", "2", "*", "-"],
      value: 10
    ), (
      infixTokens: ["(", "5", "/", "7", ")", "+", "(", "6", "-", "9", ")"],
      postfixTokens: ["5", "7", "/", "6", "9", "-", "+"],
      value: -3
    ), (
      infixTokens: ["(", "0", "*", "9", ")", "/", "(", "3", "+", "1", ")"],
      postfixTokens: ["0", "9", "*", "3", "1", "+", "/"],
      value: 0
    ), (
      infixTokens: ["(", "2", "-", "3", ")", "*", "(", "4", "/", "5", ")"],
      postfixTokens: ["2", "3", "-", "4", "5", "/", "*"],
      value: 0
    ),

    // MARK: - (A + (B + C) + D)
    (
      infixTokens: ["(", "1", "+", "(", "9", "-", "4", ")", "-", "2", ")"],
      postfixTokens: ["1", "9", "4", "-", "+", "2", "-"],
      value: 4
    ), (
      infixTokens: ["(", "5", "*", "(", "0", "/", "3", ")", "*", "7", ")"],
      postfixTokens: ["5", "0", "3", "/", "*", "7", "*"],
      value: 0
    ), (
      infixTokens: ["(", "8", "-", "(", "4", "*", "6", ")", "+", "1", ")"],
      postfixTokens: ["8", "4", "6", "*", "-", "1", "+"],
      value: -15
    ), (
      infixTokens: ["(", "3", "/", "(", "9", "+", "2", ")", "/", "6", ")"],
      postfixTokens: ["3", "9", "2", "+", "/", "6", "/"],
      value: 0
    ), (
      infixTokens: ["(", "0", "+", "(", "3", "-", "6", ")", "*", "4", ")"],
      postfixTokens: ["0", "3", "6", "-", "4", "*", "+"],
      value: -12
    ), (
      infixTokens: ["(", "2", "*", "(", "5", "+", "8", ")", "-", "1", ")"],
      postfixTokens: ["2", "5", "8", "+", "*", "1", "-"],
      value: 25
    ), (
      infixTokens: ["(", "9", "/", "(", "7", "*", "1", ")", "+", "5", ")"],
      postfixTokens: ["9", "7", "1", "*", "/", "5", "+"],
      value: 6
    ), (
      infixTokens: ["(", "4", "-", "(", "6", "/", "5", ")", "*", "3", ")"],
      postfixTokens: ["4", "6", "5", "/", "3", "*", "-"],
      value: 1
    ),

    // MARK: - (A + B / C * (D + E) - F)
    (
      infixTokens: ["(", "1", "+", "2", "/", "3", "*", "(", "4", "+", "5", ")", "-", "6", ")"],
      postfixTokens: ["1", "2", "3", "/", "4", "5", "+", "*", "+", "6", "-"],
      value: -5
    )
  ]

  func testHasLowerOrEqualPrecedence() {
    let operatorTests = [
      ["+", "+", true],
      ["+", "-", true],
      ["+", "*", true],
      ["+", "/", true],
      ["+", "×", true],
      ["+", "÷", true],

      ["-", "+", true],
      ["-", "-", true],
      ["-", "*", true],
      ["-", "/", true],
      ["-", "×", true],
      ["-", "÷", true],

      ["*", "+", false],
      ["*", "-", false],
      ["*", "*", true],
      ["*", "/", true],
      ["*", "×", true],
      ["*", "÷", true],

      ["/", "+", false],
      ["/", "-", false],
      ["/", "*", true],
      ["/", "/", true],
      ["/", "×", true],
      ["/", "÷", true],

      ["×", "+", false],
      ["×", "-", false],
      ["×", "*", true],
      ["×", "/", true],
      ["×", "×", true],
      ["×", "÷", true],

      ["÷", "+", false],
      ["÷", "-", false],
      ["÷", "*", true],
      ["÷", "/", true],
      ["÷", "×", true],
      ["÷", "÷", true],
    ]

    let expression = DiceExpression()

    for test in operatorTests {
      let operator1 = test[0] as! String
      let operator2 = test[1] as! String
      let expected = test[2] as! Bool
      let actual = expression.hasLowerOrEqualPrecedence(operator1, operator2)

      XCTAssert(expected == actual, "expected: \(expected) actual: \(actual) operator1: \(operator1) operator2: \(operator2)")
    }
  }

  func testToPostfixTokens() {
    for fixture in fixtures {
      let expected = fixture.postfixTokens
      let expression = DiceExpression(fixture.infixTokens)

      if let actual = try? expression.toPostfixTokens() {
        XCTAssert(expected == actual, "expected: \(expected) actual: \(actual)")
      }
    }
  }

  func testEvaluate() {
    for fixture in fixtures {
      let expected = fixture.value
      let expression = DiceExpression(fixture.infixTokens)

      if let actual = try? expression.evaluate() {
        assert(expected == actual, "expected: \(expected) actual: \(actual) infixTokens: \(fixture.infixTokens)")
      }
    }
  }

  func testEvaluatePerformance() {
    self.measure {
      for fixture in fixtures {
        let expected = fixture.value
        let expression = DiceExpression(fixture.infixTokens)

        if let actual = try? expression.evaluate() {
          assert(expected == actual, "expected: \(expected) actual: \(actual) infixTokens: \(fixture.infixTokens)")
        }
      }
    }
  }
}
