@testable import ChanceKit
import XCTest

class LexerTests: XCTestCase {
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

  func testLexedWithLexemeOperatorFixtures() {
    for fixture in lexemeOperatorFixtures {
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

  func testLexedWithLexemeOperandFixtures() {
    for fixture in lexemeOperandFixtures {
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
