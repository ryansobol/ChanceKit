@testable import ChanceKit

typealias LexemeOperatorFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  token: Operator,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

let lexemeOperatorFixtures: [LexemeOperatorFixture] = [
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
    withLexemes: ["-"],
    withTokens: [Operator.subtraction],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.constant(0)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["0", "+"],
    withTokens: [Operand.constant(0), Operator.addition],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.constant(0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.constant(0)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["0", "÷"],
    withTokens: [Operand.constant(0), Operator.division],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.constant(0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.constant(0)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["0", "×"],
    withTokens: [Operand.constant(0), Operator.multiplication],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.constant(0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.constant(0)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["0", "-"],
    withTokens: [Operand.constant(0), Operator.subtraction],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.constant(0)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.constant(1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.constant(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.constant(1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.constant(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.constant(1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.constant(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.constant(1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.constant(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.constant(9)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["9", "+"],
    withTokens: [Operand.constant(9), Operator.addition],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.constant(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.constant(9)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["9", "÷"],
    withTokens: [Operand.constant(9), Operator.division],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.constant(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.constant(9)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["9", "×"],
    withTokens: [Operand.constant(9), Operator.multiplication],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.constant(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.constant(9)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["9", "-"],
    withTokens: [Operand.constant(9), Operator.subtraction],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.constant(9)]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "×", "(", "+"],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open, Operator.addition],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "×", "(", "÷"],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open, Operator.division],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×", "(", "×"],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open, Operator.multiplication],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "×", "(", "-"],
    withTokens: [
      Operand.constant(1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction
    ],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.constant(1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", ")", "+"],
    withTokens: [Operand.constant(1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.constant(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.constant(1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", ")", "÷"],
    withTokens: [Operand.constant(1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.constant(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.constant(1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", ")", "×"],
    withTokens: [Operand.constant(1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.constant(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.constant(1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", ")", "-"],
    withTokens: [Operand.constant(1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.constant(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.constant(1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.constant(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.constant(1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.constant(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.constant(1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.constant(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.constant(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.constant(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.constant(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.constant(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.constant(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.constant(1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.constant(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.constant(1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.constant(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.constant(1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.constant(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.constant(1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.constant(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.constant(1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.constant(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.constant(1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.constant(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.constant(1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.constant(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.constant(1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.constant(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.constant(10)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["10", "+"],
    withTokens: [Operand.constant(10), Operator.addition],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.constant(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.constant(10)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["10", "÷"],
    withTokens: [Operand.constant(10), Operator.division],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.constant(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.constant(10)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["10", "×"],
    withTokens: [Operand.constant(10), Operator.multiplication],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.constant(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.constant(10)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["10", "-"],
    withTokens: [Operand.constant(10), Operator.subtraction],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.constant(10)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.constant(11)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["11", "+"],
    withTokens: [Operand.constant(11), Operator.addition],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.constant(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.constant(11)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["11", "÷"],
    withTokens: [Operand.constant(11), Operator.division],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.constant(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.constant(11)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["11", "×"],
    withTokens: [Operand.constant(11), Operator.multiplication],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.constant(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.constant(11)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["11", "-"],
    withTokens: [Operand.constant(11), Operator.subtraction],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.constant(11)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.constant(19)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["19", "+"],
    withTokens: [Operand.constant(19), Operator.addition],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.constant(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.constant(19)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["19", "÷"],
    withTokens: [Operand.constant(19), Operator.division],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.constant(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.constant(19)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["19", "×"],
    withTokens: [Operand.constant(19), Operator.multiplication],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.constant(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.constant(19)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["19", "-"],
    withTokens: [Operand.constant(19), Operator.subtraction],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.constant(19)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Operand.roll(1, 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Operand.roll(1, 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [Operand.rollPositiveSides(1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "×", "(", "+"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Operator.addition],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "×", "(", "÷"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Operator.division],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×", "(", "×"],
    withTokens: [
      Operand.roll(1, 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "×", "(", "-"],
    withTokens: [
      Operand.roll(1, 1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction
    ],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "×", "(", "+"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.addition
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "×", "(", "÷"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.division
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×", "(", "×"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.multiplication
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "×", "(", "-"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Operator.subtraction
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", ")", "+"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", ")", "÷"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", ")", "×"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", ")", "-"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", ")", "+"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", ")", "÷"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", ")", "×"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", ")", "-"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Operand.roll(1, 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Operand.roll(1, 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [Operand.rollPositiveSides(1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Operand.roll(1, 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Operand.roll(1, 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [Operand.rollPositiveSides(1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Operand.roll(1, 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Operand.roll(1, 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [Operand.rollPositiveSides(1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d1", "+"],
    withTokens: [Operand.roll(1, 1), Operator.addition],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d1", "÷"],
    withTokens: [Operand.roll(1, 1), Operator.division],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d1", "×"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d1", "-"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1d", "+"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1d", "÷"],
    withTokens: [Operand.rollPositiveSides(1), Operator.division],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1d", "×"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1d", "-"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  // TODO: Operand.rollNegativeSides
]
