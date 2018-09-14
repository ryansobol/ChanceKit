@testable import Calculator
import XCTest

class ParenthesisTests: XCTestCase {}

// MARK: - Markable

extension ParenthesisTests {
  func testDescription() {
    typealias Fixture = (
      parenthesis: Parenthesis,
      expected: String
    )

    let fixtures: [Fixture] = [
      (parenthesis: .close, expected: ")"),
      (parenthesis: .open, expected: "("),
    ]

    for fixture in fixtures {
      let parenthesis = fixture.parenthesis
      let expected = fixture.expected
      let actual = String(describing: parenthesis)

      XCTAssertEqual(expected, actual)
    }
  }
}
