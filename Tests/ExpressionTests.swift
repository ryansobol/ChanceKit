import Calculator
import XCTest

class ExpressionTests: XCTestCase {}

// MARK: - Initialization

extension ExpressionTests {
  func testInitWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithParsableFixtures() {
    for fixture in parsableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidFixtures() {
    for fixture in invalidFixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.error

      XCTAssertThrowsError(try Expression([lexeme])) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Inclusion

extension ExpressionTests {
  func testPushedWithLexebleParenthesisFixtures() {
    for fixture in lexebleParenthesisFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes
      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedWithLexebleOperatorFixtures() {
    for fixture in lexebleOperatorFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes
      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedWithLexebleIntegerFixtures() {
    for fixture in lexebleIntegerFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes
      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedWithInvalidFixtures() {
    for fixture in invalidFixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.error
      let expression = try! Expression([])

      XCTAssertThrowsError(try expression.pushed(lexeme)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Exclusion

extension ExpressionTests {
  func testDropped() {
    typealias Fixture = (
      expression: Expression,
      expected: Expression
    )

    let fixtures: [Fixture] = [
      (expression: try! Expression([]), expected: try! Expression([])),

      (expression: try! Expression(["("]), expected: try! Expression([])),
      (expression: try! Expression([")"]), expected: try! Expression([])),
      (expression: try! Expression(["+"]), expected: try! Expression([])),
      (expression: try! Expression(["÷"]), expected: try! Expression([])),
      (expression: try! Expression(["×"]), expected: try! Expression([])),
      (expression: try! Expression(["-"]), expected: try! Expression([])),
      (expression: try! Expression(["0"]), expected: try! Expression([])),
      (expression: try! Expression(["1"]), expected: try! Expression([])),
      (expression: try! Expression(["9"]), expected: try! Expression([])),

      (expression: try! Expression(["(", "("]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", ")"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "+"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "÷"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "×"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "-"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "0"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "1"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "9"]), expected: try! Expression(["("])),

      (expression: try! Expression([")", "×", "("]), expected: try! Expression([")", "×"])),
      (expression: try! Expression([")", ")"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "+"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "÷"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "×"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "-"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "×", "0"]), expected: try! Expression([")", "×"])),
      (expression: try! Expression([")", "×", "1"]), expected: try! Expression([")", "×"])),
      (expression: try! Expression([")", "×", "9"]), expected: try! Expression([")", "×"])),

      (expression: try! Expression(["+", "("]), expected: try! Expression(["+"])),
      (expression: try! Expression(["+", ")"]), expected: try! Expression(["+"])),

      (expression: try! Expression(["÷", "("]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", ")"]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", "0"]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", "1"]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", "9"]), expected: try! Expression(["÷"])),

      (expression: try! Expression(["×", "("]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", ")"]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", "0"]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", "1"]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", "9"]), expected: try! Expression(["×"])),

      (expression: try! Expression(["-", "("]), expected: try! Expression(["-"])),
      (expression: try! Expression(["-", ")"]), expected: try! Expression(["-"])),
      (expression: try! Expression(["-1"]), expected: try! Expression(["-"])),
      (expression: try! Expression(["-9"]), expected: try! Expression(["-"])),

      (expression: try! Expression(["0", "×", "("]), expected: try! Expression(["0", "×"])),
      (expression: try! Expression(["0", ")"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "+"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "÷"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "×"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "-"]), expected: try! Expression(["0"])),

      (expression: try! Expression(["1", "×", "("]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", ")"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "+"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "÷"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "×"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "-"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["10"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["11"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["19"]), expected: try! Expression(["1"])),

      (expression: try! Expression(["9", "×", "("]), expected: try! Expression(["9", "×"])),
      (expression: try! Expression(["9", ")",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "+",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "÷",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "×",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "-",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "0",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "1",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "9",]), expected: try! Expression(["9"])),

      (expression: try! Expression(["1", "×", "(", "("]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", ")"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "+"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "÷"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "×"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "-"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "0"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "1"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "9"]), expected: try! Expression(["1", "×", "("])),

      (expression: try! Expression(["1", ")", "×", "("]), expected: try! Expression(["1", ")", "×"])),
      (expression: try! Expression(["1", ")", ")"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "+"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "÷"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "×"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "-"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "×", "0"]), expected: try! Expression(["1", ")", "×"])),
      (expression: try! Expression(["1", ")", "×", "1"]), expected: try! Expression(["1", ")", "×"])),
      (expression: try! Expression(["1", ")", "×", "9"]), expected: try! Expression(["1", ")", "×"])),

      (expression: try! Expression(["1", "+", "("]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", ")"]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", "0"]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", "1"]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", "9"]), expected: try! Expression(["1", "+"])),

      (expression: try! Expression(["1", "÷", "("]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", ")"]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", "0"]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", "1"]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", "9"]), expected: try! Expression(["1", "÷"])),

      (expression: try! Expression(["1", "×", "("]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", ")"]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", "0"]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", "1"]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", "9"]), expected: try! Expression(["1", "×"])),

      (expression: try! Expression(["1", "-", "("]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", ")"]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", "0"]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", "1"]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", "9"]), expected: try! Expression(["1", "-"])),

      (expression: try! Expression(["10", "×", "("]), expected: try! Expression(["10", "×"])),
      (expression: try! Expression(["10", ")"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "+"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "÷"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "×"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "-"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["100"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["101"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["109"]), expected: try! Expression(["10"])),

      (expression: try! Expression(["11", "×", "("]), expected: try! Expression(["11", "×"])),
      (expression: try! Expression(["11", ")"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "+"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "÷"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "×"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "-"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["110"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["111"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["119"]), expected: try! Expression(["11"])),

      (expression: try! Expression(["19", "×", "("]), expected: try! Expression(["19", "×"])),
      (expression: try! Expression(["19", ")"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "+"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "÷"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "×"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "-"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["190"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["191"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["199"]), expected: try! Expression(["19"])),
    ]

    for fixture in fixtures {
      let expression = fixture.expression
      let expected = fixture.expected
      let actual = expression.dropped()

      XCTAssertEqual(expected, actual, "expression: \(expression)")
    }
  }
}

// MARK: - Evaluation

extension ExpressionTests {
  func testEvaluateWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.value

      let expression = try! Expression(lexemes)
      let actual = try! expression.evaluate()

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testEvaluateWithParsableFixtures() {
    for fixture in parsableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testEvaluateWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testEvaluatePerformance() {
    self.measure {
      for fixture in evaluatableFixtures {
        let lexemes = fixture.lexemes
        let expected = fixture.value

        let expression = try! Expression(lexemes)
        let actual = try! expression.evaluate()

        XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
      }
    }
  }
}
