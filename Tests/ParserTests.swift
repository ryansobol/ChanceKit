@testable import Calculator
import XCTest

class ParserTest: XCTestCase {
  func testParse() {
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

  func testParseError() {
    typealias Fixture = (
      tokens: [Tokenable],
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      ([Parenthesis.close], .missingParenthesisOpen),
      ([Parenthesis.open], .missingParenthesisClose),
    ]

    for fixture in fixtures {
      let tokens = fixture.tokens
      let expected = fixture.expected

      XCTAssertThrowsError(try parse(infixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
