@testable import Calculator

// MARK: - EvaluatableFixture

typealias EvaluatableFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable],
  value: Int
)

//  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
let evaluatableFixtures: [EvaluatableFixture] = [
  // MARK: A
  (
    description: "",
    lexemes: [],
    infixTokens: [],
    postfixTokens: [],
    value: 0
  ),
  (
    description: "42",
    lexemes: ["42"],
    infixTokens: [Operand(rawLexeme: "42")!],
    postfixTokens: [Operand(rawLexeme: "42")!],
    value: 42
  ),
  (
    description: String(Int.max),
    lexemes: [String(Int.max)],
    infixTokens: [Operand(rawLexeme: String(Int.max))!],
    postfixTokens: [Operand(rawLexeme: String(Int.max))!],
    value: Int.max
  ),
  (
    description: String(Int.min),
    lexemes: [String(Int.min)],
    infixTokens: [Operand(rawLexeme: String(Int.min))!],
    postfixTokens: [Operand(rawLexeme: String(Int.min))!],
    value: Int.min
  ),

  // MARK: A + B
  (
    description: "1 + 2",
    lexemes: ["1", "+", "2"],
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!, Operand(rawLexeme: "2")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "2")!, Operator(rawValue: "+")!],
    value: 3
  ),
  (
    description: "4 - 3",
    lexemes: ["4", "-", "3"],
    infixTokens: [Operand(rawLexeme: "4")!, Operator(rawValue: "-")!, Operand(rawLexeme: "3")!],
    postfixTokens: [Operand(rawLexeme: "4")!, Operand(rawLexeme: "3")!, Operator(rawValue: "-")!],
    value: 1
  ),
  (
    description: "5 × 6",
    lexemes: ["5", "×", "6"],
    infixTokens: [Operand(rawLexeme: "5")!, Operator(rawValue: "×")!, Operand(rawLexeme: "6")!],
    postfixTokens: [Operand(rawLexeme: "5")!, Operand(rawLexeme: "6")!, Operator(rawValue: "×")!],
    value: 30
  ),
  (
    description: "8 ÷ 7",
    lexemes: ["8", "÷", "7"],
    infixTokens: [Operand(rawLexeme: "8")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "7")!],
    postfixTokens: [Operand(rawLexeme: "8")!, Operand(rawLexeme: "7")!, Operator(rawValue: "÷")!],
    value: 1
  ),
  (
    description: "9 × 0",
    lexemes: ["9", "×", "0"],
    infixTokens: [Operand(rawLexeme: "9")!, Operator(rawValue: "×")!, Operand(rawLexeme: "0")!],
    postfixTokens: [Operand(rawLexeme: "9")!, Operand(rawLexeme: "0")!, Operator(rawValue: "×")!],
    value: 0
  ),
  (
    description: "2 ÷ 1",
    lexemes: ["2", "÷", "1"],
    infixTokens: [Operand(rawLexeme: "2")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "1")!],
    postfixTokens: [Operand(rawLexeme: "2")!, Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!],
    value: 2
  ),

  // MARK: A + B + C
  (
    description: "3 - 1 + 2",
    lexemes: ["3", "-", "1", "+", "2"],
    infixTokens: [
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "2")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "+")!,
    ],
    value: 4
  ),
  (
    description: "5 ÷ 7 × 6",
    lexemes: ["5", "÷", "7", "×", "6"],
    infixTokens: [
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "6")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "×")!,
    ],
    value: 0
  ),
  (
    description: "8 + 0 ÷ 9",
    lexemes: ["8", "+", "0", "÷", "9"],
    infixTokens: [
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "9")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "8")!,
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "+")!,
    ],
    value: 8
  ),
  (
    description: "2 × 4 - 1",
    lexemes: ["2", "×", "4", "-", "1"],
    infixTokens: [
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "-")!,
    ],
    value: 7
  ),

  // MARK: A + B + C + D
  (
    description: "7 - 5 - 3 + 8",
    lexemes: ["7", "-", "5", "-", "3", "+", "8"],
    infixTokens: [
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
    ],
    value: 7
  ),
  (
    description: "6 ÷ 1 × 2 × 0",
    lexemes: ["6", "÷", "1", "×", "2", "×", "0"],
    infixTokens: [
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "0")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "×")!,
    ],
    value: 0
  ),
  (
    description: "3 + 4 ÷ 2 - 7",
    lexemes: ["3", "+", "4", "÷", "2", "-", "7"],
    infixTokens: [
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "7")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "-")!,
    ],
    value: -2
  ),
  (
    description: "8 - 9 × 5 ÷ 1",
    lexemes: ["8", "-", "9", "×", "5", "÷", "1"],
    infixTokens: [
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "8")!,
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "-")!,
    ],
    value: -37
  ),
  (
    description: "4 × 1 ÷ 6 + 0",
    lexemes: ["4", "×", "1", "÷", "6", "+", "0"],
    infixTokens: [
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "0")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "+")!,
    ],
    value: 0
  ),
  (
    description: "0 ÷ 5 + 4 × 7",
    lexemes: ["0", "÷", "5", "+", "4", "×", "7"],
    infixTokens: [
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "+")!,
    ],
    value: 28
  ),

  // MARK: (A)
  (
    description: "()",
    lexemes: ["(", ")"],
    infixTokens: [Parenthesis.open, Parenthesis.close],
    postfixTokens: [],
    value: 0
  ),
  (
    description: "(42)",
    lexemes: ["(", "42", ")"],
    infixTokens: [Parenthesis.open, Operand(rawLexeme: "42")!, Parenthesis.close],
    postfixTokens: [Operand(rawLexeme: "42")!],
    value: 42
  ),
  (
    description: "(\(Int.max))",
    lexemes: ["(", String(Int.max), ")"],
    infixTokens: [Parenthesis.open, Operand(rawLexeme: String(Int.max))!, Parenthesis.close],
    postfixTokens: [Operand(rawLexeme: String(Int.max))!],
    value: Int.max
  ),
  (
    description: "(\(Int.min))",
    lexemes: ["(", String(Int.min), ")"],
    infixTokens: [Parenthesis.open, Operand(rawLexeme: String(Int.min))!, Parenthesis.close],
    postfixTokens: [Operand(rawLexeme: String(Int.min))!],
    value: Int.min
  ),

  // MARK: (A + B)
  (
    description: "(2 + 3)",
    lexemes: ["(", "2", "+", "3", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "+")!,
    ],
    value: 5
  ),
  (
    description: "(5 - 4)",
    lexemes: ["(", "5", "-", "4", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
    ],
    value: 1
  ),
  (
    description: "(6 × 7)",
    lexemes: ["(", "6", "×", "7", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
    ],
    value: 42
  ),
  (
    description: "(9 ÷ 8)",
    lexemes: ["(", "9", "÷", "8", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "÷")!,
    ],
    value: 1
  ),
  (
    description: "(0 × 1)",
    lexemes: ["(", "0", "×", "1", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
    ],
    value: 0
  ),
  (
    description: "(3 ÷ 2)",
    lexemes: ["(", "3", "÷", "2", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "2")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "÷")!,
    ],
    value: 1
  ),

  // MARK: ((A + B))
  (
    description: "((2 + 3))",
    lexemes: ["(", "(", "2", "+", "3", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "+")!,
    ],
    value: 5
  ),
  (
    description: "((5 - 4))",
    lexemes: ["(", "(", "5", "-", "4", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
    ],
    value: 1
  ),
  (
    description: "((6 × 7))",
    lexemes: ["(", "(", "6", "×", "7", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
    ],
    value: 42
  ),
  (
    description: "((9 ÷ 8))",
    lexemes: ["(", "(", "9", "÷", "8", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "÷")!,
    ],
    value: 1
  ),
  (
    description: "((0 × 1))",
    lexemes: ["(", "(", "0", "×", "1", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
    ],
    value: 0
  ),
  (
    description: "((3 ÷ 2))",
    lexemes: ["(", "(", "3", "÷", "2", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "2")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "÷")!,
    ],
    value: 1
  ),

  // MARK: (A + B) + C
  (
    description: "(5 - 4) + 6",
    lexemes: ["(", "5", "-", "4", ")", "+", "6"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "6")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "+")!,
    ],
    value: 7
  ),
  (
    description: "7 - (9 + 8)",
    lexemes: ["7", "-", "(", "9", "+", "8", ")"],
    infixTokens: [
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "-")!,
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "-")!,
    ],
    value: -10
  ),
  (
    description: "(3 ÷ 1) - 0",
    lexemes: ["(", "3", "÷", "1", ")", "-", "0"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "0")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "-")!,
    ],
    value: 3
  ),
  (
    description: "4 ÷ (2 - 5)",
    lexemes: ["4", "÷", "(", "2", "-", "5", ")"],
    infixTokens: [
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operator(rawValue: "÷")!,
    ],
    value: -1
  ),
  (
    description: "(2 + 8) × 7",
    lexemes: ["(", "2", "+", "8", ")", "×", "7"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
    ],
    value: 70
  ),
  (
    description: "9 + (0 × 1)",
    lexemes: ["9", "+", "(", "0", "×", "1", ")"],
    infixTokens: [
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "+")!,
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "+")!,
    ],
    value: 9
  ),
  (
    description: "(1 × 3) ÷ 4",
    lexemes: ["(", "1", "×", "3", ")", "÷", "4"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "4")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "1")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
    ],
    value: 0
  ),
  (
    description: "6 × (7 ÷ 5)",
    lexemes: ["6", "×", "(", "7", "÷", "5", ")"],
    infixTokens: [
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "×")!,
    ],
    value: 6
  ),

  // MARK: ((A + B) + C)
  (
    description: "((5 - 4) + 6)",
    lexemes: ["(", "(", "5", "-", "4", ")", "+", "6", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "6")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "+")!,
    ],
    value: 7
  ),
  (
    description: "(7 - (9 + 8))",
    lexemes: ["(", "7", "-", "(", "9", "+", "8", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "-")!,
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "-")!,
    ],
    value: -10
  ),
  (
    description: "((3 ÷ 1) - 0)",
    lexemes: ["(", "(", "3", "÷", "1", ")", "-", "0", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "0")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "-")!,
    ],
    value: 3
  ),
  (
    description: "(4 ÷ (2 - 5))",
    lexemes: ["(", "4", "÷", "(", "2", "-", "5", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operator(rawValue: "÷")!,
    ],
    value: -1
  ),
  (
    description: "((2 + 8) × 7)",
    lexemes: ["(", "(", "2", "+", "8", ")", "×", "7", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
    ],
    value: 70
  ),
  (
    description: "(9 + (0 × 1))",
    lexemes: ["(", "9", "+", "(", "0", "×", "1", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "+")!,
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "+")!,
    ],
    value: 9
  ),
  (
    description: "((1 × 3) ÷ 4)",
    lexemes: ["(", "(", "1", "×", "3", ")", "÷", "4", ")"],
    infixTokens: [
      Parenthesis.open,
      Parenthesis.open,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "1")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
    ],
    value: 0
  ),
  (
    description: "(6 × (7 ÷ 5))",
    lexemes: ["(", "6", "×", "(", "7", "÷", "5", ")", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "×")!,
    ],
    value: 6
  ),

  // MARK: (A + B) + (C + D)
  (
    description: "(4 + 1) - (8 + 5)",
    lexemes: ["(", "4", "+", "1", ")", "-", "(", "8", "+", "5", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Parenthesis.open,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "-")!,
    ],
    value: -8
  ),
  (
    description: "(2 × 4) ÷ (9 × 7)",
    lexemes: ["(", "2", "×", "4", ")", "÷", "(", "9", "×", "7", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
      Operator(rawValue: "÷")!,
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "÷")!,
    ],
    value: 0
  ),
  (
    description: "(6 ÷ 1) + (8 ÷ 4)",
    lexemes: ["(", "6", "÷", "1", ")", "+", "(", "8", "÷", "4", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Operator(rawValue: "+")!,
      Parenthesis.open,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "8")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "+")!,
    ],
    value: 8
  ),
  (
    description: "(3 - 2) × (7 - 5)",
    lexemes: ["(", "3", "-", "2", ")", "×", "(", "7", "-", "5", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "2")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "-")!,
      Operator(rawValue: "×")!,
    ],
    value: 2
  ),
  (
    description: "(4 + 8) - (1 × 2)",
    lexemes: ["(", "4", "+", "8", ")", "-", "(", "1", "×", "2", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Parenthesis.open,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "2")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "-")!,
    ],
    value: 10
  ),
  (
    description: "(5 ÷ 7) + (6 - 9)",
    lexemes: ["(", "5", "÷", "7", ")", "+", "(", "6", "-", "9", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "7")!,
      Parenthesis.close,
      Operator(rawValue: "+")!,
      Parenthesis.open,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "9")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "-")!,
      Operator(rawValue: "+")!,
    ],
    value: -3
  ),
  (
    description: "(0 × 9) ÷ (3 + 1)",
    lexemes: ["(", "0", "×", "9", ")", "÷", "(", "3", "+", "1", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "9")!,
      Parenthesis.close,
      Operator(rawValue: "÷")!,
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "÷")!,
    ],
    value: 0
  ),
  (
    description: "(2 - 3) × (4 ÷ 5)",
    lexemes: ["(", "2", "-", "3", ")", "×", "(", "4", "÷", "5", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "×")!,
    ],
    value: 0
  ),

  // MARK: (A + (B + C) + D)
  (
    description: "(1 + (9 - 4) - 2)",
    lexemes: ["(", "1", "+", "(", "9", "-", "4", ")", "-", "2", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "2")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "1")!,
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "-")!,
    ],
    value: 4
  ),
  (
    description: "(5 × (0 ÷ 3) × 7)",
    lexemes: ["(", "5", "×", "(", "0", "÷", "3", ")", "×", "7", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
    ],
    value: 0
  ),
  (
    description: "(8 - (4 × 6) + 1)",
    lexemes: ["(", "8", "-", "(", "4", "×", "6", ")", "+", "1", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "-")!,
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "6")!,
      Parenthesis.close,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "8")!,
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
    ],
    value: -15
  ),
  (
    description: "(3 ÷ (9 + 2) ÷ 6)",
    lexemes: ["(", "3", "÷", "(", "9", "+", "2", ")", "÷", "6", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "2")!,
      Parenthesis.close,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "6")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "÷")!,
    ],
    value: 0
  ),
  (
    description: "(0 + (3 - 6) × 4)",
    lexemes: ["(", "0", "+", "(", "3", "-", "6", ")", "×", "4", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "0")!,
      Operator(rawValue: "+")!,
      Parenthesis.open,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "6")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "4")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "0")!,
      Operand(rawLexeme: "3")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "+")!,
    ],
    value: -12
  ),
  (
    description: "(2 × (5 + 8) - 1)",
    lexemes: ["(", "2", "×", "(", "5", "+", "8", ")", "-", "1", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "8")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "5")!,
      Operand(rawLexeme: "8")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "-")!,
    ],
    value: 25
  ),
  (
    description: "(9 ÷ (7 × 1) + 5)",
    lexemes: ["(", "9", "÷", "(", "7", "×", "1", ")", "+", "5", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "9")!,
      Operator(rawValue: "÷")!,
      Parenthesis.open,
      Operand(rawLexeme: "7")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "1")!,
      Parenthesis.close,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9")!,
      Operand(rawLexeme: "7")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "+")!,
    ],
    value: 6
  ),
  (
    description: "(4 - (6 ÷ 5) × 3)",
    lexemes: ["(", "4", "-", "(", "6", "÷", "5", ")", "×", "3", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "-")!,
      Parenthesis.open,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "3")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "6")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "-")!,
    ],
    value: 1
  ),

  // MARK: (A + B ÷ C × (D + E) - F)
  (
    description: "(1 + 2 ÷ 3 × (4 + 5) - 6)",
    lexemes: ["(", "1", "+", "2", "÷", "3", "×", "(", "4", "+", "5", ")", "-", "6", ")"],
    infixTokens: [
      Parenthesis.open,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "2")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "×")!,
      Parenthesis.open,
      Operand(rawLexeme: "4")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "5")!,
      Parenthesis.close,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "6")!,
      Parenthesis.close,
    ],
    postfixTokens: [
      Operand(rawLexeme: "1")!,
      Operand(rawLexeme: "2")!,
      Operand(rawLexeme: "3")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "4")!,
      Operand(rawLexeme: "5")!,
      Operator(rawValue: "+")!,
      Operator(rawValue: "×")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "6")!,
      Operator(rawValue: "-")!,
    ],
    value: -5
  ),
]

