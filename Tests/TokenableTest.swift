@testable import Calculator
import XCTest

class TokenableTest: XCTestCase {
  enum TokenableInt: Int, Tokenable {
    case one = 1
    case two = 2

    var description: String {
      return String(rawValue)
    }
  }

  enum TokenableString: String, Tokenable {
    case one = "1"
    case two = "2"

    var description: String {
      return rawValue
    }
  }

  func testCustomStringConvertible() {
    typealias Fixture = (
      mock: Tokenable,
      expected: String
    )

    let fixtures: [Fixture] = [
      (mock: TokenableInt.one, expected: "1"),
      (mock: TokenableInt.two, expected: "2"),

      (mock: TokenableString.one, expected: "1"),
      (mock: TokenableString.two, expected: "2"),
    ]

    for fixture in fixtures {
      let mock = fixture.mock
      let expected = fixture.expected
      let actual = String(describing: mock)

      XCTAssertEqual(expected, actual)
    }
  }

  func testIsEqualTo() {
    typealias Fixture = (
      mock1: Tokenable,
      mock2: Tokenable
    )

    let fixtures: [Fixture] = [
      (mock1: TokenableInt.one, mock2: TokenableInt.one),
      (mock1: TokenableInt.two, mock2: TokenableInt.two),

      (mock1: TokenableString.one, mock2: TokenableString.one),
      (mock1: TokenableString.two, mock2: TokenableString.two),
    ]

    for fixture in fixtures {
      let mock1 = fixture.mock1
      let mock2 = fixture.mock2

      XCTAssertTrue(mock1.isEqualTo(mock2))
    }
  }

  func testIsNotEqualTo() {
    typealias Fixture = (
      mock1: Tokenable,
      mock2: Tokenable
    )

    let fixtures: [Fixture] = [
      (mock1: TokenableInt.one, mock2: TokenableInt.two),
      (mock1: TokenableInt.two, mock2: TokenableInt.one),

      (mock1: TokenableString.one, mock2: TokenableString.two),
      (mock1: TokenableString.two, mock2: TokenableString.one),

      (mock1: TokenableInt.one, mock2: TokenableString.one),
      (mock1: TokenableInt.two, mock2: TokenableString.two),

      (mock1: TokenableString.one, mock2: TokenableInt.one),
      (mock1: TokenableString.two, mock2: TokenableInt.two),

      (mock1: TokenableInt.one, mock2: TokenableString.two),
      (mock1: TokenableInt.two, mock2: TokenableString.one),

      (mock1: TokenableString.one, mock2: TokenableInt.two),
      (mock1: TokenableString.two, mock2: TokenableInt.one),
    ]

    for fixture in fixtures {
      let mock1 = fixture.mock1
      let mock2 = fixture.mock2

      XCTAssertFalse(mock1.isEqualTo(mock2))
    }
  }
}
