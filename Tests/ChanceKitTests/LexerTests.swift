@testable import ChanceKit
import XCTest

final class LexerTests: XCTestCase {
  func testLexedWithLexemeParenthesisFixtures() {
    for fixture in lexemeParenthesisFixtures {
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

  func testLexedWithLexerOperatorFixtures() {
    for fixture in lexerOperatorFixtures {
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

  func testLexedWithLexerConstantFixtures() {
    for fixture in lexerConstantFixtures {
      let token = fixture.token
      let tokens = fixture.withoutTokens
      let expectedTokens = fixture.withTokens
      let actualTokens = try! lexed(operand: token, into: tokens)

      XCTAssertEqual(expectedTokens.count, actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }
}