// MARK: - ParsableFixture

typealias ParsableFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable],
  error: ExpressionError
)

let parsableFixtures: [ParsableFixture] = [
  (
    description: "+",
    lexemes: ["+"],
    infixTokens: [Operator(rawValue: "+")!],
    postfixTokens: [Operator(rawValue: "+")!],
    error: .missingOperand
  ),
  (
    description: "÷",
    lexemes: ["÷"],
    infixTokens: [Operator(rawValue: "÷")!],
    postfixTokens: [Operator(rawValue: "÷")!],
    error: .missingOperand
  ),
  (
    description: "×",
    lexemes: ["×"],
    infixTokens: [Operator(rawValue: "×")!],
    postfixTokens: [Operator(rawValue: "×")!],
    error: .missingOperand
  ),
  (
    description: "-",
    lexemes: ["-"],
    infixTokens: [Operator(rawValue: "-")!],
    postfixTokens: [Operator(rawValue: "-")!],
    error: .missingOperand
  ),
  (
    description: "1 +",
    lexemes: ["1", "+"],
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!],
    error: .missingOperand
  ),
  (
    description: "11", // TODO: Fix logic to insert a space separator
    lexemes: ["1", "1"],
    infixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!],
    error: .missingOperator
  ),
  (
    description: "1 ÷ 0",
    lexemes: ["1", "÷", "0"],
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "0")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "0")!, Operator(rawValue: "÷")!],
    error: .divisionByZero
  ),
  (
    description: "9223372036854775807 + 1",
    lexemes: ["9223372036854775807", "+", "1"],
    infixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
    ],
    error: .operationOverflow
  ),
  (
    description: "-9223372036854775808 ÷ -1",
    lexemes: ["-9223372036854775808", "÷", "-1"],
    infixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "÷")!,
    ],
    error: .operationOverflow
  ),
  (
    description: "-9223372036854775808 × -1",
    lexemes: ["-9223372036854775808", "×", "-1"],
    infixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "×")!,
    ],
    error: .operationOverflow
  ),
  (
    description: "9223372036854775807 - -1",
    lexemes: ["9223372036854775807", "-", "-1"],
    infixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "-")!,
    ],
    error: .operationOverflow
  ),
]

