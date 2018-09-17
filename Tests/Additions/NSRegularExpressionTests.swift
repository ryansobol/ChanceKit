@testable import Calculator
import XCTest

class NSRegularExpressionTests: XCTestCase {}

// MARK: - Initialization

extension NSRegularExpressionTests {
  func testInitWithLegalPattern() {
    let actual = NSRegularExpression("42")
    let expected = try! NSRegularExpression(pattern: "42")

    XCTAssertEqual(expected, actual)
  }
}

// MARK: - Extraction

extension NSRegularExpressionTests {
  func testFirstMatch() {
    let regex = NSRegularExpression("ab")
    let string = "abc"

    let actual = regex.firstMatch(in: string)!

    let expected = regex.firstMatch(
      in: string,
      options: [],
      range: NSRange(location: 0, length: string.utf16.count)
    )!

    XCTAssertEqual(expected.range, actual.range)
    XCTAssertEqual(expected.resultType, actual.resultType)
    XCTAssertEqual(expected.numberOfRanges, actual.numberOfRanges)
  }
}
