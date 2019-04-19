@testable import Calculator
import XCTest

class ParserTest: XCTestCase {
  func testParse() {
    typealias Fixture = (
      tokens: [Tokenable],
      expectedTokens: [Tokenable]
    )

    let fixtures: [Fixture] = [
      // MARK: A
      ([], []),
      ([Operand(rawLexeme: "42")!], [Operand(rawLexeme: "42")!]),

      // MARK: A + B
      (
        [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!, Operand(rawLexeme: "2")!],
        [Operand(rawLexeme: "1")!, Operand(rawLexeme: "2")!, Operator(rawValue: "+")!]
      ),
      (
        [Operand(rawLexeme: "4")!, Operator(rawValue: "-")!, Operand(rawLexeme: "3")!],
        [Operand(rawLexeme: "4")!, Operand(rawLexeme: "3")!, Operator(rawValue: "-")!]
      ),
      (
        [Operand(rawLexeme: "5")!, Operator(rawValue: "×")!, Operand(rawLexeme: "6")!],
        [Operand(rawLexeme: "5")!, Operand(rawLexeme: "6")!, Operator(rawValue: "×")!]
      ),
      (
        [Operand(rawLexeme: "8")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "7")!],
        [Operand(rawLexeme: "8")!, Operand(rawLexeme: "7")!, Operator(rawValue: "÷")!]
      ),
      (
        [Operand(rawLexeme: "9")!, Operator(rawValue: "×")!, Operand(rawLexeme: "0")!],
        [Operand(rawLexeme: "9")!, Operand(rawLexeme: "0")!, Operator(rawValue: "×")!]
      ),
      (
        [Operand(rawLexeme: "2")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "1")!],
        [Operand(rawLexeme: "2")!, Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!]
      ),

