import ChanceKit
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

  func testInitWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithLexebleOnlyFixtures() {
    for fixture in lexebleOnlyFixtures {
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
  func testPushedWithLexemeParenthesisFixtures() {
    for fixture in lexemeParenthesisFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes

      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual, "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)")
    }
  }

  func testPushedWithLexemeOperatorFixtures() {
    for fixture in lexemeOperatorFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes

      let expected = try! Expression(withLexemes)
      let actual = try! Expression(withoutLexemes).pushed(lexeme)

      XCTAssertEqual(expected, actual, "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)")
    }
  }

  func testPushedWithLexemeIntegerFixtures() {
    for fixture in lexemeIntegerFixtures {
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

  func testDroppedWithLexemeParenthesisFixtures() {
    for fixture in lexemeParenthesisFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes

      let expected = try! Expression(droppedLexemes)
      let actual = try! Expression(withLexemes).dropped()

      XCTAssertEqual(expected, actual, "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)")
    }
  }

  func testDroppedWithLexemeOperatorFixtures() {
    for fixture in lexemeOperatorFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes

      let expected = try! Expression(droppedLexemes)
      let actual = try! Expression(withLexemes).dropped()

      XCTAssertEqual(expected, actual, "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)")
    }
  }

  func testDroppedWithLexemeIntegerFixtures() {
    for fixture in lexemeIntegerFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes
      
      let expected = try! Expression(droppedLexemes)
      let actual = try! Expression(withLexemes).dropped()

      XCTAssertEqual(expected, actual, "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)")
    }
  }
}

// MARK: - Interpretation

extension ExpressionTests {
  func testInterpretWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.value

      let expression = try! Expression(lexemes)
      let actual = try! expression.interpret()

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInterpretWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.interpret()) { error in
        XCTAssertEqual(expected, error as? ExpressionError, "lexemes: \(lexemes)")
      }
    }
  }

  func testInterpretWithLexebleOnlyFixtures() {
    for fixture in lexebleOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.interpret()) { error in
        XCTAssertEqual(expected, error as? ExpressionError, "lexemes: \(lexemes)")
      }
    }
  }

  func testInterpretPerformance() {
    self.measure {
      for fixture in evaluatableFixtures {
        let lexemes = fixture.lexemes
        let expected = fixture.value

        let expression = try! Expression(lexemes)
        let actual = try! expression.interpret()

        XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
      }
    }
  }
}