// MARK: - LexebleFixture

typealias LexebleFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  error: ExpressionError
)

let lexebleFixtures: [LexebleFixture] = [
  (
    description: "(",
    lexemes: ["("],
    infixTokens: [Parenthesis.open],
    error: .missingParenthesisClose
  ),
  (
    description: ")",
    lexemes: [")"],
    infixTokens: [Parenthesis.close],
    error: .missingParenthesisOpen
  ),
]

// MARK: - InvalidFixture

typealias InvalidFixture = (
  lexeme: String,
  error: ExpressionError
)

let invalidFixtures: [InvalidFixture] = [
  (lexeme: "d", error: .invalidLexeme("d")),
  (lexeme: "=", error: .invalidLexeme("=")),
  (lexeme: "[", error: .invalidLexeme("[")),
  (lexeme: "{", error: .invalidLexeme("{")),
  (lexeme: "<", error: .invalidLexeme("<")),
  (lexeme: ".", error: .invalidLexeme(".")),
  (lexeme: ",", error: .invalidLexeme(",")),
  (lexeme: ",", error: .invalidLexeme(",")),
  (lexeme: "**", error: .invalidLexeme("**")),
  (lexeme: "&", error: .invalidLexeme("&")),
  (lexeme: "|", error: .invalidLexeme("|")),
  (lexeme: "!", error: .invalidLexeme("!")),
  (lexeme: "~", error: .invalidLexeme("~")),
  (lexeme: "..<", error: .invalidLexeme("..<")),
  (lexeme: "...", error: .invalidLexeme("...")),
  (lexeme: "<<", error: .invalidLexeme("<<")),
  (lexeme: ">>", error: .invalidLexeme(">>")),
  (lexeme: "%", error: .invalidLexeme("%")),
]

