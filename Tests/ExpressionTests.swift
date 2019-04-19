import Calculator
import XCTest

class ExpressionTests: XCTestCase {}

// MARK: - Initialization

extension ExpressionTests {
  func testInitWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithParsableFixtures() {
    for fixture in parsableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

      let expression = try! Expression(lexemes)
      let actual = String(describing: expression)

      XCTAssertEqual(expected, actual)
    }
  }

  func testInitWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.description

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
  func testEvaluateWithEvaluatableFixtures() {
    for fixture in evaluatableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.value

      let expression = try! Expression(lexemes)
      let actual = try! expression.evaluate()

      XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
    }
  }

  func testEvaluateWithParsableFixtures() {
    for fixture in parsableFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testEvaluateWithLexebleFixtures() {
    for fixture in lexebleFixtures {
      let lexemes = fixture.lexemes
      let expected = fixture.error

      let expression = try! Expression(lexemes)

      XCTAssertThrowsError(try expression.evaluate()) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }

  func testEvaluatePerformance() {
    self.measure {
      for fixture in evaluatableFixtures {
        let lexemes = fixture.lexemes
        let expected = fixture.value

        let expression = try! Expression(lexemes)
        let actual = try! expression.evaluate()

        XCTAssertEqual(expected, actual, "lexemes: \(lexemes)")
      }
    }
  }
}
