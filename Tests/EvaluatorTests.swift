@testable import ChanceKit
import XCTest

class EvaluatorTests: XCTestCase {
  func testEvaluateWithEvaluatableIntegerFixtures() {
    for fixture in evaluatableIntegerFixturesOperand2 {
      let tokens = fixture.postfixTokens
      let expected = fixture.value
      let actual = try! evaluate(postfixTokens: tokens)

      XCTAssertEqual(expected, actual, "tokens: \(tokens)")
    }
  }

  func testEvaluateWithParsableOnlyFixtures() {
    for fixture in parsableOnlyFixturesOperand2 {
      let tokens = fixture.postfixTokens
      let expected = fixture.error

      XCTAssertThrowsError(try evaluate(postfixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
