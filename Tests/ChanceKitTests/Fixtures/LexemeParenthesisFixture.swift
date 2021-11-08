@testable import ChanceKit

typealias LexemeParenthesisFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  token: Parenthesis,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

let lexemeParenthesisFixtures: [LexemeParenthesisFixture] = [
  // MARK: - Empty

  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["("],
    withTokens: [Parenthesis.open],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: [")"],
    withTokens: [Parenthesis.close],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - (

  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["(", "("],
    withTokens: [Parenthesis.open, Parenthesis.open],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["(", ")"],
    withTokens: [Parenthesis.open, Parenthesis.close],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),

  // MARK: - )

  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: [")", "×", "("],
    withTokens: [Parenthesis.close, Operator.multiplication, Parenthesis.open],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: [")", ")"],
    withTokens: [Parenthesis.close, Parenthesis.close],
    droppedLexemes: [")"],
    droppedTokens: [Parenthesis.close]
  ),

  // MARK: - +

  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["+", "("],
    withTokens: [Operator.addition, Parenthesis.open],
    droppedLexemes: ["+"],
    droppedTokens: [Operator.addition]
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["+", ")"],
    withTokens: [Operator.addition, Parenthesis.close],
    droppedLexemes: ["+"],
    droppedTokens: [Operator.addition]
  ),

  // MARK: - ÷

  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["÷", "("],
    withTokens: [Operator.division, Parenthesis.open],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["÷", ")"],
    withTokens: [Operator.division, Parenthesis.close],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),

  // MARK: - ×

  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["×", "("],
    withTokens: [Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["×", ")"],
    withTokens: [Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),

  // MARK: - "-"

  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["-", "("],
    withTokens: [Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["-", ")"],
    withTokens: [Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),

  // MARK: - 0

  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["0", "×", "("],
    withTokens: [Constant(term: 0), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["0", "×"],
    droppedTokens: [Constant(term: 0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["0", ")"],
    withTokens: [Constant(term: 0), Parenthesis.close],
    droppedLexemes: ["0"],
    droppedTokens: [Constant(term: 0)]
  ),

  // MARK: - 1

  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "("],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Constant(term: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", ")"],
    withTokens: [Constant(term: 1), Parenthesis.close],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),

  // MARK: - 9

  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["9", "×", "("],
    withTokens: [Constant(term: 9), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["9", "×"],
    droppedTokens: [Constant(term: 9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["9", ")"],
    withTokens: [Constant(term: 9), Parenthesis.close],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),

  // MARK: - 1 × (

  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "(", "("],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open, Parenthesis.open],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "×", "(", ")"],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open, Parenthesis.close],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1)

  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", ")", "×", "("],
    withTokens: [Constant(term: 1), Parenthesis.close, Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Constant(term: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", ")", ")"],
    withTokens: [Constant(term: 1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Constant(term: 1), Parenthesis.close]
  ),

  // MARK: - 1 +

  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "+", "("],
    withTokens: [Constant(term: 1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Constant(term: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "+", ")"],
    withTokens: [Constant(term: 1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Constant(term: 1), Operator.addition]
  ),

  // MARK: - 1 ÷

  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "÷", "("],
    withTokens: [Constant(term: 1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Constant(term: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "÷", ")"],
    withTokens: [Constant(term: 1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Constant(term: 1), Operator.division]
  ),

  // MARK: - 1 ×

  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "("],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Constant(term: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "×", ")"],
    withTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Constant(term: 1), Operator.multiplication]
  ),

  // MARK: - "1 -"

  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "-", "("],
    withTokens: [Constant(term: 1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Constant(term: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "-", ")"],
    withTokens: [Constant(term: 1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Constant(term: 1), Operator.subtraction]
  ),

  // MARK: - 10

  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["10", "×", "("],
    withTokens: [Constant(term: 10), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["10", "×"],
    droppedTokens: [Constant(term: 10), Operator.multiplication]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["10", ")"],
    withTokens: [Constant(term: 10), Parenthesis.close],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),

  // MARK: - 11

  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["11", "×", "("],
    withTokens: [Constant(term: 11), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["11", "×"],
    droppedTokens: [Constant(term: 11), Operator.multiplication]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["11", ")"],
    withTokens: [Constant(term: 11), Parenthesis.close],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),

  // MARK: - 19

  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["19", "×", "("],
    withTokens: [Constant(term: 19), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["19", "×"],
    droppedTokens: [Constant(term: 19), Operator.multiplication]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["19", ")"],
    withTokens: [Constant(term: 19), Parenthesis.close],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),

  // MARK: - 1d0 × (

  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", "×", "(", "("],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", "×", "(", ")"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.close,
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d0)

  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", ")", "×", "("],
    withTokens: [
      Roll(times: 1, sides: 0),
      Parenthesis.close,
      Operator.multiplication,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d0", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", ")", ")"],
    withTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d0", ")"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close]
  ),

  // MARK: - 1d0 +

  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", "+", "("],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d0", "+"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.addition]
  ),
  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", "+", ")"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d0", "+"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.addition]
  ),

  // MARK: - 1d0 ÷

  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", "÷", "("],
    withTokens: [Roll(times: 1, sides: 0), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d0", "÷"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.division]
  ),
  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", "÷", ")"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d0", "÷"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.division]
  ),

  // MARK: - 1d0 ×

  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", "×", "("],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d0", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", "×", ")"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d0", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication]
  ),

  // MARK: - "1d0 -"

  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", "-", "("],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d0", "-"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", "-", ")"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d0", "-"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.subtraction]
  ),

  // MARK: - 1d0

  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d0", "×", "("],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d0", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d0", ")"],
    withTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    droppedLexemes: ["1d0"],
    droppedTokens: [Roll(times: 1, sides: 0)]
  ),

  // MARK: - 1d1 × (

  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "×", "(", "("],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "×", "(", ")"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.close,
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d1)

  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", ")", "×", "("],
    withTokens: [
      Roll(times: 1, sides: 1),
      Parenthesis.close,
      Operator.multiplication,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", ")", ")"],
    withTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close]
  ),

  // MARK: - 1d1 +

  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "+", "("],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "+", ")"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.addition]
  ),

  // MARK: - 1d1 ÷

  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "÷", "("],
    withTokens: [Roll(times: 1, sides: 1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "÷", ")"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.division]
  ),

  // MARK: - 1d1 ×

  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "×", "("],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "×", ")"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication]
  ),

  // MARK: - "1d1 -"

  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "-", "("],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "-", ")"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),

  // MARK: - 1d1

  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "×", "("],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", ")"],
    withTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),

  // MARK: - 1d9 × (

  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", "×", "(", "("],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", "×", "(", ")"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.close,
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d9)

  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", ")", "×", "("],
    withTokens: [
      Roll(times: 1, sides: 9),
      Parenthesis.close,
      Operator.multiplication,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d9", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", ")", ")"],
    withTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d9", ")"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close]
  ),

  // MARK: - 1d9 +

  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", "+", "("],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d9", "+"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.addition]
  ),
  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", "+", ")"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d9", "+"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.addition]
  ),

  // MARK: - 1d9 ÷

  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", "÷", "("],
    withTokens: [Roll(times: 1, sides: 9), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d9", "÷"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.division]
  ),
  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", "÷", ")"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d9", "÷"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.division]
  ),

  // MARK: - 1d9 ×

  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", "×", "("],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d9", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", "×", ")"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d9", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication]
  ),

  // MARK: - "1d9 -"

  (
    withoutLexemes: ["1d9", "-"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", "-", "("],
    withTokens: [Roll(times: 1, sides: 9), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d9", "-"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d9", "-"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", "-", ")"],
    withTokens: [Roll(times: 1, sides: 9), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d9", "-"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.subtraction]
  ),

  // MARK: - 1d9

  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d9", "×", "("],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d9", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d9", ")"],
    withTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),

  // MARK: - 1d × (

  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "×", "(", "("],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "×", "(", ")"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.close,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d)

  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", ")", "×", "("],
    withTokens: [
      RollPositiveSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", ")", ")"],
    withTokens: [RollPositiveSides(times: 1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close]
  ),

  // MARK: - 1d +

  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "+", "("],
    withTokens: [RollPositiveSides(times: 1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "+", ")"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.addition]
  ),

  // MARK: - 1d ÷

  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "÷", "("],
    withTokens: [RollPositiveSides(times: 1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "÷", ")"],
    withTokens: [RollPositiveSides(times: 1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.division]
  ),

  // MARK: - 1d ×

  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "×", "("],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "×", ")"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication]
  ),

  // MARK: - "1d -"

  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "-", "("],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "-", ")"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.subtraction]
  ),

  // MARK: - 1d

  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "×", "("],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", ")"],
    withTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - 1d- × (

  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", "×", "(", "("],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", "×", "(", ")"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.close,
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d-)

  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", ")", "×", "("],
    withTokens: [
      RollNegativeSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d-", ")", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", ")", ")"],
    withTokens: [RollNegativeSides(times: 1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d-", ")"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close]
  ),

  // MARK: - 1d- +

  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", "+", "("],
    withTokens: [RollNegativeSides(times: 1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d-", "+"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", "+", ")"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d-", "+"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.addition]
  ),

  // MARK: - 1d- ÷

  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", "÷", "("],
    withTokens: [RollNegativeSides(times: 1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d-", "÷"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", "÷", ")"],
    withTokens: [RollNegativeSides(times: 1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d-", "÷"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.division]
  ),

  // MARK: - 1d- ×

  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", "×", "("],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d-", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", "×", ")"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d-", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication]
  ),

  // MARK: - "1d- -"

  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", "-", "("],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d-", "-"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", "-", ")"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d-", "-"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.subtraction]
  ),

  // MARK: - 1d-

  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d-", "×", "("],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d-", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d-", ")"],
    withTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
]
