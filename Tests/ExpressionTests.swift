import Calculator
import XCTest

class ExpressionTests: XCTestCase {
  typealias Fixture = (
    infixTokens: [String],
    description: String,
    value: Int
  )

  let fixtures: [Fixture] = [
    // MARK: A
    ([], "", 0),
    (["42"], "42", 42),

    // MARK: A + B
    (["1", "+", "2"], "1 + 2", 3),
    (["4", "-", "3"], "4 - 3", 1),
    (["5", "×", "6"], "5 × 6", 30),
    (["8", "÷", "7"], "8 ÷ 7", 1),
    (["9", "×", "0"], "9 × 0", 0),
    (["2", "÷", "1"], "2 ÷ 1", 2),

    // MARK: A + B + C
    (["3", "-", "1", "+", "2"], "3 - 1 + 2", 4),
    (["5", "÷", "7", "×", "6"], "5 ÷ 7 × 6", 0),
    (["8", "+", "0", "÷", "9"], "8 + 0 ÷ 9", 8),
    (["2", "×", "4", "-", "1"], "2 × 4 - 1", 7),

    // MARK: A + B + C + D
    (["7", "-", "5", "-", "3", "+", "8"], "7 - 5 - 3 + 8", 7),
    (["6", "÷", "1", "×", "2", "×", "0"], "6 ÷ 1 × 2 × 0", 0),
    (["3", "+", "4", "÷", "2", "-", "7"], "3 + 4 ÷ 2 - 7", -2),
    (["8", "-", "9", "×", "5", "÷", "1"], "8 - 9 × 5 ÷ 1", -37),
    (["4", "×", "1", "÷", "6", "+", "0"], "4 × 1 ÷ 6 + 0", 0),
    (["0", "÷", "5", "+", "4", "×", "7"], "0 ÷ 5 + 4 × 7", 28),

    // MARK: (A)
    (["(", ")"], "()", 0),
    (["(", "42", ")"], "(42)", 42),

    // MARK: (A + B)
    (["(", "2", "+", "3", ")"], "(2 + 3)", 5),
    (["(", "5", "-", "4", ")"], "(5 - 4)", 1),
    (["(", "6", "×", "7", ")"], "(6 × 7)", 42),
    (["(", "9", "÷", "8", ")"], "(9 ÷ 8)", 1),
    (["(", "0", "×", "1", ")"], "(0 × 1)", 0),
    (["(", "3", "÷", "2", ")"], "(3 ÷ 2)", 1),

    // MARK: ((A + B))
    (["(", "(", "2", "+", "3", ")", ")"], "((2 + 3))", 5),
    (["(", "(", "5", "-", "4", ")", ")"], "((5 - 4))", 1),
    (["(", "(", "6", "×", "7", ")", ")"], "((6 × 7))", 42),
    (["(", "(", "9", "÷", "8", ")", ")"], "((9 ÷ 8))", 1),
    (["(", "(", "0", "×", "1", ")", ")"], "((0 × 1))", 0),
    (["(", "(", "3", "÷", "2", ")", ")"], "((3 ÷ 2))", 1),

    // MARK: (A + B) + C
    (["(", "5", "-", "4", ")", "+", "6"], "(5 - 4) + 6", 7),
    (["7", "-", "(", "9", "+", "8", ")"], "7 - (9 + 8)", -10),
    (["(", "3", "÷", "1", ")", "-", "0"], "(3 ÷ 1) - 0", 3),
    (["4", "÷", "(", "2", "-", "5", ")"], "4 ÷ (2 - 5)", -1),
    (["(", "2", "+", "8", ")", "×", "7"], "(2 + 8) × 7", 70),
    (["9", "+", "(", "0", "×", "1", ")"], "9 + (0 × 1)", 9),
    (["(", "1", "×", "3", ")", "÷", "4"], "(1 × 3) ÷ 4", 0),
    (["6", "×", "(", "7", "÷", "5", ")"], "6 × (7 ÷ 5)", 6),

    // MARK: ((A + B) + C)
    (["(", "(", "5", "-", "4", ")", "+", "6", ")"], "((5 - 4) + 6)", 7),
    (["(", "7", "-", "(", "9", "+", "8", ")", ")"], "(7 - (9 + 8))", -10),
    (["(", "(", "3", "÷", "1", ")", "-", "0", ")"], "((3 ÷ 1) - 0)", 3),
    (["(", "4", "÷", "(", "2", "-", "5", ")", ")"], "(4 ÷ (2 - 5))", -1),
    (["(", "(", "2", "+", "8", ")", "×", "7", ")"], "((2 + 8) × 7)", 70),
    (["(", "9", "+", "(", "0", "×", "1", ")", ")"], "(9 + (0 × 1))", 9),
    (["(", "(", "1", "×", "3", ")", "÷", "4", ")"], "((1 × 3) ÷ 4)", 0),
    (["(", "6", "×", "(", "7", "÷", "5", ")", ")"], "(6 × (7 ÷ 5))", 6),

    // MARK: (A + B) + (C + D)
    (["(", "4", "+", "1", ")", "-", "(", "8", "+", "5", ")"], "(4 + 1) - (8 + 5)", -8),
    (["(", "2", "×", "4", ")", "÷", "(", "9", "×", "7", ")"], "(2 × 4) ÷ (9 × 7)", 0),
    (["(", "6", "÷", "1", ")", "+", "(", "8", "÷", "4", ")"], "(6 ÷ 1) + (8 ÷ 4)", 8),
    (["(", "3", "-", "2", ")", "×", "(", "7", "-", "5", ")"], "(3 - 2) × (7 - 5)", 2),
    (["(", "4", "+", "8", ")", "-", "(", "1", "×", "2", ")"], "(4 + 8) - (1 × 2)", 10),
    (["(", "5", "÷", "7", ")", "+", "(", "6", "-", "9", ")"], "(5 ÷ 7) + (6 - 9)", -3),
    (["(", "0", "×", "9", ")", "÷", "(", "3", "+", "1", ")"], "(0 × 9) ÷ (3 + 1)", 0),
    (["(", "2", "-", "3", ")", "×", "(", "4", "÷", "5", ")"], "(2 - 3) × (4 ÷ 5)", 0),

    // MARK: (A + (B + C) + D)
    (["(", "1", "+", "(", "9", "-", "4", ")", "-", "2", ")"], "(1 + (9 - 4) - 2)", 4),
    (["(", "5", "×", "(", "0", "÷", "3", ")", "×", "7", ")"], "(5 × (0 ÷ 3) × 7)", 0),
    (["(", "8", "-", "(", "4", "×", "6", ")", "+", "1", ")"], "(8 - (4 × 6) + 1)", -15),
    (["(", "3", "÷", "(", "9", "+", "2", ")", "÷", "6", ")"], "(3 ÷ (9 + 2) ÷ 6)", 0),
    (["(", "0", "+", "(", "3", "-", "6", ")", "×", "4", ")"], "(0 + (3 - 6) × 4)", -12),
    (["(", "2", "×", "(", "5", "+", "8", ")", "-", "1", ")"], "(2 × (5 + 8) - 1)", 25),
    (["(", "9", "÷", "(", "7", "×", "1", ")", "+", "5", ")"], "(9 ÷ (7 × 1) + 5)", 6),
    (["(", "4", "-", "(", "6", "÷", "5", ")", "×", "3", ")"], "(4 - (6 ÷ 5) × 3)", 1),

    // MARK: (A + B ÷ C × (D + E) - F)
    (["(", "1", "+", "2", "÷", "3", "×", "(", "4", "+", "5", ")", "-", "6", ")"], "(1 + 2 ÷ 3 × (4 + 5) - 6)", -5),
  ]
}

