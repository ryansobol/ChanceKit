@testable import ChanceKit
import XCTest

final class NSTextCheckingResultTests: XCTestCase {}

// MARK: - Extraction

extension NSTextCheckingResultTests {
  func testSubstringWithValidString() {
    let regex = NSRegularExpression("ab")
    let string = "abc"
    let results = regex.firstMatch(in: string)!

    let expected = Substring?("ab")
    let actual = results.substring(at: 0, in: string)

    XCTAssertEqual(expected, actual)
  }

  func testSubstringWithInvalidString() {
    let regex = NSRegularExpression("ab")
    let string = "abc"
    let results = regex.firstMatch(in: string)!
    let actual = results.substring(at: 0, in: "a")

    XCTAssertNil(actual)
  }
}