// MARK: - LexebleParenthesisFixture

typealias LexebleParenthesisFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  token: Parenthesis,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

//  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
let lexebleParenthesisFixtures: [LexebleParenthesisFixture] = [
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
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["0", "×", "("],
    withTokens: [Operand.number(0), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["0", "×"],
    droppedTokens: [Operand.number(0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["0", ")"],
    withTokens: [Operand.number(0), Parenthesis.close],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.number(0)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "("],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.number(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", ")"],
    withTokens: [Operand.number(1), Parenthesis.close],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["9", "×", "("],
    withTokens: [Operand.number(9), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["9", "×"],
    droppedTokens: [Operand.number(9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["9", ")"],
    withTokens: [Operand.number(9), Parenthesis.close],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "(", "("],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Parenthesis.open],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "×", "(", ")"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Parenthesis.close],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", ")", "×", "("],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", ")", ")"],
    withTokens: [Operand.number(1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.number(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "+", "("],
    withTokens: [Operand.number(1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.number(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "+", ")"],
    withTokens: [Operand.number(1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.number(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "÷", "("],
    withTokens: [Operand.number(1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.number(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "÷", ")"],
    withTokens: [Operand.number(1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.number(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "("],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.number(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "×", ")"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.number(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "-", "("],
    withTokens: [Operand.number(1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.number(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "-", ")"],
    withTokens: [Operand.number(1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.number(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["10", "×", "("],
    withTokens: [Operand.number(10), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["10", "×"],
    droppedTokens: [Operand.number(10), Operator.multiplication]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["10", ")"],
    withTokens: [Operand.number(10), Parenthesis.close],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["11", "×", "("],
    withTokens: [Operand.number(11), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["11", "×"],
    droppedTokens: [Operand.number(11), Operator.multiplication]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["11", ")"],
    withTokens: [Operand.number(11), Parenthesis.close],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["19", "×", "("],
    withTokens: [Operand.number(19), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["19", "×"],
    droppedTokens: [Operand.number(19), Operator.multiplication]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["19", ")"],
    withTokens: [Operand.number(19), Parenthesis.close],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
]

// MARK: - LexebleOperatorFixture

typealias LexebleOperatorFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  token: Operator,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

//  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
let lexebleOperatorFixtures: [LexebleOperatorFixture] = [
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
    withoutTokens: [Operand.number(0)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["0", "+"],
    withTokens: [Operand.number(0), Operator.addition],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.number(0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["0", "÷"],
    withTokens: [Operand.number(0), Operator.division],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.number(0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["0", "×"],
    withTokens: [Operand.number(0), Operator.multiplication],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.number(0)]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.number(0)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["0", "-"],
    withTokens: [Operand.number(0), Operator.subtraction],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.number(0)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.number(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.number(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.number(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.number(1)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.number(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["9", "+"],
    withTokens: [Operand.number(9), Operator.addition],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["9", "÷"],
    withTokens: [Operand.number(9), Operator.division],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["9", "×"],
    withTokens: [Operand.number(9), Operator.multiplication],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.number(9)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["9", "-"],
    withTokens: [Operand.number(9), Operator.subtraction],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.number(9)]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "×", "(", "+"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operator.addition],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "×", "(", "÷"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operator.division],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×", "(", "×"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operator.multiplication],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "×", "(", "-"],
    withTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open, Operator.subtraction],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.number(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", ")", "+"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.addition],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.number(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", ")", "÷"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.division],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.number(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", ")", "×"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.multiplication],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.number(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.number(1), Parenthesis.close],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", ")", "-"],
    withTokens: [Operand.number(1), Parenthesis.close, Operator.subtraction],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.number(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.number(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.number(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.number(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.addition],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.number(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.number(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.number(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.number(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.number(1), Operator.division],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.number(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.number(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.number(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.number(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.number(1), Operator.multiplication],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.number(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["1", "+"],
    withTokens: [Operand.number(1), Operator.addition],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["1", "÷"],
    withTokens: [Operand.number(1), Operator.division],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["1", "×"],
    withTokens: [Operand.number(1), Operator.multiplication],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.number(1), Operator.subtraction],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["1", "-"],
    withTokens: [Operand.number(1), Operator.subtraction],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.number(1)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["10", "+"],
    withTokens: [Operand.number(10), Operator.addition],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["10", "÷"],
    withTokens: [Operand.number(10), Operator.division],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["10", "×"],
    withTokens: [Operand.number(10), Operator.multiplication],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.number(10)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["10", "-"],
    withTokens: [Operand.number(10), Operator.subtraction],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.number(10)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["11", "+"],
    withTokens: [Operand.number(11), Operator.addition],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["11", "÷"],
    withTokens: [Operand.number(11), Operator.division],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["11", "×"],
    withTokens: [Operand.number(11), Operator.multiplication],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.number(11)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["11", "-"],
    withTokens: [Operand.number(11), Operator.subtraction],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.number(11)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "+",
    token: Operator.addition,
    withLexemes: ["19", "+"],
    withTokens: [Operand.number(19), Operator.addition],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "÷",
    token: Operator.division,
    withLexemes: ["19", "÷"],
    withTokens: [Operand.number(19), Operator.division],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "×",
    token: Operator.multiplication,
    withLexemes: ["19", "×"],
    withTokens: [Operand.number(19), Operator.multiplication],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.number(19)],
    lexeme: "-",
    token: Operator.subtraction,
    withLexemes: ["19", "-"],
    withTokens: [Operand.number(19), Operator.subtraction],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.number(19)]
  ),
]

// MARK: - LexebleIntegerFixture

typealias LexebleIntegerFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  integer: Int,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

//  TODO: Handle 1d4, 1d6, 1d8, 1d10, 1d12, 1d20, 1d100, and 1d
let lexebleIntegerFixtures: [LexebleIntegerFixture] = [
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
]
