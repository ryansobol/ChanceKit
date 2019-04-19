import Calculator
import XCTest

class ExpressionTests: XCTestCase {
  typealias Fixture = (
    lexemes: [String],
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
  func testInitWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithUnevaluableLexemes() {
    typealias Fixture = (
      lexemes: [String],
      expected: String
    )

    let fixtures: [Fixture] = [
      (lexemes: [], expected: ""),
      (lexemes: ["("], expected: "("),
      (lexemes: [")"], expected: ")"),
      (lexemes: ["+"], expected: "+"),
      (lexemes: ["÷"], expected: "÷"),
      (lexemes: ["×"], expected: "×"),
      (lexemes: ["-"], expected: "-"),
      (lexemes: [String(Int.max)], expected: String(Int.max)),
      (lexemes: [String(Int.min)], expected: String(Int.min)),
    ]

    for fixture in fixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.expected

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithInvalidLexemes() {
    typealias Fixture = (
      lexemes: [String],
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      (lexemes: ["d"], expected: .invalidLexeme("d")),
      (lexemes: ["="], expected: .invalidLexeme("=")),
      (lexemes: ["["], expected: .invalidLexeme("[")),
      (lexemes: ["{"], expected: .invalidLexeme("{")),
      (lexemes: ["<"], expected: .invalidLexeme("<")),
      (lexemes: ["."], expected: .invalidLexeme(".")),
      (lexemes: [","], expected: .invalidLexeme(",")),
      (lexemes: [","], expected: .invalidLexeme(",")),
      (lexemes: ["**"], expected: .invalidLexeme("**")),
      (lexemes: ["&"], expected: .invalidLexeme("&")),
      (lexemes: ["|"], expected: .invalidLexeme("|")),
      (lexemes: ["!"], expected: .invalidLexeme("!")),
      (lexemes: ["~"], expected: .invalidLexeme("~")),
      (lexemes: ["..<"], expected: .invalidLexeme("..<")),
      (lexemes: ["..."], expected: .invalidLexeme("...")),
      (lexemes: ["<<"], expected: .invalidLexeme("<<")),
      (lexemes: [">>"], expected: .invalidLexeme(">>")),
      (lexemes: ["%"], expected: .invalidLexeme("%")),
    ]

    for fixture in fixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.expected

      XCTAssertThrowsError(try Expression(lexemes)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}

// MARK: - Inclusion

extension ExpressionTests {
  //  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
  func testPushedWithValidLexemes() {
    typealias Fixture = (
      lexemes: [String],
      lexeme: String,
      expected: String
    )

    let fixtures: [Fixture] = [
      (lexemes: [], lexeme: "(", expected: "("),
      (lexemes: [], lexeme: ")", expected: ")"),
      (lexemes: [], lexeme: "+", expected: "+"),
      (lexemes: [], lexeme: "÷", expected: "÷"),
      (lexemes: [], lexeme: "×", expected: "×"),
      (lexemes: [], lexeme: "-", expected: "-"),
      (lexemes: [], lexeme: "0", expected: "0"),
      (lexemes: [], lexeme: "1", expected: "1"),
      (lexemes: [], lexeme: "9", expected: "9"),

      (lexemes: ["("], lexeme: "(", expected: "(("),
      (lexemes: ["("], lexeme: ")", expected: "()"),
      (lexemes: ["("], lexeme: "+", expected: "( +"),
      (lexemes: ["("], lexeme: "÷", expected: "( ÷"),
      (lexemes: ["("], lexeme: "×", expected: "( ×"),
      (lexemes: ["("], lexeme: "-", expected: "( -"),
      (lexemes: ["("], lexeme: "0", expected: "(0"),
      (lexemes: ["("], lexeme: "1", expected: "(1"),
      (lexemes: ["("], lexeme: "9", expected: "(9"),

      (lexemes: [")"], lexeme: "(", expected: ") × ("),
      (lexemes: [")"], lexeme: ")", expected: "))"),
      (lexemes: [")"], lexeme: "+", expected: ") +"),
      (lexemes: [")"], lexeme: "÷", expected: ") ÷"),
      (lexemes: [")"], lexeme: "×", expected: ") ×"),
      (lexemes: [")"], lexeme: "-", expected: ") -"),
      (lexemes: [")"], lexeme: "0", expected: ") × 0"),
      (lexemes: [")"], lexeme: "1", expected: ") × 1"),
      (lexemes: [")"], lexeme: "9", expected: ") × 9"),

      (lexemes: ["+"], lexeme: "(", expected: "+ ("),
      (lexemes: ["+"], lexeme: ")", expected: "+ )"),
      (lexemes: ["+"], lexeme: "+", expected: "+"),
      (lexemes: ["+"], lexeme: "÷", expected: "÷"),
      (lexemes: ["+"], lexeme: "×", expected: "×"),
      (lexemes: ["+"], lexeme: "-", expected: "-"),
      (lexemes: ["+"], lexeme: "0", expected: "0"),
      (lexemes: ["+"], lexeme: "1", expected: "1"),
      (lexemes: ["+"], lexeme: "9", expected: "9"),

      (lexemes: ["÷"], lexeme: "(", expected: "÷ ("),
      (lexemes: ["÷"], lexeme: ")", expected: "÷ )"),
      (lexemes: ["÷"], lexeme: "+", expected: "+"),
      (lexemes: ["÷"], lexeme: "÷", expected: "÷"),
      (lexemes: ["÷"], lexeme: "×", expected: "×"),
      (lexemes: ["÷"], lexeme: "-", expected: "-"),
      (lexemes: ["÷"], lexeme: "0", expected: "÷ 0"),
      (lexemes: ["÷"], lexeme: "1", expected: "÷ 1"),
      (lexemes: ["÷"], lexeme: "9", expected: "÷ 9"),

      (lexemes: ["×"], lexeme: "(", expected: "× ("),
      (lexemes: ["×"], lexeme: ")", expected: "× )"),
      (lexemes: ["×"], lexeme: "+", expected: "+"),
      (lexemes: ["×"], lexeme: "÷", expected: "÷"),
      (lexemes: ["×"], lexeme: "×", expected: "×"),
      (lexemes: ["×"], lexeme: "-", expected: "-"),
      (lexemes: ["×"], lexeme: "0", expected: "× 0"),
      (lexemes: ["×"], lexeme: "1", expected: "× 1"),
      (lexemes: ["×"], lexeme: "9", expected: "× 9"),

      (lexemes: ["-"], lexeme: "(", expected: "- ("),
      (lexemes: ["-"], lexeme: ")", expected: "- )"),
      (lexemes: ["-"], lexeme: "+", expected: "+"),
      (lexemes: ["-"], lexeme: "÷", expected: "÷"),
      (lexemes: ["-"], lexeme: "×", expected: "×"),
      (lexemes: ["-"], lexeme: "-", expected: "-"),
      (lexemes: ["-"], lexeme: "0", expected: "0"),
      (lexemes: ["-"], lexeme: "1", expected: "-1"),
      (lexemes: ["-"], lexeme: "9", expected: "-9"),

      (lexemes: ["0"], lexeme: "(", expected: "0 × ("),
      (lexemes: ["0"], lexeme: ")", expected: "0)"),
      (lexemes: ["0"], lexeme: "+", expected: "0 +"),
      (lexemes: ["0"], lexeme: "÷", expected: "0 ÷"),
      (lexemes: ["0"], lexeme: "×", expected: "0 ×"),
      (lexemes: ["0"], lexeme: "-", expected: "0 -"),
      (lexemes: ["0"], lexeme: "0", expected: "0"),
      (lexemes: ["0"], lexeme: "1", expected: "1"),
      (lexemes: ["0"], lexeme: "9", expected: "9"),

      (lexemes: ["1"], lexeme: "(", expected: "1 × ("),
      (lexemes: ["1"], lexeme: ")", expected: "1)"),
      (lexemes: ["1"], lexeme: "+", expected: "1 +"),
      (lexemes: ["1"], lexeme: "÷", expected: "1 ÷"),
      (lexemes: ["1"], lexeme: "×", expected: "1 ×"),
      (lexemes: ["1"], lexeme: "-", expected: "1 -"),
      (lexemes: ["1"], lexeme: "0", expected: "10"),
      (lexemes: ["1"], lexeme: "1", expected: "11"),
      (lexemes: ["1"], lexeme: "9", expected: "19"),

      (lexemes: ["9"], lexeme: "(", expected: "9 × ("),
      (lexemes: ["9"], lexeme: ")", expected: "9)"),
      (lexemes: ["9"], lexeme: "+", expected: "9 +"),
      (lexemes: ["9"], lexeme: "÷", expected: "9 ÷"),
      (lexemes: ["9"], lexeme: "×", expected: "9 ×"),
      (lexemes: ["9"], lexeme: "-", expected: "9 -"),
      (lexemes: ["9"], lexeme: "0", expected: "90"),
      (lexemes: ["9"], lexeme: "1", expected: "91"),
      (lexemes: ["9"], lexeme: "9", expected: "99"),

      (lexemes: ["1", "×", "("], lexeme: "(", expected: "1 × (("),
      (lexemes: ["1", "×", "("], lexeme: ")", expected: "1 × ()"),
      (lexemes: ["1", "×", "("], lexeme: "+", expected: "1 × ( +"),
      (lexemes: ["1", "×", "("], lexeme: "÷", expected: "1 × ( ÷"),
      (lexemes: ["1", "×", "("], lexeme: "×", expected: "1 × ( ×"),
      (lexemes: ["1", "×", "("], lexeme: "-", expected: "1 × ( -"),
      (lexemes: ["1", "×", "("], lexeme: "0", expected: "1 × (0"),
      (lexemes: ["1", "×", "("], lexeme: "1", expected: "1 × (1"),
      (lexemes: ["1", "×", "("], lexeme: "9", expected: "1 × (9"),

      (lexemes: ["1", ")"], lexeme: "(", expected: "1) × ("),
      (lexemes: ["1", ")"], lexeme: ")", expected: "1))"),
      (lexemes: ["1", ")"], lexeme: "+", expected: "1) +"),
      (lexemes: ["1", ")"], lexeme: "÷", expected: "1) ÷"),
      (lexemes: ["1", ")"], lexeme: "×", expected: "1) ×"),
      (lexemes: ["1", ")"], lexeme: "-", expected: "1) -"),
      (lexemes: ["1", ")"], lexeme: "0", expected: "1) × 0"),
      (lexemes: ["1", ")"], lexeme: "1", expected: "1) × 1"),
      (lexemes: ["1", ")"], lexeme: "9", expected: "1) × 9"),

      (lexemes: ["1", "+"], lexeme: "(", expected: "1 + ("),
      (lexemes: ["1", "+"], lexeme: ")", expected: "1 + )"),
      (lexemes: ["1", "+"], lexeme: "+", expected: "1 +"),
      (lexemes: ["1", "+"], lexeme: "÷", expected: "1 ÷"),
      (lexemes: ["1", "+"], lexeme: "×", expected: "1 ×"),
      (lexemes: ["1", "+"], lexeme: "-", expected: "1 -"),
      (lexemes: ["1", "+"], lexeme: "0", expected: "1 + 0"),
      (lexemes: ["1", "+"], lexeme: "1", expected: "1 + 1"),
      (lexemes: ["1", "+"], lexeme: "9", expected: "1 + 9"),

      (lexemes: ["1", "÷"], lexeme: "(", expected: "1 ÷ ("),
      (lexemes: ["1", "÷"], lexeme: ")", expected: "1 ÷ )"),
      (lexemes: ["1", "÷"], lexeme: "+", expected: "1 +"),
      (lexemes: ["1", "÷"], lexeme: "÷", expected: "1 ÷"),
      (lexemes: ["1", "÷"], lexeme: "×", expected: "1 ×"),
      (lexemes: ["1", "÷"], lexeme: "-", expected: "1 -"),
      (lexemes: ["1", "÷"], lexeme: "0", expected: "1 ÷ 0"),
      (lexemes: ["1", "÷"], lexeme: "1", expected: "1 ÷ 1"),
      (lexemes: ["1", "÷"], lexeme: "9", expected: "1 ÷ 9"),

      (lexemes: ["1", "×"], lexeme: "(", expected: "1 × ("),
      (lexemes: ["1", "×"], lexeme: ")", expected: "1 × )"),
      (lexemes: ["1", "×"], lexeme: "+", expected: "1 +"),
      (lexemes: ["1", "×"], lexeme: "÷", expected: "1 ÷"),
      (lexemes: ["1", "×"], lexeme: "×", expected: "1 ×"),
      (lexemes: ["1", "×"], lexeme: "-", expected: "1 -"),
      (lexemes: ["1", "×"], lexeme: "0", expected: "1 × 0"),
      (lexemes: ["1", "×"], lexeme: "1", expected: "1 × 1"),
      (lexemes: ["1", "×"], lexeme: "9", expected: "1 × 9"),

      (lexemes: ["1", "-"], lexeme: "(", expected: "1 - ("),
      (lexemes: ["1", "-"], lexeme: ")", expected: "1 - )"),
      (lexemes: ["1", "-"], lexeme: "+", expected: "1 +"),
      (lexemes: ["1", "-"], lexeme: "÷", expected: "1 ÷"),
      (lexemes: ["1", "-"], lexeme: "×", expected: "1 ×"),
      (lexemes: ["1", "-"], lexeme: "-", expected: "1 -"),
      (lexemes: ["1", "-"], lexeme: "0", expected: "1 - 0"),
      (lexemes: ["1", "-"], lexeme: "1", expected: "1 - 1"),
      (lexemes: ["1", "-"], lexeme: "9", expected: "1 - 9"),

      (lexemes: ["10"], lexeme: "(", expected: "10 × ("),
      (lexemes: ["10"], lexeme: ")", expected: "10)"),
      (lexemes: ["10"], lexeme: "+", expected: "10 +"),
      (lexemes: ["10"], lexeme: "÷", expected: "10 ÷"),
      (lexemes: ["10"], lexeme: "×", expected: "10 ×"),
      (lexemes: ["10"], lexeme: "-", expected: "10 -"),
      (lexemes: ["10"], lexeme: "0", expected: "100"),
      (lexemes: ["10"], lexeme: "1", expected: "101"),
      (lexemes: ["10"], lexeme: "9", expected: "109"),

      (lexemes: ["11"], lexeme: "(", expected: "11 × ("),
      (lexemes: ["11"], lexeme: ")", expected: "11)"),
      (lexemes: ["11"], lexeme: "+", expected: "11 +"),
      (lexemes: ["11"], lexeme: "÷", expected: "11 ÷"),
      (lexemes: ["11"], lexeme: "×", expected: "11 ×"),
      (lexemes: ["11"], lexeme: "-", expected: "11 -"),
      (lexemes: ["11"], lexeme: "0", expected: "110"),
      (lexemes: ["11"], lexeme: "1", expected: "111"),
      (lexemes: ["11"], lexeme: "9", expected: "119"),

      (lexemes: ["19"], lexeme: "(", expected: "19 × ("),
      (lexemes: ["19"], lexeme: ")", expected: "19)"),
      (lexemes: ["19"], lexeme: "+", expected: "19 +"),
      (lexemes: ["19"], lexeme: "÷", expected: "19 ÷"),
      (lexemes: ["19"], lexeme: "×", expected: "19 ×"),
      (lexemes: ["19"], lexeme: "-", expected: "19 -"),
      (lexemes: ["19"], lexeme: "0", expected: "190"),
      (lexemes: ["19"], lexeme: "1", expected: "191"),
      (lexemes: ["19"], lexeme: "9", expected: "199"),
    ]

    for fixture in fixtures {
      let lexemes = fixture.lexemes
      let lexeme = fixture.lexeme
      let expected = fixture.expected

      let expression = try! Expression(lexemes)
      let nextExpression = try! expression.pushed(lexeme)
      let actual = String(describing: nextExpression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testPushedWithInvalidLexemes() {
    typealias Fixture = (
      lexeme: String,
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      (lexeme: "=", expected: .invalidLexeme("=")),
      (lexeme: "[", expected: .invalidLexeme("[")),
      (lexeme: "{", expected: .invalidLexeme("{")),
      (lexeme: "<", expected: .invalidLexeme("<")),
      (lexeme: ".", expected: .invalidLexeme(".")),
      (lexeme: ",", expected: .invalidLexeme(",")),
      (lexeme: ",", expected: .invalidLexeme(",")),
      (lexeme: "**", expected: .invalidLexeme("**")),
      (lexeme: "&", expected: .invalidLexeme("&")),
      (lexeme: "|", expected: .invalidLexeme("|")),
      (lexeme: "!", expected: .invalidLexeme("!")),
      (lexeme: "~", expected: .invalidLexeme("~")),
      (lexeme: "..<", expected: .invalidLexeme("..<")),
      (lexeme: "...", expected: .invalidLexeme("...")),
      (lexeme: "<<", expected: .invalidLexeme("<<")),
      (lexeme: ">>", expected: .invalidLexeme(">>")),
      (lexeme: "%", expected: .invalidLexeme("%")),
    ]

    for fixture in fixtures {
      let lexeme = fixture.lexeme
      let expected = fixture.expected
      let expression = try! Expression([])

      XCTAssertThrowsError(try expression.pushed(lexeme)) { error in
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
      let lexemes = fixture.lexemes
      let expected = fixture.value

      let expression = try! Expression(lexemes)
      let actual = try! expression.evaluate()

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testEvaluateError() {
    typealias Fixture = (
      lexemes: [String],
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
      let lexemes = fixture.lexemes
      let expected = fixture.expected

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testEvaluatePerformance() {
    self.measure {
      for fixture in fixtures {
        let lexemes = fixture.lexemes
        let expected = fixture.value

        let expression = try! Expression(lexemes)
        let actual = try! expression.evaluate()

        XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
      }
    }
  }
}