// MARK: - Initialization

extension ExpressionTests {
  //  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
  func testInitWithEvaluableTokens() {
    for fixture in fixtures {
      let infixTokens = fixture.infixTokens
      let expected = fixture.description

      let expression = try! Expression(infixTokens)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithUnevaluableTokens() {
    typealias Fixture = (
      infixTokens: [String],
      expected: String
    )

    let fixtures: [Fixture] = [
      (infixTokens: [], expected: ""),
      (infixTokens: ["("], expected: "("),
      (infixTokens: [")"], expected: ")"),
      (infixTokens: ["+"], expected: "+"),
      (infixTokens: ["÷"], expected: "÷"),
      (infixTokens: ["×"], expected: "×"),
      (infixTokens: ["-"], expected: "-"),
      (infixTokens: [String(Int.max)], expected: String(Int.max)),
      (infixTokens: [String(Int.min)], expected: String(Int.min)),
    ]

    for fixture in fixtures {
      let infixTokens = fixture.infixTokens
      let expected = fixture.expected

      let expression = try! Expression(infixTokens)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidTokens() {
    typealias Fixture = (
      infixTokens: [String],
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      (infixTokens: ["="], expected: .invalidToken("=")),
      (infixTokens: ["["], expected: .invalidToken("[")),
      (infixTokens: ["{"], expected: .invalidToken("{")),
      (infixTokens: ["<"], expected: .invalidToken("<")),
      (infixTokens: ["."], expected: .invalidToken(".")),
      (infixTokens: [","], expected: .invalidToken(",")),
      (infixTokens: [","], expected: .invalidToken(",")),
      (infixTokens: ["**"], expected: .invalidToken("**")),
      (infixTokens: ["&"], expected: .invalidToken("&")),
      (infixTokens: ["|"], expected: .invalidToken("|")),
      (infixTokens: ["!"], expected: .invalidToken("!")),
      (infixTokens: ["~"], expected: .invalidToken("~")),
      (infixTokens: ["..<"], expected: .invalidToken("..<")),
      (infixTokens: ["..."], expected: .invalidToken("...")),
      (infixTokens: ["<<"], expected: .invalidToken("<<")),
      (infixTokens: [">>"], expected: .invalidToken(">>")),
      (infixTokens: ["%"], expected: .invalidToken("%")),
    ]

    for fixture in fixtures {
      let infixTokens = fixture.infixTokens
      let expected = fixture.expected

      XCTAssertThrowsError(try Expression(infixTokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Inclusion

extension ExpressionTests {
  //  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
  func testPushedWithValidTokens() {
    typealias Fixture = (
      infixTokens: [String],
      infixToken: String,
      expected: String
    )

    let fixtures: [Fixture] = [
      (infixTokens: [], infixToken: "(", expected: "("),
      (infixTokens: [], infixToken: ")", expected: ")"),
      (infixTokens: [], infixToken: "+", expected: "+"),
      (infixTokens: [], infixToken: "÷", expected: "÷"),
      (infixTokens: [], infixToken: "×", expected: "×"),
      (infixTokens: [], infixToken: "-", expected: "-"),
      (infixTokens: [], infixToken: "0", expected: "0"),
      (infixTokens: [], infixToken: "1", expected: "1"),
      (infixTokens: [], infixToken: "9", expected: "9"),

      (infixTokens: ["("], infixToken: "(", expected: "(("),
      (infixTokens: ["("], infixToken: ")", expected: "()"),
      (infixTokens: ["("], infixToken: "+", expected: "( +"),
      (infixTokens: ["("], infixToken: "÷", expected: "( ÷"),
      (infixTokens: ["("], infixToken: "×", expected: "( ×"),
      (infixTokens: ["("], infixToken: "-", expected: "( -"),
      (infixTokens: ["("], infixToken: "0", expected: "(0"),
      (infixTokens: ["("], infixToken: "1", expected: "(1"),
      (infixTokens: ["("], infixToken: "9", expected: "(9"),

      (infixTokens: [")"], infixToken: "(", expected: ") × ("),
      (infixTokens: [")"], infixToken: ")", expected: "))"),
      (infixTokens: [")"], infixToken: "+", expected: ") +"),
      (infixTokens: [")"], infixToken: "÷", expected: ") ÷"),
      (infixTokens: [")"], infixToken: "×", expected: ") ×"),
      (infixTokens: [")"], infixToken: "-", expected: ") -"),
      (infixTokens: [")"], infixToken: "0", expected: ") × 0"),
      (infixTokens: [")"], infixToken: "1", expected: ") × 1"),
      (infixTokens: [")"], infixToken: "9", expected: ") × 9"),

      (infixTokens: ["+"], infixToken: "(", expected: "+ ("),
      (infixTokens: ["+"], infixToken: ")", expected: "+ )"),
      (infixTokens: ["+"], infixToken: "+", expected: "+"),
      (infixTokens: ["+"], infixToken: "÷", expected: "÷"),
      (infixTokens: ["+"], infixToken: "×", expected: "×"),
      (infixTokens: ["+"], infixToken: "-", expected: "-"),
      (infixTokens: ["+"], infixToken: "0", expected: "0"),
      (infixTokens: ["+"], infixToken: "1", expected: "1"),
      (infixTokens: ["+"], infixToken: "9", expected: "9"),

      (infixTokens: ["÷"], infixToken: "(", expected: "÷ ("),
      (infixTokens: ["÷"], infixToken: ")", expected: "÷ )"),
      (infixTokens: ["÷"], infixToken: "+", expected: "+"),
      (infixTokens: ["÷"], infixToken: "÷", expected: "÷"),
      (infixTokens: ["÷"], infixToken: "×", expected: "×"),
      (infixTokens: ["÷"], infixToken: "-", expected: "-"),
      (infixTokens: ["÷"], infixToken: "0", expected: "÷ 0"),
      (infixTokens: ["÷"], infixToken: "1", expected: "÷ 1"),
      (infixTokens: ["÷"], infixToken: "9", expected: "÷ 9"),

      (infixTokens: ["×"], infixToken: "(", expected: "× ("),
      (infixTokens: ["×"], infixToken: ")", expected: "× )"),
      (infixTokens: ["×"], infixToken: "+", expected: "+"),
      (infixTokens: ["×"], infixToken: "÷", expected: "÷"),
      (infixTokens: ["×"], infixToken: "×", expected: "×"),
      (infixTokens: ["×"], infixToken: "-", expected: "-"),
      (infixTokens: ["×"], infixToken: "0", expected: "× 0"),
      (infixTokens: ["×"], infixToken: "1", expected: "× 1"),
      (infixTokens: ["×"], infixToken: "9", expected: "× 9"),

      (infixTokens: ["-"], infixToken: "(", expected: "- ("),
      (infixTokens: ["-"], infixToken: ")", expected: "- )"),
      (infixTokens: ["-"], infixToken: "+", expected: "+"),
      (infixTokens: ["-"], infixToken: "÷", expected: "÷"),
      (infixTokens: ["-"], infixToken: "×", expected: "×"),
      (infixTokens: ["-"], infixToken: "-", expected: "-"),
      (infixTokens: ["-"], infixToken: "0", expected: "0"),
      (infixTokens: ["-"], infixToken: "1", expected: "-1"),
      (infixTokens: ["-"], infixToken: "9", expected: "-9"),

      (infixTokens: ["0"], infixToken: "(", expected: "0 × ("),
      (infixTokens: ["0"], infixToken: ")", expected: "0)"),
      (infixTokens: ["0"], infixToken: "+", expected: "0 +"),
      (infixTokens: ["0"], infixToken: "÷", expected: "0 ÷"),
      (infixTokens: ["0"], infixToken: "×", expected: "0 ×"),
      (infixTokens: ["0"], infixToken: "-", expected: "0 -"),
      (infixTokens: ["0"], infixToken: "0", expected: "0"),
      (infixTokens: ["0"], infixToken: "1", expected: "1"),
      (infixTokens: ["0"], infixToken: "9", expected: "9"),

      (infixTokens: ["1"], infixToken: "(", expected: "1 × ("),
      (infixTokens: ["1"], infixToken: ")", expected: "1)"),
      (infixTokens: ["1"], infixToken: "+", expected: "1 +"),
      (infixTokens: ["1"], infixToken: "÷", expected: "1 ÷"),
      (infixTokens: ["1"], infixToken: "×", expected: "1 ×"),
      (infixTokens: ["1"], infixToken: "-", expected: "1 -"),
      (infixTokens: ["1"], infixToken: "0", expected: "10"),
      (infixTokens: ["1"], infixToken: "1", expected: "11"),
      (infixTokens: ["1"], infixToken: "9", expected: "19"),

      (infixTokens: ["9"], infixToken: "(", expected: "9 × ("),
      (infixTokens: ["9"], infixToken: ")", expected: "9)"),
      (infixTokens: ["9"], infixToken: "+", expected: "9 +"),
      (infixTokens: ["9"], infixToken: "÷", expected: "9 ÷"),
      (infixTokens: ["9"], infixToken: "×", expected: "9 ×"),
      (infixTokens: ["9"], infixToken: "-", expected: "9 -"),
      (infixTokens: ["9"], infixToken: "0", expected: "90"),
      (infixTokens: ["9"], infixToken: "1", expected: "91"),
      (infixTokens: ["9"], infixToken: "9", expected: "99"),

      (infixTokens: ["1", "×", "("], infixToken: "(", expected: "1 × (("),
      (infixTokens: ["1", "×", "("], infixToken: ")", expected: "1 × ()"),
      (infixTokens: ["1", "×", "("], infixToken: "+", expected: "1 × ( +"),
      (infixTokens: ["1", "×", "("], infixToken: "÷", expected: "1 × ( ÷"),
      (infixTokens: ["1", "×", "("], infixToken: "×", expected: "1 × ( ×"),
      (infixTokens: ["1", "×", "("], infixToken: "-", expected: "1 × ( -"),
      (infixTokens: ["1", "×", "("], infixToken: "0", expected: "1 × (0"),
      (infixTokens: ["1", "×", "("], infixToken: "1", expected: "1 × (1"),
      (infixTokens: ["1", "×", "("], infixToken: "9", expected: "1 × (9"),

      (infixTokens: ["1", ")"], infixToken: "(", expected: "1) × ("),
      (infixTokens: ["1", ")"], infixToken: ")", expected: "1))"),
      (infixTokens: ["1", ")"], infixToken: "+", expected: "1) +"),
      (infixTokens: ["1", ")"], infixToken: "÷", expected: "1) ÷"),
      (infixTokens: ["1", ")"], infixToken: "×", expected: "1) ×"),
      (infixTokens: ["1", ")"], infixToken: "-", expected: "1) -"),
      (infixTokens: ["1", ")"], infixToken: "0", expected: "1) × 0"),
      (infixTokens: ["1", ")"], infixToken: "1", expected: "1) × 1"),
      (infixTokens: ["1", ")"], infixToken: "9", expected: "1) × 9"),

      (infixTokens: ["1", "+"], infixToken: "(", expected: "1 + ("),
      (infixTokens: ["1", "+"], infixToken: ")", expected: "1 + )"),
      (infixTokens: ["1", "+"], infixToken: "+", expected: "1 +"),
      (infixTokens: ["1", "+"], infixToken: "÷", expected: "1 ÷"),
      (infixTokens: ["1", "+"], infixToken: "×", expected: "1 ×"),
      (infixTokens: ["1", "+"], infixToken: "-", expected: "1 -"),
      (infixTokens: ["1", "+"], infixToken: "0", expected: "1 + 0"),
      (infixTokens: ["1", "+"], infixToken: "1", expected: "1 + 1"),
      (infixTokens: ["1", "+"], infixToken: "9", expected: "1 + 9"),

      (infixTokens: ["1", "÷"], infixToken: "(", expected: "1 ÷ ("),
      (infixTokens: ["1", "÷"], infixToken: ")", expected: "1 ÷ )"),
      (infixTokens: ["1", "÷"], infixToken: "+", expected: "1 +"),
      (infixTokens: ["1", "÷"], infixToken: "÷", expected: "1 ÷"),
      (infixTokens: ["1", "÷"], infixToken: "×", expected: "1 ×"),
      (infixTokens: ["1", "÷"], infixToken: "-", expected: "1 -"),
      (infixTokens: ["1", "÷"], infixToken: "0", expected: "1 ÷ 0"),
      (infixTokens: ["1", "÷"], infixToken: "1", expected: "1 ÷ 1"),
      (infixTokens: ["1", "÷"], infixToken: "9", expected: "1 ÷ 9"),

      (infixTokens: ["1", "×"], infixToken: "(", expected: "1 × ("),
      (infixTokens: ["1", "×"], infixToken: ")", expected: "1 × )"),
      (infixTokens: ["1", "×"], infixToken: "+", expected: "1 +"),
      (infixTokens: ["1", "×"], infixToken: "÷", expected: "1 ÷"),
      (infixTokens: ["1", "×"], infixToken: "×", expected: "1 ×"),
      (infixTokens: ["1", "×"], infixToken: "-", expected: "1 -"),
      (infixTokens: ["1", "×"], infixToken: "0", expected: "1 × 0"),
      (infixTokens: ["1", "×"], infixToken: "1", expected: "1 × 1"),
      (infixTokens: ["1", "×"], infixToken: "9", expected: "1 × 9"),

      (infixTokens: ["1", "-"], infixToken: "(", expected: "1 - ("),
      (infixTokens: ["1", "-"], infixToken: ")", expected: "1 - )"),
      (infixTokens: ["1", "-"], infixToken: "+", expected: "1 +"),
      (infixTokens: ["1", "-"], infixToken: "÷", expected: "1 ÷"),
      (infixTokens: ["1", "-"], infixToken: "×", expected: "1 ×"),
      (infixTokens: ["1", "-"], infixToken: "-", expected: "1 -"),
      (infixTokens: ["1", "-"], infixToken: "0", expected: "1 - 0"),
      (infixTokens: ["1", "-"], infixToken: "1", expected: "1 - 1"),
      (infixTokens: ["1", "-"], infixToken: "9", expected: "1 - 9"),

      (infixTokens: ["10"], infixToken: "(", expected: "10 × ("),
      (infixTokens: ["10"], infixToken: ")", expected: "10)"),
      (infixTokens: ["10"], infixToken: "+", expected: "10 +"),
      (infixTokens: ["10"], infixToken: "÷", expected: "10 ÷"),
      (infixTokens: ["10"], infixToken: "×", expected: "10 ×"),
      (infixTokens: ["10"], infixToken: "-", expected: "10 -"),
      (infixTokens: ["10"], infixToken: "0", expected: "100"),
      (infixTokens: ["10"], infixToken: "1", expected: "101"),
      (infixTokens: ["10"], infixToken: "9", expected: "109"),

      (infixTokens: ["11"], infixToken: "(", expected: "11 × ("),
      (infixTokens: ["11"], infixToken: ")", expected: "11)"),
      (infixTokens: ["11"], infixToken: "+", expected: "11 +"),
      (infixTokens: ["11"], infixToken: "÷", expected: "11 ÷"),
      (infixTokens: ["11"], infixToken: "×", expected: "11 ×"),
      (infixTokens: ["11"], infixToken: "-", expected: "11 -"),
      (infixTokens: ["11"], infixToken: "0", expected: "110"),
      (infixTokens: ["11"], infixToken: "1", expected: "111"),
      (infixTokens: ["11"], infixToken: "9", expected: "119"),

      (infixTokens: ["19"], infixToken: "(", expected: "19 × ("),
      (infixTokens: ["19"], infixToken: ")", expected: "19)"),
      (infixTokens: ["19"], infixToken: "+", expected: "19 +"),
      (infixTokens: ["19"], infixToken: "÷", expected: "19 ÷"),
      (infixTokens: ["19"], infixToken: "×", expected: "19 ×"),
      (infixTokens: ["19"], infixToken: "-", expected: "19 -"),
      (infixTokens: ["19"], infixToken: "0", expected: "190"),
      (infixTokens: ["19"], infixToken: "1", expected: "191"),
      (infixTokens: ["19"], infixToken: "9", expected: "199"),
    ]

    for fixture in fixtures {
      let infixTokens = fixture.infixTokens
      let infixToken = fixture.infixToken
      let expected = fixture.expected

      let expression = try! Expression(infixTokens)
      let nextExpression = try! expression.pushed(infixToken)
      let actual = String(describing: nextExpression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedWithInvalidTokens() {
    typealias Fixture = (
      infixToken: String,
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      (infixToken: "=", expected: .invalidToken("=")),
      (infixToken: "[", expected: .invalidToken("[")),
      (infixToken: "{", expected: .invalidToken("{")),
      (infixToken: "<", expected: .invalidToken("<")),
      (infixToken: ".", expected: .invalidToken(".")),
      (infixToken: ",", expected: .invalidToken(",")),
      (infixToken: ",", expected: .invalidToken(",")),
      (infixToken: "**", expected: .invalidToken("**")),
      (infixToken: "&", expected: .invalidToken("&")),
      (infixToken: "|", expected: .invalidToken("|")),
      (infixToken: "!", expected: .invalidToken("!")),
      (infixToken: "~", expected: .invalidToken("~")),
      (infixToken: "..<", expected: .invalidToken("..<")),
      (infixToken: "...", expected: .invalidToken("...")),
      (infixToken: "<<", expected: .invalidToken("<<")),
      (infixToken: ">>", expected: .invalidToken(">>")),
      (infixToken: "%", expected: .invalidToken("%")),
    ]

    for fixture in fixtures {
      let infixToken = fixture.infixToken
      let expected = fixture.expected
      let expression = try! Expression([])

      XCTAssertThrowsError(try expression.pushed(infixToken)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Exclusion

extension ExpressionTests {
  func testDropped() {
    typealias Fixture = (
      expression: Expression,
      expected: Expression
    )

    let fixtures: [Fixture] = [
      (expression: try! Expression([]), expected: try! Expression([])),

      (expression: try! Expression(["("]), expected: try! Expression([])),
      (expression: try! Expression([")"]), expected: try! Expression([])),
      (expression: try! Expression(["+"]), expected: try! Expression([])),
      (expression: try! Expression(["÷"]), expected: try! Expression([])),
      (expression: try! Expression(["×"]), expected: try! Expression([])),
      (expression: try! Expression(["-"]), expected: try! Expression([])),
      (expression: try! Expression(["0"]), expected: try! Expression([])),
      (expression: try! Expression(["1"]), expected: try! Expression([])),
      (expression: try! Expression(["9"]), expected: try! Expression([])),

      (expression: try! Expression(["(", "("]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", ")"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "+"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "÷"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "×"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "-"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "0"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "1"]), expected: try! Expression(["("])),
      (expression: try! Expression(["(", "9"]), expected: try! Expression(["("])),

      (expression: try! Expression([")", "×", "("]), expected: try! Expression([")", "×"])),
      (expression: try! Expression([")", ")"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "+"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "÷"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "×"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "-"]), expected: try! Expression([")"])),
      (expression: try! Expression([")", "×", "0"]), expected: try! Expression([")", "×"])),
      (expression: try! Expression([")", "×", "1"]), expected: try! Expression([")", "×"])),
      (expression: try! Expression([")", "×", "9"]), expected: try! Expression([")", "×"])),

      (expression: try! Expression(["+", "("]), expected: try! Expression(["+"])),
      (expression: try! Expression(["+", ")"]), expected: try! Expression(["+"])),

      (expression: try! Expression(["÷", "("]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", ")"]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", "0"]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", "1"]), expected: try! Expression(["÷"])),
      (expression: try! Expression(["÷", "9"]), expected: try! Expression(["÷"])),

      (expression: try! Expression(["×", "("]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", ")"]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", "0"]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", "1"]), expected: try! Expression(["×"])),
      (expression: try! Expression(["×", "9"]), expected: try! Expression(["×"])),

      (expression: try! Expression(["-", "("]), expected: try! Expression(["-"])),
      (expression: try! Expression(["-", ")"]), expected: try! Expression(["-"])),
      (expression: try! Expression(["-1"]), expected: try! Expression(["-"])),
      (expression: try! Expression(["-9"]), expected: try! Expression(["-"])),

      (expression: try! Expression(["0", "×", "("]), expected: try! Expression(["0", "×"])),
      (expression: try! Expression(["0", ")"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "+"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "÷"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "×"]), expected: try! Expression(["0"])),
      (expression: try! Expression(["0", "-"]), expected: try! Expression(["0"])),

      (expression: try! Expression(["1", "×", "("]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", ")"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "+"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "÷"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "×"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["1", "-"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["10"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["11"]), expected: try! Expression(["1"])),
      (expression: try! Expression(["19"]), expected: try! Expression(["1"])),

      (expression: try! Expression(["9", "×", "("]), expected: try! Expression(["9", "×"])),
      (expression: try! Expression(["9", ")",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "+",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "÷",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "×",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "-",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "0",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "1",]), expected: try! Expression(["9"])),
      (expression: try! Expression(["9", "9",]), expected: try! Expression(["9"])),

      (expression: try! Expression(["1", "×", "(", "("]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", ")"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "+"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "÷"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "×"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "-"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "0"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "1"]), expected: try! Expression(["1", "×", "("])),
      (expression: try! Expression(["1", "×", "(", "9"]), expected: try! Expression(["1", "×", "("])),

      (expression: try! Expression(["1", ")", "×", "("]), expected: try! Expression(["1", ")", "×"])),
      (expression: try! Expression(["1", ")", ")"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "+"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "÷"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "×"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "-"]), expected: try! Expression(["1", ")"])),
      (expression: try! Expression(["1", ")", "×", "0"]), expected: try! Expression(["1", ")", "×"])),
      (expression: try! Expression(["1", ")", "×", "1"]), expected: try! Expression(["1", ")", "×"])),
      (expression: try! Expression(["1", ")", "×", "9"]), expected: try! Expression(["1", ")", "×"])),

      (expression: try! Expression(["1", "+", "("]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", ")"]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", "0"]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", "1"]), expected: try! Expression(["1", "+"])),
      (expression: try! Expression(["1", "+", "9"]), expected: try! Expression(["1", "+"])),

      (expression: try! Expression(["1", "÷", "("]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", ")"]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", "0"]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", "1"]), expected: try! Expression(["1", "÷"])),
      (expression: try! Expression(["1", "÷", "9"]), expected: try! Expression(["1", "÷"])),

      (expression: try! Expression(["1", "×", "("]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", ")"]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", "0"]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", "1"]), expected: try! Expression(["1", "×"])),
      (expression: try! Expression(["1", "×", "9"]), expected: try! Expression(["1", "×"])),

      (expression: try! Expression(["1", "-", "("]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", ")"]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", "0"]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", "1"]), expected: try! Expression(["1", "-"])),
      (expression: try! Expression(["1", "-", "9"]), expected: try! Expression(["1", "-"])),

      (expression: try! Expression(["10", "×", "("]), expected: try! Expression(["10", "×"])),
      (expression: try! Expression(["10", ")"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "+"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "÷"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "×"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["10", "-"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["100"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["101"]), expected: try! Expression(["10"])),
      (expression: try! Expression(["109"]), expected: try! Expression(["10"])),

      (expression: try! Expression(["11", "×", "("]), expected: try! Expression(["11", "×"])),
      (expression: try! Expression(["11", ")"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "+"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "÷"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "×"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["11", "-"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["110"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["111"]), expected: try! Expression(["11"])),
      (expression: try! Expression(["119"]), expected: try! Expression(["11"])),

      (expression: try! Expression(["19", "×", "("]), expected: try! Expression(["19", "×"])),
      (expression: try! Expression(["19", ")"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "+"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "÷"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "×"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["19", "-"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["190"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["191"]), expected: try! Expression(["19"])),
      (expression: try! Expression(["199"]), expected: try! Expression(["19"])),
    ]

    for fixture in fixtures {
      let expression = fixture.expression
      let expected = fixture.expected
      let actual = expression.dropped()

      XCTAssertEqual(expected, actual, "expression: \(expression)")
    }
  }
}

// MARK: - Evaluation

extension ExpressionTests {
  func testEvaluate() {
    for fixture in fixtures {
      let infixTokens = fixture.infixTokens
      let expected = fixture.value

      let expression = try! Expression(infixTokens)
      let actual = try! expression.evaluate()

      XCTAssertEqual(expected, actual, "infixTokens: \(infixTokens)")
    }
  }

  func testEvaluateError() {
    typealias Fixture = (
      infixTokens: [String],
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      ([")"], .missingParenthesisOpen),
      (["("], .missingParenthesisClose),
      (["+"], .missingOperand),
      (["1", "+"], .missingOperand),
      (["1", "1"], .missingOperator),
      (["1", "0", "÷"], .divisionByZero),
      (["9223372036854775807", "1", "+"], .operationOverflow),
      (["-9223372036854775808", "-1", "÷"], .operationOverflow),
      (["-9223372036854775808", "-1", "×"], .operationOverflow),
      (["9223372036854775807", "-1", "-"], .operationOverflow),
    ]

    for fixture in fixtures {
      let infixTokens = fixture.infixTokens
      let expected = fixture.expected

      let expression = try! Expression(infixTokens)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testEvaluatePerformance() {
    self.measure {
      for fixture in fixtures {
        let infixTokens = fixture.infixTokens
        let expected = fixture.value

        let expression = try! Expression(infixTokens)
        let actual = try! expression.evaluate()

        XCTAssertEqual(expected, actual, "infixTokens: \(infixTokens)")
      }
    }
  }
}