      // MARK: A + B + C
      (
        [
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "2")!,
        ], [
          Operand(rawLexeme: "3")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "6")!,
        ], [
          Operand(rawLexeme: "5")!,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "9")!,
        ], [
          Operand(rawLexeme: "8")!,
          Operand(rawLexeme: "0")!,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "÷")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "1")!,
        ], [
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "-")!,
        ]
      ),

      // MARK: A + B + C + D
      (
        [
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "8")!,
        ], [
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
        [
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "0")!,
        ], [
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
        [
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "7")!,
        ], [
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
        [
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "1")!,
        ], [
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
        [
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "0")!,
        ], [
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
        [
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "7")!,
        ], [
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
      ([Parenthesis.open, Parenthesis.close], []),
      (
        [Parenthesis.open, Operand(rawLexeme: "42")!, Parenthesis.close],
        [Operand(rawLexeme: "42")!]
      ),

      // MARK: (A + B)
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "3")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "4")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "5")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "-")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "7")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "6")!,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "8")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "9")!,
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "1")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "0")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "2")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "3")!,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "÷")!,
        ]
      ),

      // MARK: ((A + B))
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "3")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "4")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "5")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "-")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "7")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "6")!,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "8")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "9")!,
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "1")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "0")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "2")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "3")!,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "÷")!,
        ]
      ),

      // MARK: (A + B) + C
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "4")!,
          Parenthesis.close,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "6")!,
        ], [
          Operand(rawLexeme: "5")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "-")!,
          Parenthesis.open,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "8")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "7")!,
          Operand(rawLexeme: "9")!,
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "+")!,
          Operator(rawValue: "-")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "1")!,
          Parenthesis.close,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "0")!,
        ], [
          Operand(rawLexeme: "3")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "-")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "÷")!,
          Parenthesis.open,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "5")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "4")!,
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "8")!,
          Parenthesis.close,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "7")!,
        ], [
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "+")!,
          Parenthesis.open,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "1")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "9")!,
          Operand(rawLexeme: "0")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "3")!,
          Parenthesis.close,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "4")!,
        ], [
          Operand(rawLexeme: "1")!,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "×")!,
          Parenthesis.open,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "5")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "6")!,
          Operand(rawLexeme: "7")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "÷")!,
          Operator(rawValue: "×")!,
        ]
      ),

      // MARK: ((A + B) + C)
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "4")!,
          Parenthesis.close,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "6")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "5")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "-")!,
          Parenthesis.open,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "8")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "7")!,
          Operand(rawLexeme: "9")!,
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "+")!,
          Operator(rawValue: "-")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "1")!,
          Parenthesis.close,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "0")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "3")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "-")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "÷")!,
          Parenthesis.open,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "5")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "4")!,
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "-")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "2")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "8")!,
          Parenthesis.close,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "7")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "2")!,
          Operand(rawLexeme: "8")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "9")!,
          Operator(rawValue: "+")!,
          Parenthesis.open,
          Operand(rawLexeme: "0")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "1")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "9")!,
          Operand(rawLexeme: "0")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Parenthesis.open,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "3")!,
          Parenthesis.close,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "4")!,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "1")!,
          Operand(rawLexeme: "3")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "4")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Parenthesis.open,
          Operand(rawLexeme: "6")!,
          Operator(rawValue: "×")!,
          Parenthesis.open,
          Operand(rawLexeme: "7")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "5")!,
          Parenthesis.close,
          Parenthesis.close,
        ], [
          Operand(rawLexeme: "6")!,
          Operand(rawLexeme: "7")!,
          Operand(rawLexeme: "5")!,
          Operator(rawValue: "÷")!,
          Operator(rawValue: "×")!,
        ]
      ),

      // MARK: (A + B) + (C + D)
      (
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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
        [
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
        ], [
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

      // MARK: Evaluation errors
      (
        [Operator(rawValue: "+")!],
        [Operator(rawValue: "+")!]
      ),
      (
        [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!],
        [Operand(rawLexeme: "1")!, Operator(rawValue: "+")!]
      ),
      (
        [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!],
        [Operand(rawLexeme: "1")!, Operand(rawLexeme: "1")!]
      ),
      (
        [Operand(rawLexeme: "1")!, Operator(rawValue: "÷")!, Operand(rawLexeme: "0")!],
        [Operand(rawLexeme: "1")!, Operand(rawLexeme: "0")!, Operator(rawValue: "÷")!]
      ),
      (
        [
          Operand(rawLexeme: "9223372036854775807")!,
          Operator(rawValue: "+")!,
          Operand(rawLexeme: "1")!,
        ], [
          Operand(rawLexeme: "9223372036854775807")!,
          Operand(rawLexeme: "1")!,
          Operator(rawValue: "+")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "-9223372036854775808")!,
          Operator(rawValue: "÷")!,
          Operand(rawLexeme: "-1")!,
        ], [
          Operand(rawLexeme: "-9223372036854775808")!,
          Operand(rawLexeme: "-1")!,
          Operator(rawValue: "÷")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "-9223372036854775808")!,
          Operator(rawValue: "×")!,
          Operand(rawLexeme: "-1")!,
        ], [
          Operand(rawLexeme: "-9223372036854775808")!,
          Operand(rawLexeme: "-1")!,
          Operator(rawValue: "×")!,
        ]
      ),
      (
        [
          Operand(rawLexeme: "9223372036854775807")!,
          Operator(rawValue: "-")!,
          Operand(rawLexeme: "-1")!,
        ],
        [
          Operand(rawLexeme: "9223372036854775807")!,
          Operand(rawLexeme: "-1")!,
          Operator(rawValue: "-")!,
        ]
      ),
    ]

    for fixture in fixtures {
      let tokens = fixture.tokens
      let expectedTokens = fixture.expectedTokens
      let actualTokens = try! parse(infixTokens: tokens)

      XCTAssertTrue(expectedTokens.count == actualTokens.count)

      for (expected, actual) in zip(expectedTokens, actualTokens) {
        XCTAssertTrue(expected.isEqualTo(actual), "expected: \(expected), actual: \(actual)")
      }
    }
  }

  func testParseError() {
    typealias Fixture = (
      tokens: [Tokenable],
      expected: ExpressionError
    )

    let fixtures: [Fixture] = [
      ([Parenthesis.close], .missingParenthesisOpen),
      ([Parenthesis.open], .missingParenthesisClose),
    ]

    for fixture in fixtures {
      let tokens = fixture.tokens
      let expected = fixture.expected

      XCTAssertThrowsError(try parse(infixTokens: tokens)) { error in
        XCTAssertEqual(expected, error as? ExpressionError)
      }
    }
  }
}
