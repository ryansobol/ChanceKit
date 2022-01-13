import ChanceKit
import XCTest

final class ExpressionTests: XCTestCase {}

// MARK: - Initialization

extension ExpressionTests {
  func testInitWithEvaluatableIntegerFixtures() {
    for fixture in evaluatableIntegerFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes: lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithEvaluatableClosedRangeFixtures() {
    for fixture in evaluatableClosedRangeFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes: lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes: lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithLexebleOnlyFixtures() {
    for fixture in lexebleOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes: lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInitWithInvalidLexemeFixtures() {
    for fixture in invalidLexemeFixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.initError

      XCTAssertThrowsError(try Expression(lexemes: [lexeme])) { error in
        XCTAssertEqual(expected, error as? Expression.InitError, "lexeme: \(lexeme)")
      }
    }
  }

  func testInitWithoutLexemes() {
    let expected = try! Expression(lexemes: [])
    let actual = Expression()

    XCTAssertEqual(expected, actual)
  }
}

// MARK: - Inclusion

extension ExpressionTests {
  func testPushedWithLexemeParenthesisFixtures() {
    for fixture in lexemeParenthesisFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes

      let expected = try! Expression(lexemes: withLexemes)
      let actual = try! Expression(lexemes: withoutLexemes).pushed(lexeme: lexeme)

      XCTAssertEqual(
        expected,
        actual,
        "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)"
      )
    }
  }

  func testPushedWithLexerOperatorFixtures() {
    for fixture in lexerOperatorFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes

      let expected = try! Expression(lexemes: withLexemes)
      let actual = try! Expression(lexemes: withoutLexemes).pushed(lexeme: lexeme)

      XCTAssertEqual(
        expected,
        actual,
        "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)"
      )
    }
  }

  func testPushedWithLexerConstantFixtures() {
    for fixture in lexerConstantFixtures {
      let withoutLexemes = fixture.withoutLexemes
      let lexeme = fixture.lexeme
      let withLexemes = fixture.withLexemes

      let expected = try! Expression(lexemes: withLexemes)
      let actual = try! Expression(lexemes: withoutLexemes).pushed(lexeme: lexeme)

      XCTAssertEqual(
        expected,
        actual,
        "withoutLexemes: \(withoutLexemes), lexeme: \(lexeme), withLexemes: \(withLexemes)"
      )
    }
  }

  func testPushedWithInvalidLexemeFixtures() {
    for fixture in invalidLexemeFixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.pushedError

      let expression = try! Expression(lexemes: [])

      XCTAssertThrowsError(try expression.pushed(lexeme: lexeme)) { error in
        XCTAssertEqual(expected, error as? Expression.PushedError, "lexeme: \(lexeme)")
      }
    }
  }
}

// MARK: - Exclusion

extension ExpressionTests {
  func testDroppedWithEmptyLexemes() {
    let expected = try! Expression(lexemes: [])
    let actual = try! Expression(lexemes: []).dropped()

    XCTAssertEqual(expected, actual)
  }

  func testDroppedWithLexemeParenthesisFixtures() {
    for fixture in lexemeParenthesisFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes

      let expected = try! Expression(lexemes: droppedLexemes)
      let actual = try! Expression(lexemes: withLexemes).dropped()

      XCTAssertEqual(
        expected,
        actual,
        "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)"
      )
    }
  }

  func testDroppedWithLexerOperatorFixtures() {
    for fixture in lexerOperatorFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes

      let expected = try! Expression(lexemes: droppedLexemes)
      let actual = try! Expression(lexemes: withLexemes).dropped()

      XCTAssertEqual(
        expected,
        actual,
        "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)"
      )
    }
  }

  func testDroppedWithLexerConstantFixtures() {
    for fixture in lexerConstantFixtures {
      let withLexemes = fixture.withLexemes
      let droppedLexemes = fixture.droppedLexemes

      let expected = try! Expression(lexemes: droppedLexemes)
      let actual = try! Expression(lexemes: withLexemes).dropped()

      XCTAssertEqual(
        expected,
        actual,
        "withLexemes: \(withLexemes), droppedLexemes: \(droppedLexemes)"
      )
    }
  }
}

// MARK: - Interpretation

extension ExpressionTests {
  func testInterpretWithEvaluatableIntegerFixtures() {
    for fixture in evaluatableIntegerFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.value

      let expression = try! Expression(lexemes: lexemes)
      let actual = try! expression.interpret()

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testInterpretWithEvaluatableClosedRangeFixtures() {
    for fixture in evaluatableClosedRangeFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.value

      let expression = try! Expression(lexemes: lexemes)
      let actual = try! expression.interpret()

      XCTAssertTrue(
        expected.contains(actual),
        "lexemes: \(lexemes), expected: \(expected), actual: \(actual)"
      )
    }
  }

  func testInterpretWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes: lexemes)

      XCTAssertThrowsError(try expression.interpret()) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError, "lexemes: \(lexemes)")
      }
    }
  }

  func testInterpretWithLexebleOnlyFixtures() {
    for fixture in lexebleOnlyFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes: lexemes)

      XCTAssertThrowsError(try expression.interpret()) { error in
        XCTAssertEqual(expected, error as? Expression.InterpretError, "lexemes: \(lexemes)")
      }
    }
  }

  func testInterpretPerformance() {
    self.measure {
      for fixture in evaluatableIntegerFixtures {
        let lexemes = fixture.lexemes
        let expected = fixture.value

        let expression = try! Expression(lexemes: lexemes)
        let actual = try! expression.interpret()

        XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
      }
    }
  }
}
