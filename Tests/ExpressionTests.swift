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
      withLexemes: [String],
      withoutLexemes: [String]
    )

    let fixtures: [Fixture] = [
      (withLexemes: [], withoutLexemes: []),

      (withLexemes: ["+"], withoutLexemes: []),
      (withLexemes: ["÷"], withoutLexemes: []),
      (withLexemes: ["×"], withoutLexemes: []),
      (withLexemes: ["-"], withoutLexemes: []),
      (withLexemes: ["0"], withoutLexemes: []),
      (withLexemes: ["1"], withoutLexemes: []),
      (withLexemes: ["9"], withoutLexemes: []),

      (withLexemes: ["(", "+"], withoutLexemes: ["("]),
      (withLexemes: ["(", "÷"], withoutLexemes: ["("]),
      (withLexemes: ["(", "×"], withoutLexemes: ["("]),
      (withLexemes: ["(", "-"], withoutLexemes: ["("]),
      (withLexemes: ["(", "0"], withoutLexemes: ["("]),
      (withLexemes: ["(", "1"], withoutLexemes: ["("]),
      (withLexemes: ["(", "9"], withoutLexemes: ["("]),

      (withLexemes: [")", "+"], withoutLexemes: [")"]),
      (withLexemes: [")", "÷"], withoutLexemes: [")"]),
      (withLexemes: [")", "×"], withoutLexemes: [")"]),
      (withLexemes: [")", "-"], withoutLexemes: [")"]),
      (withLexemes: [")", "×", "0"], withoutLexemes: [")", "×"]),
      (withLexemes: [")", "×", "1"], withoutLexemes: [")", "×"]),
      (withLexemes: [")", "×", "9"], withoutLexemes: [")", "×"]),

      (withLexemes: ["÷", "0"], withoutLexemes: ["÷"]),
      (withLexemes: ["÷", "1"], withoutLexemes: ["÷"]),
      (withLexemes: ["÷", "9"], withoutLexemes: ["÷"]),

      (withLexemes: ["×", "0"], withoutLexemes: ["×"]),
      (withLexemes: ["×", "1"], withoutLexemes: ["×"]),
      (withLexemes: ["×", "9"], withoutLexemes: ["×"]),

      (withLexemes: ["-1"], withoutLexemes: ["-"]),
      (withLexemes: ["-9"], withoutLexemes: ["-"]),

      (withLexemes: ["0", "+"], withoutLexemes: ["0"]),
      (withLexemes: ["0", "÷"], withoutLexemes: ["0"]),
      (withLexemes: ["0", "×"], withoutLexemes: ["0"]),
      (withLexemes: ["0", "-"], withoutLexemes: ["0"]),

      (withLexemes: ["1", "+"], withoutLexemes: ["1"]),
      (withLexemes: ["1", "÷"], withoutLexemes: ["1"]),
      (withLexemes: ["1", "×"], withoutLexemes: ["1"]),
      (withLexemes: ["1", "-"], withoutLexemes: ["1"]),
      (withLexemes: ["10"], withoutLexemes: ["1"]),
      (withLexemes: ["11"], withoutLexemes: ["1"]),
      (withLexemes: ["19"], withoutLexemes: ["1"]),

      (withLexemes: ["9", "+",], withoutLexemes: ["9"]),
      (withLexemes: ["9", "÷",], withoutLexemes: ["9"]),
      (withLexemes: ["9", "×",], withoutLexemes: ["9"]),
      (withLexemes: ["9", "-",], withoutLexemes: ["9"]),
      (withLexemes: ["9", "0",], withoutLexemes: ["9"]),
      (withLexemes: ["9", "1",], withoutLexemes: ["9"]),
      (withLexemes: ["9", "9",], withoutLexemes: ["9"]),

      (withLexemes: ["1", "×", "(", "+"], withoutLexemes: ["1", "×", "("]),
      (withLexemes: ["1", "×", "(", "÷"], withoutLexemes: ["1", "×", "("]),
      (withLexemes: ["1", "×", "(", "×"], withoutLexemes: ["1", "×", "("]),
      (withLexemes: ["1", "×", "(", "-"], withoutLexemes: ["1", "×", "("]),
      (withLexemes: ["1", "×", "(", "0"], withoutLexemes: ["1", "×", "("]),
      (withLexemes: ["1", "×", "(", "1"], withoutLexemes: ["1", "×", "("]),
      (withLexemes: ["1", "×", "(", "9"], withoutLexemes: ["1", "×", "("]),

      (withLexemes: ["1", ")", "+"], withoutLexemes: ["1", ")"]),
      (withLexemes: ["1", ")", "÷"], withoutLexemes: ["1", ")"]),
      (withLexemes: ["1", ")", "×"], withoutLexemes: ["1", ")"]),
      (withLexemes: ["1", ")", "-"], withoutLexemes: ["1", ")"]),
      (withLexemes: ["1", ")", "×", "0"], withoutLexemes: ["1", ")", "×"]),
      (withLexemes: ["1", ")", "×", "1"], withoutLexemes: ["1", ")", "×"]),
      (withLexemes: ["1", ")", "×", "9"], withoutLexemes: ["1", ")", "×"]),

      (withLexemes: ["1", "+", "0"], withoutLexemes: ["1", "+"]),
      (withLexemes: ["1", "+", "1"], withoutLexemes: ["1", "+"]),
      (withLexemes: ["1", "+", "9"], withoutLexemes: ["1", "+"]),

      (withLexemes: ["1", "÷", "0"], withoutLexemes: ["1", "÷"]),
      (withLexemes: ["1", "÷", "1"], withoutLexemes: ["1", "÷"]),
      (withLexemes: ["1", "÷", "9"], withoutLexemes: ["1", "÷"]),

      (withLexemes: ["1", "×", "0"], withoutLexemes: ["1", "×"]),
      (withLexemes: ["1", "×", "1"], withoutLexemes: ["1", "×"]),
      (withLexemes: ["1", "×", "9"], withoutLexemes: ["1", "×"]),

      (withLexemes: ["1", "-", "0"], withoutLexemes: ["1", "-"]),
      (withLexemes: ["1", "-", "1"], withoutLexemes: ["1", "-"]),
      (withLexemes: ["1", "-", "9"], withoutLexemes: ["1", "-"]),

      (withLexemes: ["10", "+"], withoutLexemes: ["10"]),
      (withLexemes: ["10", "÷"], withoutLexemes: ["10"]),
      (withLexemes: ["10", "×"], withoutLexemes: ["10"]),
      (withLexemes: ["10", "-"], withoutLexemes: ["10"]),
      (withLexemes: ["100"], withoutLexemes: ["10"]),
      (withLexemes: ["101"], withoutLexemes: ["10"]),
      (withLexemes: ["109"], withoutLexemes: ["10"]),

      (withLexemes: ["11", "+"], withoutLexemes: ["11"]),
      (withLexemes: ["11", "÷"], withoutLexemes: ["11"]),
      (withLexemes: ["11", "×"], withoutLexemes: ["11"]),
      (withLexemes: ["11", "-"], withoutLexemes: ["11"]),
      (withLexemes: ["110"], withoutLexemes: ["11"]),
      (withLexemes: ["111"], withoutLexemes: ["11"]),
      (withLexemes: ["119"], withoutLexemes: ["11"]),

      (withLexemes: ["19", "+"], withoutLexemes: ["19"]),
      (withLexemes: ["19", "÷"], withoutLexemes: ["19"]),
      (withLexemes: ["19", "×"], withoutLexemes: ["19"]),
      (withLexemes: ["19", "-"], withoutLexemes: ["19"]),
      (withLexemes: ["190"], withoutLexemes: ["19"]),
      (withLexemes: ["191"], withoutLexemes: ["19"]),
      (withLexemes: ["199"], withoutLexemes: ["19"]),
    ]

    for fixture in fixtures {
      let withLexemes = fixture.withLexemes
      let withoutLexemes = fixture.withoutLexemes
      let expected = try! Expression(withoutLexemes)
      let actual = try! Expression(withLexemes).dropped()

      XCTAssertEqual(expected, actual)
    }
  }

  func testDroppedWithLexebleParenthesisFixtures() {
    for fixture in lexebleParenthesisFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes
      let expected = try! Expression(droppedLexemes)
      let actual = try! Expression(withLexemes).dropped()

      XCTAssertEqual(expected, actual, "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)")
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
