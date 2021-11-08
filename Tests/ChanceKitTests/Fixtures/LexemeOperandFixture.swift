@testable import ChanceKit

typealias LexemeOperandFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  token: Operand,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

let lexemeOperandFixtures: [LexemeOperandFixture] = [
  // MARK: - Empty

  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["0"],
    withTokens: [Constant(term: 0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1"],
    withTokens: [Constant(term: 1)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["9"],
    withTokens: [Constant(term: 9)],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - (

  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["(", "0"],
    withTokens: [Parenthesis.open, Constant(term: 0)],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["(", "1"],
    withTokens: [Parenthesis.open, Constant(term: 1)],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["(", "9"],
    withTokens: [Parenthesis.open, Constant(term: 9)],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),

  // MARK: - )

  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: [")", "×", "0"],
    withTokens: [Parenthesis.close, Operator.multiplication, Constant(term: 0)],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: [")", "×", "1"],
    withTokens: [Parenthesis.close, Operator.multiplication, Constant(term: 1)],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: [")", "×", "9"],
    withTokens: [Parenthesis.close, Operator.multiplication, Constant(term: 9)],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - +

  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["0"],
    withTokens: [Constant(term: 0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1"],
    withTokens: [Constant(term: 1)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["9"],
    withTokens: [Constant(term: 9)],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - ÷

  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["÷", "0"],
    withTokens: [Operator.division, Constant(term: 0)],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["÷", "1"],
    withTokens: [Operator.division, Constant(term: 1)],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["÷", "9"],
    withTokens: [Operator.division, Constant(term: 9)],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),

  // MARK: - ×

  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["×", "0"],
    withTokens: [Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["×", "1"],
    withTokens: [Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["×", "9"],
    withTokens: [Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),

  // MARK: - -

  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["0"],
    withTokens: [Constant(term: 0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["-1"],
    withTokens: [Constant(term: -1)],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["-9"],
    withTokens: [Constant(term: -9)],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),

  // MARK: - 0

  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["0"],
    withTokens: [Constant(term: 0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1"],
    withTokens: [Constant(term: 1)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Constant(term: 0)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["9"],
    withTokens: [Constant(term: 9)],
    droppedLexemes: [],
    droppedTokens: []
  ),

  // MARK: - 1

  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["10"],
    withTokens: [Constant(term: 10)],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["11"],
    withTokens: [Constant(term: 11)],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Constant(term: 1)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["19"],
    withTokens: [Constant(term: 19)],
    droppedLexemes: ["1"],
    droppedTokens: [Constant(term: 1)]
  ),

  // MARK: - 9

  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["90"],
    withTokens: [Constant(term: 90)],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["91"],
    withTokens: [Constant(term: 91)],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Constant(term: 9)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["99"],
    withTokens: [Constant(term: 99)],
    droppedLexemes: ["9"],
    droppedTokens: [Constant(term: 9)]
  ),

  // MARK: - 1 × (

  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1", "×", "(", "0"],
    withTokens: [
      Constant(term: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 0),
    ],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1", "×", "(", "1"],
    withTokens: [
      Constant(term: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 1),
    ],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1", "×", "(", "9"],
    withTokens: [
      Constant(term: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 9),
    ],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Constant(term: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1)

  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1", ")", "×", "0"],
    withTokens: [
      Constant(term: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 0),
    ],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Constant(term: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1", ")", "×", "1"],
    withTokens: [
      Constant(term: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 1),
    ],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Constant(term: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Constant(term: 1), Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1", ")", "×", "9"],
    withTokens: [
      Constant(term: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 9),
    ],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Constant(term: 1), Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - 1 +

  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1", "+", "0"],
    withTokens: [Constant(term: 1), Operator.addition, Constant(term: 0)],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Constant(term: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1", "+", "1"],
    withTokens: [Constant(term: 1), Operator.addition, Constant(term: 1)],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Constant(term: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Constant(term: 1), Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1", "+", "9"],
    withTokens: [Constant(term: 1), Operator.addition, Constant(term: 9)],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Constant(term: 1), Operator.addition]
  ),

  // MARK: - 1 ÷

  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1", "÷", "0"],
    withTokens: [Constant(term: 1), Operator.division, Constant(term: 0)],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Constant(term: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1", "÷", "1"],
    withTokens: [Constant(term: 1), Operator.division, Constant(term: 1)],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Constant(term: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Constant(term: 1), Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1", "÷", "9"],
    withTokens: [Constant(term: 1), Operator.division, Constant(term: 9)],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Constant(term: 1), Operator.division]
  ),

  // MARK: - 1 ×

  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1", "×", "0"],
    withTokens: [Constant(term: 1), Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Constant(term: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1", "×", "1"],
    withTokens: [Constant(term: 1), Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Constant(term: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Constant(term: 1), Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1", "×", "9"],
    withTokens: [Constant(term: 1), Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Constant(term: 1), Operator.multiplication]
  ),

  // MARK: - "1 -"

  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1", "-", "0"],
    withTokens: [Constant(term: 1), Operator.subtraction, Constant(term: 0)],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Constant(term: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1", "-", "1"],
    withTokens: [Constant(term: 1), Operator.subtraction, Constant(term: 1)],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Constant(term: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Constant(term: 1), Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1", "-", "9"],
    withTokens: [Constant(term: 1), Operator.subtraction, Constant(term: 9)],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Constant(term: 1), Operator.subtraction]
  ),

  // MARK: - 10

  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["100"],
    withTokens: [Constant(term: 100)],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["101"],
    withTokens: [Constant(term: 101)],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Constant(term: 10)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["109"],
    withTokens: [Constant(term: 109)],
    droppedLexemes: ["10"],
    droppedTokens: [Constant(term: 10)]
  ),

  // MARK: - 11

  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["110"],
    withTokens: [Constant(term: 110)],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["111"],
    withTokens: [Constant(term: 111)],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Constant(term: 11)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["119"],
    withTokens: [Constant(term: 119)],
    droppedLexemes: ["11"],
    droppedTokens: [Constant(term: 11)]
  ),

  // MARK: - 19

  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["190"],
    withTokens: [Constant(term: 190)],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["191"],
    withTokens: [Constant(term: 191)],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Constant(term: 19)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["199"],
    withTokens: [Constant(term: 199)],
    droppedLexemes: ["19"],
    droppedTokens: [Constant(term: 19)]
  ),

  // MARK: - 1d0 × (

  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0", "×", "(", "0"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d0", "×", "(", "1"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d0", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d0", "×", "(", "9"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d0", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d0)

  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0", ")", "×", "0"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d0", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d0", ")", "×", "1"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d0", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0", ")"],
    withoutTokens: [Roll(times: 1, sides: 0), Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d0", ")", "×", "9"],
    withTokens: [
      Roll(times: 1, sides: 0),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d0", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - 1d0 +

  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0", "+", "0"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition, Constant(term: 0)],
    droppedLexemes: ["1d0", "+"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.addition]
  ),
  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d0", "+", "1"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition, Constant(term: 1)],
    droppedLexemes: ["1d0", "+"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.addition]
  ),
  (
    withoutLexemes: ["1d0", "+"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d0", "+", "9"],
    withTokens: [Roll(times: 1, sides: 0), Operator.addition, Constant(term: 9)],
    droppedLexemes: ["1d0", "+"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.addition]
  ),

  // MARK: - 1d0 ÷

  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0", "÷", "0"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division, Constant(term: 0)],
    droppedLexemes: ["1d0", "÷"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.division]
  ),
  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d0", "÷", "1"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division, Constant(term: 1)],
    droppedLexemes: ["1d0", "÷"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.division]
  ),
  (
    withoutLexemes: ["1d0", "÷"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d0", "÷", "9"],
    withTokens: [Roll(times: 1, sides: 0), Operator.division, Constant(term: 9)],
    droppedLexemes: ["1d0", "÷"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.division]
  ),

  // MARK: - 1d0 ×

  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0", "×", "0"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["1d0", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d0", "×", "1"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["1d0", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d0", "×"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d0", "×", "9"],
    withTokens: [Roll(times: 1, sides: 0), Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["1d0", "×"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.multiplication]
  ),

  // MARK: - "1d0 -"

  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0", "-", "0"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction, Constant(term: 0)],
    droppedLexemes: ["1d0", "-"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d0", "-", "1"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction, Constant(term: 1)],
    droppedLexemes: ["1d0", "-"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d0", "-"],
    withoutTokens: [Roll(times: 1, sides: 0), Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d0", "-", "9"],
    withTokens: [Roll(times: 1, sides: 0), Operator.subtraction, Constant(term: 9)],
    droppedLexemes: ["1d0", "-"],
    droppedTokens: [Roll(times: 1, sides: 0), Operator.subtraction]
  ),

  // MARK: - 1d0

  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0"],
    withTokens: [Roll(times: 1, sides: 0)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1"],
    withTokens: [Roll(times: 1, sides: 1)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d0"],
    withoutTokens: [Roll(times: 1, sides: 0)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9"],
    withTokens: [Roll(times: 1, sides: 9)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - 1d1 × (

  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", "×", "(", "0"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", "×", "(", "1"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", "×", "(", "9"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d1)

  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", ")", "×", "0"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", ")", "×", "1"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Roll(times: 1, sides: 1), Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", ")", "×", "9"],
    withTokens: [
      Roll(times: 1, sides: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - 1d1 +

  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", "+", "0"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition, Constant(term: 0)],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", "+", "1"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition, Constant(term: 1)],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", "+", "9"],
    withTokens: [Roll(times: 1, sides: 1), Operator.addition, Constant(term: 9)],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.addition]
  ),

  // MARK: - 1d1 ÷

  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", "÷", "0"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division, Constant(term: 0)],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", "÷", "1"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division, Constant(term: 1)],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", "÷", "9"],
    withTokens: [Roll(times: 1, sides: 1), Operator.division, Constant(term: 9)],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.division]
  ),

  // MARK: - 1d1 ×

  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", "×", "0"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", "×", "1"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", "×", "9"],
    withTokens: [Roll(times: 1, sides: 1), Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.multiplication]
  ),

  // MARK: - "1d1 -"

  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", "-", "0"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Constant(term: 0)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", "-", "1"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Constant(term: 1)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", "-", "9"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Constant(term: 9)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),

  // MARK: - 1d1

  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d10"],
    withTokens: [Roll(times: 1, sides: 10)],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d11"],
    withTokens: [Roll(times: 1, sides: 11)],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Roll(times: 1, sides: 1)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d19"],
    withTokens: [Roll(times: 1, sides: 19)],
    droppedLexemes: ["1d1"],
    droppedTokens: [Roll(times: 1, sides: 1)]
  ),

  // MARK: - 1d9 × (

  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d9", "×", "(", "0"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d9", "×", "(", "1"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d9", "×", "("],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9", "×", "(", "9"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d9", "×", "("],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d9s)

  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d9", ")", "×", "0"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d9", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d9", ")", "×", "1"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d9", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9", ")"],
    withoutTokens: [Roll(times: 1, sides: 9), Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9", ")", "×", "9"],
    withTokens: [
      Roll(times: 1, sides: 9),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d9", ")", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - 1d9 +

  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d9", "+", "0"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition, Constant(term: 0)],
    droppedLexemes: ["1d9", "+"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.addition]
  ),
  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d9", "+", "1"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition, Constant(term: 1)],
    droppedLexemes: ["1d9", "+"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.addition]
  ),
  (
    withoutLexemes: ["1d9", "+"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9", "+", "9"],
    withTokens: [Roll(times: 1, sides: 9), Operator.addition, Constant(term: 9)],
    droppedLexemes: ["1d9", "+"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.addition]
  ),

  // MARK: - 1d9 ÷

  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d9", "÷", "0"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division, Constant(term: 0)],
    droppedLexemes: ["1d9", "÷"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.division]
  ),
  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d9", "÷", "1"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division, Constant(term: 1)],
    droppedLexemes: ["1d9", "÷"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.division]
  ),
  (
    withoutLexemes: ["1d9", "÷"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9", "÷", "9"],
    withTokens: [Roll(times: 1, sides: 9), Operator.division, Constant(term: 9)],
    droppedLexemes: ["1d9", "÷"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.division]
  ),

  // MARK: - 1d9 ×

  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d9", "×", "0"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["1d9", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d9", "×", "1"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["1d9", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d9", "×"],
    withoutTokens: [Roll(times: 1, sides: 9), Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9", "×", "9"],
    withTokens: [Roll(times: 1, sides: 9), Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["1d9", "×"],
    droppedTokens: [Roll(times: 1, sides: 9), Operator.multiplication]
  ),

  // MARK: - "1d1 -"

  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d1", "-", "0"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Constant(term: 0)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1", "-", "1"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Constant(term: 1)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Roll(times: 1, sides: 1), Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d1", "-", "9"],
    withTokens: [Roll(times: 1, sides: 1), Operator.subtraction, Constant(term: 9)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Roll(times: 1, sides: 1), Operator.subtraction]
  ),

  // MARK: - 1d9

  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d90"],
    withTokens: [Roll(times: 1, sides: 90)],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d91"],
    withTokens: [Roll(times: 1, sides: 91)],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),
  (
    withoutLexemes: ["1d9"],
    withoutTokens: [Roll(times: 1, sides: 9)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d99"],
    withTokens: [Roll(times: 1, sides: 99)],
    droppedLexemes: ["1d9"],
    droppedTokens: [Roll(times: 1, sides: 9)]
  ),

  // MARK: - 1d × (

  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d", "×", "(", "0"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d", "×", "(", "1"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d", "×", "(", "9"],
    withTokens: [
      RollPositiveSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d)

  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d", ")", "×", "0"],
    withTokens: [
      RollPositiveSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d", ")", "×", "1"],
    withTokens: [
      RollPositiveSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [RollPositiveSides(times: 1), Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d", ")", "×", "9"],
    withTokens: [
      RollPositiveSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - 1d +

  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d", "+", "0"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition, Constant(term: 0)],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d", "+", "1"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition, Constant(term: 1)],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d", "+", "9"],
    withTokens: [RollPositiveSides(times: 1), Operator.addition, Constant(term: 9)],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.addition]
  ),

  // MARK: - 1d ÷

  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d", "÷", "0"],
    withTokens: [RollPositiveSides(times: 1), Operator.division, Constant(term: 0)],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d", "÷", "1"],
    withTokens: [RollPositiveSides(times: 1), Operator.division, Constant(term: 1)],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d", "÷", "9"],
    withTokens: [RollPositiveSides(times: 1), Operator.division, Constant(term: 9)],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.division]
  ),

  // MARK: - 1d ×

  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d", "×", "0"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d", "×", "1"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d", "×", "9"],
    withTokens: [RollPositiveSides(times: 1), Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.multiplication]
  ),

  // MARK: - "1d -"

  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d", "-", "0"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction, Constant(term: 0)],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d", "-", "1"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction, Constant(term: 1)],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [RollPositiveSides(times: 1), Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d", "-", "9"],
    withTokens: [RollPositiveSides(times: 1), Operator.subtraction, Constant(term: 9)],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [RollPositiveSides(times: 1), Operator.subtraction]
  ),

  // MARK: - 1d

  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d0"],
    withTokens: [Roll(times: 1, sides: 0)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d1"],
    withTokens: [Roll(times: 1, sides: 1)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [RollPositiveSides(times: 1)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d9"],
    withTokens: [Roll(times: 1, sides: 9)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),

  // MARK: - 1d- × (

  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-", "×", "(", "0"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-", "×", "(", "1"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d-", "×", "("],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-", "×", "(", "9"],
    withTokens: [
      RollNegativeSides(times: 1),
      Operator.multiplication,
      Parenthesis.open,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d-", "×", "("],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication, Parenthesis.open]
  ),

  // MARK: - 1d-)

  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-", ")", "×", "0"],
    withTokens: [
      RollNegativeSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 0),
    ],
    droppedLexemes: ["1d-", ")", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-", ")", "×", "1"],
    withTokens: [
      RollNegativeSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 1),
    ],
    droppedLexemes: ["1d-", ")", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-", ")"],
    withoutTokens: [RollNegativeSides(times: 1), Parenthesis.close],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-", ")", "×", "9"],
    withTokens: [
      RollNegativeSides(times: 1),
      Parenthesis.close,
      Operator.multiplication,
      Constant(term: 9),
    ],
    droppedLexemes: ["1d-", ")", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Parenthesis.close, Operator.multiplication]
  ),

  // MARK: - 1d- +

  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-", "+", "0"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition, Constant(term: 0)],
    droppedLexemes: ["1d-", "+"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-", "+", "1"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition, Constant(term: 1)],
    droppedLexemes: ["1d-", "+"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d-", "+"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.addition],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-", "+", "9"],
    withTokens: [RollNegativeSides(times: 1), Operator.addition, Constant(term: 9)],
    droppedLexemes: ["1d-", "+"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.addition]
  ),

  // MARK: - 1d- ÷

  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-", "÷", "0"],
    withTokens: [RollNegativeSides(times: 1), Operator.division, Constant(term: 0)],
    droppedLexemes: ["1d-", "÷"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-", "÷", "1"],
    withTokens: [RollNegativeSides(times: 1), Operator.division, Constant(term: 1)],
    droppedLexemes: ["1d-", "÷"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d-", "÷"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.division],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-", "÷", "9"],
    withTokens: [RollNegativeSides(times: 1), Operator.division, Constant(term: 9)],
    droppedLexemes: ["1d-", "÷"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.division]
  ),

  // MARK: - 1d- ×

  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-", "×", "0"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication, Constant(term: 0)],
    droppedLexemes: ["1d-", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-", "×", "1"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication, Constant(term: 1)],
    droppedLexemes: ["1d-", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d-", "×"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.multiplication],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-", "×", "9"],
    withTokens: [RollNegativeSides(times: 1), Operator.multiplication, Constant(term: 9)],
    droppedLexemes: ["1d-", "×"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.multiplication]
  ),

  // MARK: - "1d- -"

  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-", "-", "0"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction, Constant(term: 0)],
    droppedLexemes: ["1d-", "-"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-", "-", "1"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction, Constant(term: 1)],
    droppedLexemes: ["1d-", "-"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d-", "-"],
    withoutTokens: [RollNegativeSides(times: 1), Operator.subtraction],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-", "-", "9"],
    withTokens: [RollNegativeSides(times: 1), Operator.subtraction, Constant(term: 9)],
    droppedLexemes: ["1d-", "-"],
    droppedTokens: [RollNegativeSides(times: 1), Operator.subtraction]
  ),

  // MARK: - 1d-

  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "0",
    token: Constant(term: 0),
    withLexemes: ["1d-0"],
    withTokens: [Roll(times: 1, sides: -0)],
    droppedLexemes: ["1d"],
    droppedTokens: [RollPositiveSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "1",
    token: Constant(term: 1),
    withLexemes: ["1d-1"],
    withTokens: [Roll(times: 1, sides: -1)],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
  (
    withoutLexemes: ["1d-"],
    withoutTokens: [RollNegativeSides(times: 1)],
    lexeme: "9",
    token: Constant(term: 9),
    withLexemes: ["1d-9"],
    withTokens: [Roll(times: 1, sides: -9)],
    droppedLexemes: ["1d-"],
    droppedTokens: [RollNegativeSides(times: 1)]
  ),
]
