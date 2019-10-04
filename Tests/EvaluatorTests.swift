@testable import ChanceKit
import XCTest

class EvaluatorTests: XCTestCase {
  func testEvaluateWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let tokens = fixture.postfixTokens
      let expected = fixture.value
      let actual = try! evaluate(postfixTokens: tokens)

      XCTAssertEqual(expected, actual, "tokens: \(tokens)")
    }
  }

  func testEvaluateWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixtures {
      let tokens = fixture.postfixTokens
      let expected = fixture.error

      XCTAssertThrowsError(try evaluate(postfixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
