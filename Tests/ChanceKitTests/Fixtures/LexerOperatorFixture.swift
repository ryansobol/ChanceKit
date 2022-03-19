@testable import ChanceKit

typealias LexerOperatorFixture = (
  withoutLexemes: [String],
  withoutTokens: [any Tokenable],
  lexeme: String,
  token: Operator,
  withLexemes: [String],
  withTokens: [any Tokenable],
  droppedLexemes: [String],
  droppedTokens: [any Tokenable]
)

let lexerOperatorFixtures: [LexerOperatorFixture] = [
  // MARK: - Empty

  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["+"],
    withTokens: [Operator.addition],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["÷"],
    withTokens: [Operator.division],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["×"],
    withTokens: [Operator.multiplication],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["-"],
    withTokens: [Operator.subtraction],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - (

  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["(", "+"],
    withTokens: [Parenthesis.open, Operator.addition],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["(", "÷"],
    withTokens: [Parenthesis.open, Operator.division],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["(", "×"],
    withTokens: [Parenthesis.open, Operator.multiplication],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["(", "-"],
    withTokens: [Parenthesis.open, Operator.subtraction],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),

  // MARK: - )

  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: [")", "+"],
    withTokens: [Parenthesis.close, Operator.addition],
    droppedLexemes: [")"],
    droppedTokens: [Parenthesis.close]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: [")", "÷"],
    withTokens: [Parenthesis.close, Operator.division],
    droppedLexemes: [")"],
    droppedTokens: [Parenthesis.close]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: [")", "×"],
    withTokens: [Parenthesis.close, Operator.multiplication],
    droppedLexemes: [")"],
    droppedTokens: [Parenthesis.close]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: [")", "-"],
    withTokens: [Parenthesis.close, Operator.subtraction],
    droppedLexemes: [")"],
    droppedTokens: [Parenthesis.close]
  ),

  // MARK: - +

  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["+"],
    withTokens: [Operator.addition],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["÷"],
    withTokens: [Operator.division],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["×"],
    withTokens: [Operator.multiplication],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["-"],
    withTokens: [Operator.subtraction],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - ÷

  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["+"],
    withTokens: [Operator.addition],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["÷"],
    withTokens: [Operator.division],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["×"],
    withTokens: [Operator.multiplication],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["-"],
    withTokens: [Operator.subtraction],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["-"],
    withTokens: [Operator.subtraction],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - ×

  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["+"],
    withTokens: [Operator.addition],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["÷"],
    withTokens: [Operator.division],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["×"],
    withTokens: [Operator.multiplication],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["-"],
    withTokens: [Operator.subtraction],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - "-"

  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["+"],
    withTokens: [Operator.addition],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["÷"],
    withTokens: [Operator.division],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["×"],
    withTokens: [Operator.multiplication],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["-", "(", "-"],
    withTokens: [Operator.subtraction, Parenthesis.open, Operator.subtraction],
    droppedLexemes: ["-", "("],
    droppedTokens: [Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 0

  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["0", "+"],
    withTokens: [Constant(term: 0), Operator.addition],
    droppedLexemes: ["0"],
    droppedTokens: [Constant(term: 0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["0", "÷"],
    withTokens: [Constant(term: 0), Operator.division],
    droppedLexemes: ["0"],
    droppedTokens: [Constant(term: 0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["0", "×"],
    withTokens: [Constant(term: 0), Operator.multiplication],
    droppedLexemes: ["0"],
    droppedTokens: [Constant(term: 0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["0", "-"],
    withTokens: [Constant(term: 0), Operator.subtraction],
    droppedLexemes: ["0"],
    droppedTokens: [Constant(term: 0)]
  ),

  // MARK: - 1

  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Constant(term: 1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Constant(term: 1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Constant(term: 1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Constant(term: 1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),

  // MARK: - 9

  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["9", "+"],
    withTokens: [Constant(term: 9), Operator.addition],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["9", "÷"],
    withTokens: [Constant(term: 9), Operator.division],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["9", "×"],
    withTokens: [Constant(term: 9), Operator.multiplication],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["9", "-"],
    withTokens: [Constant(term: 9), Operator.subtraction],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),

  // MARK: - 1 × (

  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "×", "(", "+"],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open, Operator.addition],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "×", "(", "÷"],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open, Operator.division],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×", "(", "×"],
    withTokens: [
      Constant(term: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication,
    ],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "×", "(", "-"],
    withTokens: [
      Constant(term: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1)

  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", ")", "+"],
    withTokens: [Constant(term: 1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Constant(term: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", ")", "÷"],
    withTokens: [Constant(term: 1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Constant(term: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", ")", "×"],
    withTokens: [Constant(term: 1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Constant(term: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", ")", "-"],
    withTokens: [Constant(term: 1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Constant(term: 1), Parenthesis.close]
  ),

  // MARK: - 1 +

  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Constant(term: 1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Constant(term: 1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Constant(term: 1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Constant(term: 1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),

  // MARK: - 1 ÷

  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Constant(term: 1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Constant(term: 1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Constant(term: 1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Constant(term: 1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),

  // MARK: - 1 ×

  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Constant(term: 1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Constant(term: 1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Constant(term: 1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Constant(term: 1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),

  // MARK: - "1 -"

  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Constant(term: 1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Constant(term: 1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Constant(term: 1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-", "(", "-"],
    withTokens: [
      Constant(term: 1),
      Operator.subtraction,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1", "-", "("],
    droppedTokens: [Constant(term: 1), Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 10

  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["10", "+"],
    withTokens: [Constant(term: 10), Operator.addition],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["10", "÷"],
    withTokens: [Constant(term: 10), Operator.division],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["10", "×"],
    withTokens: [Constant(term: 10), Operator.multiplication],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["10", "-"],
    withTokens: [Constant(term: 10), Operator.subtraction],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),

  // MARK: - 11

  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["11", "+"],
    withTokens: [Constant(term: 11), Operator.addition],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["11", "÷"],
    withTokens: [Constant(term: 11), Operator.division],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["11", "×"],
    withTokens: [Constant(term: 11), Operator.multiplication],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["11", "-"],
    withTokens: [Constant(term: 11), Operator.subtraction],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),

  // MARK: - 19

  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["19", "+"],
    withTokens: [Constant(term: 19), Operator.addition],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["19", "÷"],
    withTokens: [Constant(term: 19), Operator.division],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["19", "×"],
    withTokens: [Constant(term: 19), Operator.multiplication],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["19", "-"],
    withTokens: [Constant(term: 19), Operator.subtraction],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),

  // MARK: - 1d0 × (

  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", "×", "(", "+"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Operator.addition,
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", "×", "(", "÷"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Operator.division,
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", "×", "(", "×"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication,
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", "×", "(", "-"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d0)

  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", ")", "+"],
    withTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d0", ")"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", ")", "÷"],
    withTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d0", ")"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", ")", "×"],
    withTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d0", ")"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", ")", "-"],
    withTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d0", ")"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close]
  ),

  // MARK: - 1d0 +

  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", "+"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", "÷"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", "×"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", "-"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),

  // MARK: - 1d0 ÷

  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", "+"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", "÷"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", "×"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", "-"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),

  // MARK: - 1d0 ×

  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", "+"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", "÷"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", "×"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", "-"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),

  // MARK: - "1d0 -"

  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", "+"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", "÷"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", "×"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", "-", "(", "-"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.subtraction,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d0", "-", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 1d0

  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d0", "+"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d0", "÷"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d0", "×"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),
  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d0", "-"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),

  // MARK: - 1d1 × (

  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "×", "(", "+"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.addition,
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "×", "(", "÷"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.division,
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×", "(", "×"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication,
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "×", "(", "-"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d1)

  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", ")", "+"],
    withTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", ")", "÷"],
    withTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", ")", "×"],
    withTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", ")", "-"],
    withTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close]
  ),

  // MARK: - 1d1 +

  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),

  // MARK: - 1d1 ÷

  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),

  // MARK: - 1d1 ×

  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),

  // MARK: - "1d1 -"

  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-", "(", "-"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.subtraction,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d1", "-", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 1d1

  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),

  // MARK: - 1d9 × (

  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", "×", "(", "+"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Operator.addition,
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", "×", "(", "÷"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Operator.division,
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", "×", "(", "×"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication,
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", "×", "(", "-"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d9)

  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", ")", "+"],
    withTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d9", ")"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", ")", "÷"],
    withTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d9", ")"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", ")", "×"],
    withTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d9", ")"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", ")", "-"],
    withTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d9", ")"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close]
  ),

  // MARK: - 1d9 +

  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", "+"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", "÷"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", "×"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", "-"],
    withTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),

  // MARK: - 1d9 ÷

  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", "+"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", "÷"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", "×"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", "-"],
    withTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),

  // MARK: - 1d9 ×

  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", "+"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", "÷"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", "×"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", "-"],
    withTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),

  // MARK: - "1d9 -"

  (
    withoutLexemes: ["1d9", "-"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", "+"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "-"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", "÷"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "-"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", "×"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9", "-"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", "-", "(", "-"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.subtraction,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d9", "-", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 1d9

  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d9", "+"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d9", "÷"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d9", "×"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d9", "-"],
    withTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),

  // MARK: - 1d × (

  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "×", "(", "+"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.addition,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "×", "(", "÷"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.division,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×", "(", "×"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "×", "(", "-"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d)

  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", ")", "+"],
    withTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", ")", "÷"],
    withTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", ")", "×"],
    withTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", ")", "-"],
    withTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close]
  ),

  // MARK: - 1d +

  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [RollPositiveSides(times: 1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - 1d ÷

  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [RollPositiveSides(times: 1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - 1d ×

  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [RollPositiveSides(times: 1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - "1d -"

  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [RollPositiveSides(times: 1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-", "(", "-"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.subtraction,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d", "-", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 1d

  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d"],
    withTokens: [RollPositiveSides(times: 1)],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [RollPositiveSides(times: 1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-"],
    withTokens: [RollNegativeSides(times: 1)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - 1d- × (

  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d-", "×", "(", "+"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.addition,
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", "×", "(", "÷"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.division,
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", "×", "(", "×"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication,
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-", "×", "(", "-"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d-)

  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d-", ")", "+"],
    withTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d-", ")"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", ")", "÷"],
    withTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d-", ")"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", ")", "×"],
    withTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d-", ")"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-", ")", "-"],
    withTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d-", ")"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close]
  ),

  // MARK: - 1d- +

  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d-", "+"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", "÷"],
    withTokens: [RollNegativeSides(times: 1), Operator.division],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", "×"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-", "-"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),

  // MARK: - 1d- ÷

  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d-", "+"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", "÷"],
    withTokens: [RollNegativeSides(times: 1), Operator.division],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", "×"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-", "-"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),

  // MARK: - 1d- ×

  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d-", "+"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", "÷"],
    withTokens: [RollNegativeSides(times: 1), Operator.division],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", "×"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-", "-"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),

  // MARK: - "1d- -"

  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d-", "+"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", "÷"],
    withTokens: [RollNegativeSides(times: 1), Operator.division],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", "×"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-", "-", "(", "-"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.subtraction,
      Parenthesis.open,
      Operator.subtraction,
    ],
    droppedLexemes: ["1d-", "-", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.subtraction, Parenthesis.open]
  ),

  // MARK: - 1d-

  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d"],
    withTokens: [RollPositiveSides(times: 1)],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d-", "÷"],
    withTokens: [RollNegativeSides(times: 1), Operator.division],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d-", "×"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d-"],
    withTokens: [RollNegativeSides(times: 1)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
]
