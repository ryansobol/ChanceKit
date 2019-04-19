@testable import Calculator

// MARK: - EvaluatableFixture

typealias EvaluatableFixture = (
  description: String,
  lexemes: [String],
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable]
)

let evaluatableFixtures: [EvaluatableFixture] = [
  // MARK: A
  (
    description: "",
    lexemes: [],
    infixTokens: [],
    postfixTokens: []
  ),
  (
    description: "42",
    lexemes: ["42"],
    infixTokens: [Operand(rawLexeme: "42")!],
    postfixTokens: [Operand(rawLexeme: "42")!]
  ),

  // MARK: A + B
  (
    description: "1 + 2",
    lexemes: ["1", "+", "2"],
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!, Operand(rawLexeme: "2")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "2")!, Operator(rawValue: "+")!]
  ),
  (
    description: "4 - 3",
    lexemes: ["4", "-", "3"],
    infixTokens: [Operand(rawLexeme: "4")!, Operator(rawValue: "-")!, Operand(rawLexeme: "3")!],
    postfixTokens: [Operand(rawLexeme: "4")!, Operand(rawLexeme: "3")!, Operator(rawValue: "-")!]
  ),
  (
    description: "5 × 6",
    lexemes: ["5", "×", "6"],
    infixTokens: [Operand(rawLexeme: "5")!, Operator(rawValue: "×")!, Operand(rawLexeme: "6")!],
    postfixTokens: [Operand(rawLexeme: "5")!, Operand(rawLexeme: "6")!, Operator(rawValue: "×")!]
  ),
  (
    description: "8 ÷ 7",
    lexemes: ["8", "÷", "7"],
    infixTokens: [Operand(rawLexeme: "8")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "7")!],
    postfixTokens: [Operand(rawLexeme: "8")!, Operand(rawLexeme: "7")!, Operator(rawValue: "÷")!]
  ),
  (
    description: "9 × 0",
    lexemes: ["9", "×", "0"],
    infixTokens: [Operand(rawLexeme: "9")!, Operator(rawValue: "×")!, Operand(rawLexeme: "0")!],
    postfixTokens: [Operand(rawLexeme: "9")!, Operand(rawLexeme: "0")!, Operator(rawValue: "×")!]
  ),
  (
    description: "2 ÷ 1",
    lexemes: ["2", "÷", "1"],
    infixTokens: [Operand(rawLexeme: "2")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "1")!],
    postfixTokens: [Operand(rawLexeme: "2")!, Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
  ),

  // MARK: (A)
  (
    description: "()",
    lexemes: ["(", ")"],
    infixTokens: [Parenthesis.open, Parenthesis.close],
    postfixTokens: []
  ),
  (
    description: "(42)",
    lexemes: ["(", "42", ")"],
    infixTokens: [Parenthesis.open, Operand(rawLexeme: "42")!, Parenthesis.close],
    postfixTokens: [Operand(rawLexeme: "42")!]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
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
    ]
  ),
]

// MARK: - ParsableFixture

typealias ParsableFixture = (
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable]
)

let parsableFixtures: [ParsableFixture] = [
  (
    infixTokens: [Operator(rawValue: "+")!],
    postfixTokens: [Operator(rawValue: "+")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "0")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "0")!, Operator(rawValue: "÷")!]
  ),
  (
    infixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operator(rawValue: "+")!,
      Operand(rawLexeme: "1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operand(rawLexeme: "1")!,
      Operator(rawValue: "+")!,
    ]
  ),
  (
    infixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operator(rawValue: "÷")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "÷")!,
    ]
  ),
  (
    infixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operator(rawValue: "×")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "-9223372036854775808")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "×")!,
    ]
  ),
  (
    infixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operator(rawValue: "-")!,
      Operand(rawLexeme: "-1")!,
    ],
    postfixTokens: [
      Operand(rawLexeme: "9223372036854775807")!,
      Operand(rawLexeme: "-1")!,
      Operator(rawValue: "-")!,
    ]
  ),
]
