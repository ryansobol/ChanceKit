@testable import ChanceKit
import XCTest

final class ParserTests: XCTestCase {
  func testParseWithEvaluatableIntegerFixtures() {
    for fixture in evaluatableIntegerFixtures {
      let tokens = fixture.infixTokens
      let expectedTokens = fixture.postfixTokens
      let actualTokens = try! parse(infixTokens: tokens)

      XCTAssertEqual(expectedTokens.count, actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testParseWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixtures {
      let tokens = fixture.infixTokens
      let expectedTokens = fixture.postfixTokens
      let actualTokens = try! parse(infixTokens: tokens)

      XCTAssertEqual(expectedTokens.count, actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testParseWithLexebleOnlyFixtures() {
    for fixture in lexebleOnlyFixtures {
      let tokens = fixture.infixTokens
      let expected = fixture.error

      XCTAssertThrowsError(try parse(infixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
