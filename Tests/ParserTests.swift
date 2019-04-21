@testable import Calculator
import XCTest

class ParserTests: XCTestCase {
  func testParseWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let tokens = fixture.infixTokens
      let expectedTokens = fixture.postfixTokens
      let actualTokens = try! parse(infixTokens: tokens)

      XCTAssertTrue(expectedTokens.count == actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testParseWithParsableFixtures() {
    for fixture in parsableFixtures {
      let tokens = fixture.infixTokens
      let expectedTokens = fixture.postfixTokens
      let actualTokens = try! parse(infixTokens: tokens)

      XCTAssertTrue(expectedTokens.count == actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testParseWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let tokens = fixture.infixTokens
      let expected = fixture.error

      XCTAssertThrowsError(try parse(infixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
