@testable import ChanceKit

typealias IntegerFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  integer: Int,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

let integerFixtures: [IntegerFixture] = [
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "0",
    integer: 0,
    withLexemes: ["0"],
    withTokens: [Operand.number(0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1"],
    withTokens: [Operand.number(1)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "9",
    integer: 9,
    withLexemes: ["9"],
    withTokens: [Operand.number(9)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "0",
    integer: 0,
    withLexemes: ["(", "0"],
    withTokens: [Parenthesis.open, Operand.number(0)],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "1",
    integer: 1,
    withLexemes: ["(", "1"],
    withTokens: [Parenthesis.open, Operand.number(1)],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "9",
    integer: 9,
    withLexemes: ["(", "9"],
    withTokens: [Parenthesis.open, Operand.number(9)],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "0",
    integer: 0,
    withLexemes: [")", "×", "0"],
    withTokens: [Parenthesis.close, Operator.multiplication, Operand.number(0)],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "1",
    integer: 1,
    withLexemes: [")", "×", "1"],
    withTokens: [Parenthesis.close, Operator.multiplication, Operand.number(1)],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "9",
    integer: 9,
    withLexemes: [")", "×", "9"],
    withTokens: [Parenthesis.close, Operator.multiplication, Operand.number(9)],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "0",
    integer: 0,
    withLexemes: ["0"],
    withTokens: [Operand.number(0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1"],
    withTokens: [Operand.number(1)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "9",
    integer: 9,
    withLexemes: ["9"],
    withTokens: [Operand.number(9)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "0",
    integer: 0,
    withLexemes: ["÷", "0"],
    withTokens: [Operator.division, Operand.number(0)],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "1",
    integer: 1,
    withLexemes: ["÷", "1"],
    withTokens: [Operator.division, Operand.number(1)],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "9",
    integer: 9,
    withLexemes: ["÷", "9"],
    withTokens: [Operator.division, Operand.number(9)],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "0",
    integer: 0,
    withLexemes: ["×", "0"],
    withTokens: [Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "1",
    integer: 1,
    withLexemes: ["×", "1"],
    withTokens: [Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "9",
    integer: 9,
    withLexemes: ["×", "9"],
    withTokens: [Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "0",
    integer: 0,
    withLexemes: ["0"],
    withTokens: [Operand.number(0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "1",
    integer: 1,
    withLexemes: ["-1"],
    withTokens: [Operand.number(-1)],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "9",
    integer: 9,
    withLexemes: ["-9"],
    withTokens: [Operand.number(-9)],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["0"],
    withTokens: [Operand.number(0)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1"],
    withTokens: [Operand.number(1)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["9"],
    withTokens: [Operand.number(9)],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["10"],
    withTokens: [Operand.number(10)],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["11"],
    withTokens: [Operand.number(11)],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["19"],
    withTokens: [Operand.number(19)],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["90"],
    withTokens: [Operand.number(90)],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["91"],
    withTokens: [Operand.number(91)],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["99"],
    withTokens: [Operand.number(99)],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1", "×", "(", "0"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operand.number(0)],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1", "×", "(", "1"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operand.number(1)],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1", "×", "(", "9"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operand.number(9)],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1", ")", "×", "0"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1", ")", "×", "1"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1", ")", "×", "9"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1", "+", "0"],
    withTokens: [Operand.number(1), Operator.addition, Operand.number(0)],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.number(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1", "+", "1"],
    withTokens: [Operand.number(1), Operator.addition, Operand.number(1)],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.number(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1", "+", "9"],
    withTokens: [Operand.number(1), Operator.addition, Operand.number(9)],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.number(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1", "÷", "0"],
    withTokens: [Operand.number(1), Operator.division, Operand.number(0)],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.number(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1", "÷", "1"],
    withTokens: [Operand.number(1), Operator.division, Operand.number(1)],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.number(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1", "÷", "9"],
    withTokens: [Operand.number(1), Operator.division, Operand.number(9)],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.number(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1", "×", "0"],
    withTokens: [Operand.number(1), Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.number(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1", "×", "1"],
    withTokens: [Operand.number(1), Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.number(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1", "×", "9"],
    withTokens: [Operand.number(1), Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.number(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1", "-", "0"],
    withTokens: [Operand.number(1), Operator.subtraction, Operand.number(0)],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.number(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1", "-", "1"],
    withTokens: [Operand.number(1), Operator.subtraction, Operand.number(1)],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.number(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1", "-", "9"],
    withTokens: [Operand.number(1), Operator.subtraction, Operand.number(9)],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.number(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["100"],
    withTokens: [Operand.number(100)],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["101"],
    withTokens: [Operand.number(101)],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["109"],
    withTokens: [Operand.number(109)],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["110"],
    withTokens: [Operand.number(110)],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["111"],
    withTokens: [Operand.number(111)],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["119"],
    withTokens: [Operand.number(119)],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["190"],
    withTokens: [Operand.number(190)],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["191"],
    withTokens: [Operand.number(191)],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["199"],
    withTokens: [Operand.number(199)],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d10"],
    withTokens: [Operand.roll(1, 10)],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d11"],
    withTokens: [Operand.roll(1, 11)],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d19"],
    withTokens: [Operand.roll(1, 19)],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d0"],
    withTokens: [Operand.roll(1, 0)],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1"],
    withTokens: [Operand.roll(1, 1)],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d9"],
    withTokens: [Operand.roll(1, 9)],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d1", "×", "(", "0"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Operand.number(0)],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1", "×", "(", "1"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Operand.number(1)],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d1", "×", "(", "9"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Operand.number(9)],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d", "×", "(", "0"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operand.number(0)
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d", "×", "(", "1"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operand.number(1)
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d", "×", "(", "9"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operand.number(9)
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d1", ")", "×", "0"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1", ")", "×", "1"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d1", ")", "×", "9"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d", ")", "×", "0"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d", ")", "×", "1"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d", ")", "×", "9"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d1", "+", "0"],
    withTokens: [Operand.roll(1, 1), Operator.addition, Operand.number(0)],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Operand.roll(1, 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1", "+", "1"],
    withTokens: [Operand.roll(1, 1), Operator.addition, Operand.number(1)],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Operand.roll(1, 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d1", "+", "9"],
    withTokens: [Operand.roll(1, 1), Operator.addition, Operand.number(9)],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Operand.roll(1, 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d", "+", "0"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition, Operand.number(0)],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d", "+", "1"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition, Operand.number(1)],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d", "+", "9"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition, Operand.number(9)],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d1", "÷", "0"],
    withTokens: [Operand.roll(1, 1), Operator.division, Operand.number(0)],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Operand.roll(1, 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1", "÷", "1"],
    withTokens: [Operand.roll(1, 1), Operator.division, Operand.number(1)],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Operand.roll(1, 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d1", "÷", "9"],
    withTokens: [Operand.roll(1, 1), Operator.division, Operand.number(9)],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Operand.roll(1, 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d1", "×", "0"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1", "×", "1"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d1", "×", "9"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d", "×", "0"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Operand.number(0)],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d", "×", "1"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Operand.number(1)],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d", "×", "9"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Operand.number(9)],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d1", "-", "0"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction, Operand.number(0)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Operand.roll(1, 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d1", "-", "1"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction, Operand.number(1)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Operand.roll(1, 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d1", "-", "9"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction, Operand.number(9)],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Operand.roll(1, 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "0",
    integer: 0,
    withLexemes: ["1d", "-", "0"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction, Operand.number(0)],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "1",
    integer: 1,
    withLexemes: ["1d", "-", "1"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction, Operand.number(1)],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "9",
    integer: 9,
    withLexemes: ["1d", "-", "9"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction, Operand.number(9)],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.subtraction]
  ),
]

