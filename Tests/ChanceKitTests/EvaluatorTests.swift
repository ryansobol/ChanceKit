@testable import ChanceKit
import XCTest

final class EvaluatorTests: XCTestCase {
  func testEvaluateWithEvaluatableIntegerFixtures() {
    for fixture in evaluatableIntegerFixtures {
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
