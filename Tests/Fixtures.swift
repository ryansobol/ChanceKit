@testable import Calculator

// MARK: - EvaluatableFixture

typealias EvaluatableFixture = (
  infixTokens: [Tokenable],
  postfixTokens: [Tokenable]
)

let evaluatableFixtures: [EvaluatableFixture] = [
  // MARK: A
  (
    infixTokens: [],
    postfixTokens: []
  ),
  (
    infixTokens: [Operand(rawLexeme: "42")!],
    postfixTokens: [Operand(rawLexeme: "42")!]
  ),

  // MARK: A + B
  (
    infixTokens: [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!, Operand(rawLexeme: "2")!],
    postfixTokens: [Operand(rawLexeme: "1")!, Operand(rawLexeme: "2")!, Operator(rawValue: "+")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "4")!, Operator(rawValue: "-")!, Operand(rawLexeme: "3")!],
    postfixTokens: [Operand(rawLexeme: "4")!, Operand(rawLexeme: "3")!, Operator(rawValue: "-")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "5")!, Operator(rawValue: "×")!, Operand(rawLexeme: "6")!],
    postfixTokens: [Operand(rawLexeme: "5")!, Operand(rawLexeme: "6")!, Operator(rawValue: "×")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "8")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "7")!],
    postfixTokens: [Operand(rawLexeme: "8")!, Operand(rawLexeme: "7")!, Operator(rawValue: "÷")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "9")!, Operator(rawValue: "×")!, Operand(rawLexeme: "0")!],
    postfixTokens: [Operand(rawLexeme: "9")!, Operand(rawLexeme: "0")!, Operator(rawValue: "×")!]
  ),
  (
    infixTokens: [Operand(rawLexeme: "2")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "1")!],
    postfixTokens: [Operand(rawLexeme: "2")!, Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!]
  ),

  // MARK: A + B + C
  (
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
    infixTokens: [Parenthesis.open, Parenthesis.close],
    postfixTokens: []
  ),
  (
    infixTokens: [Parenthesis.open, Operand(rawLexeme: "42")!, Parenthesis.close],
    postfixTokens: [Operand(rawLexeme: "42")!]
  ),

  // MARK: (A + B)
  (
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
