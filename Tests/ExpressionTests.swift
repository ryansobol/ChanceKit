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

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithParsableFixtures() {
    for fixture in parsableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithInvalidFixtures() {
    for fixture in invalidFixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.error

      XCTAssertThrowsError(try Expression([lexeme])) { error in
        XCTAssertEqual(expected, error as? ExpressionError, "lexeme: \(lexeme)")
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

      XCTAssertEqual(expected, actual, "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)")
    }
  }

  func testPushedWithLexebleOperatorFixtures() {
    for fixture in lexebleOperatorFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes
      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual, "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)")
    }
  }

  func testPushedWithLexebleIntegerFixtures() {
    for fixture in lexebleIntegerFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes
      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual, "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)")
    }
  }

  func testPushedWithInvalidFixtures() {
    for fixture in invalidFixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.error
      let expression = try! Expression([])

      XCTAssertThrowsError(try expression.pushed(lexeme)) { error in
        XCTAssertEqual(expected, error as? ExpressionError, "lexeme: \(lexeme)")
      }
    }
  }
}

// MARK: - Exclusion

extension ExpressionTests {
  func testDroppedWithEmptyLexemes() {
    let expected = try! Expression([])
    let actual = try! Expression([]).dropped()

    XCTAssertEqual(expected, actual)
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

  func testDroppedWithLexebleOperatorFixtures() {
    for fixture in lexebleOperatorFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes
      let expected = try! Expression(droppedLexemes)
      let actual = try! Expression(withLexemes).dropped()

      XCTAssertEqual(expected, actual, "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)")
    }
  }

  func testDroppedWithLexebleIntegerFixtures() {
    for fixture in lexebleIntegerFixtures {
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
        XCTAssertEqual(expected, error as? ExpressionError, "lexemes: \(lexemes)")
      }
    }
  }

  func testEvaluateWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError, "lexemes: \(lexemes)")
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
