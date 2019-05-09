@testable import ChanceKit
import XCTest

class InterpreterTests: XCTestCase {
  func testInterpretWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let tokens = fixture.postfixTokens
      let expected = fixture.value
      let actual = try! interpret(postfixTokens: tokens)

      XCTAssertEqual(expected, actual, "tokens: \(tokens)")
    }
  }

  func testInterpretWithParsableFixtures() {
    for fixture in parsableFixtures {
      let tokens = fixture.postfixTokens
      let expected = fixture.error

      XCTAssertThrowsError(try interpret(postfixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
