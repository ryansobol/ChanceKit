@testable import ChanceKit
import XCTest

class LexerTests: XCTestCase {
  func testLexedWithLexebleParenthesisFixtures() {
    for fixture in lexebleParenthesisFixtures {
      let token = fixture.token
      let tokens = fixture.withoutTokens
      let expectedTokens = fixture.withTokens
      let actualTokens = lexed(parenthesis: token, into: tokens)

      XCTAssertEqual(expectedTokens.count, actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testLexedWithLexebleOperatorFixtures() {
    for fixture in lexebleOperatorFixtures {
      let token = fixture.token
      let tokens = fixture.withoutTokens
      let expectedTokens = fixture.withTokens
      let actualTokens = lexed(operator: token, into: tokens)

      XCTAssertEqual(expectedTokens.count, actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testLexedWithLexebleIntegerFixtures() {
    for fixture in lexebleIntegerFixtures {
      let integer = fixture.integer
      let tokens = fixture.withoutTokens
      let expectedTokens = fixture.withTokens
      let actualTokens = try! lexed(integer: integer, into: tokens)

      XCTAssertEqual(expectedTokens.count, actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }
}
