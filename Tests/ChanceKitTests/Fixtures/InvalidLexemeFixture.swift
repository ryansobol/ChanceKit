@testable import ChanceKit

typealias InvalidLexemeFixture = (
  lexeme: String,
  initError: Expression.InitError,
  pushedError: Expression.PushedError
)

let invalidLexemeFixtures: [InvalidLexemeFixture] = [
  (lexeme: "d", initError: .invalidLexeme(lexeme: "d"), pushedError: .invalidLexeme(lexeme: "d")),
  (
    lexeme: "-d",
    initError: .invalidLexeme(lexeme: "-d"),
    pushedError: .invalidLexeme(lexeme: "-d")
  ),
  (
    lexeme: "d-",
    initError: .invalidLexeme(lexeme: "d-"),
    pushedError: .invalidLexeme(lexeme: "d-")
  ),
  (
    lexeme: "-d-",
    initError: .invalidLexeme(lexeme: "-d-"),
    pushedError: .invalidLexeme(lexeme: "-d-")
  ),
  (
    lexeme: "+d",
    initError: .invalidLexeme(lexeme: "+d"),
    pushedError: .invalidLexeme(lexeme: "+d")
  ),
  (
    lexeme: "d+",
    initError: .invalidLexeme(lexeme: "d+"),
    pushedError: .invalidLexeme(lexeme: "d+")
  ),
  (
    lexeme: "+d+",
    initError: .invalidLexeme(lexeme: "+d+"),
    pushedError: .invalidLexeme(lexeme: "+d+")
  ),
  (
    lexeme: "d0",
    initError: .invalidLexeme(lexeme: "d0"),
    pushedError: .invalidLexeme(lexeme: "d0")
  ),
  (
    lexeme: "d1",
    initError: .invalidLexeme(lexeme: "d1"),
    pushedError: .invalidLexeme(lexeme: "d1")
  ),
  (
    lexeme: "d9",
    initError: .invalidLexeme(lexeme: "d9"),
    pushedError: .invalidLexeme(lexeme: "d9")
  ),
  (
    lexeme: "d-0",
    initError: .invalidLexeme(lexeme: "d-0"),
    pushedError: .invalidLexeme(lexeme: "d-0")
  ),
  (
    lexeme: "d-1",
    initError: .invalidLexeme(lexeme: "d-1"),
    pushedError: .invalidLexeme(lexeme: "d-1")
  ),
  (
    lexeme: "d-9",
    initError: .invalidLexeme(lexeme: "d-9"),
    pushedError: .invalidLexeme(lexeme: "d-9")
  ),
  (
    lexeme: "-d0",
    initError: .invalidLexeme(lexeme: "-d0"),
    pushedError: .invalidLexeme(lexeme: "-d0")
  ),
  (
    lexeme: "-d1",
    initError: .invalidLexeme(lexeme: "-d1"),
    pushedError: .invalidLexeme(lexeme: "-d1")
  ),
  (
    lexeme: "-d9",
    initError: .invalidLexeme(lexeme: "-d9"),
    pushedError: .invalidLexeme(lexeme: "-d9")
  ),
  (
    lexeme: "d+0",
    initError: .invalidLexeme(lexeme: "d+0"),
    pushedError: .invalidLexeme(lexeme: "d+0")
  ),
  (
    lexeme: "d+1",
    initError: .invalidLexeme(lexeme: "d+1"),
    pushedError: .invalidLexeme(lexeme: "d+1")
  ),
  (
    lexeme: "d+9",
    initError: .invalidLexeme(lexeme: "d+9"),
    pushedError: .invalidLexeme(lexeme: "d+9")
  ),
  (
    lexeme: "+d0",
    initError: .invalidLexeme(lexeme: "+d0"),
    pushedError: .invalidLexeme(lexeme: "+d0")
  ),
  (
    lexeme: "+d1",
    initError: .invalidLexeme(lexeme: "+d1"),
    pushedError: .invalidLexeme(lexeme: "+d1")
  ),
  (
    lexeme: "+d9",
    initError: .invalidLexeme(lexeme: "+d9"),
    pushedError: .invalidLexeme(lexeme: "+d9")
  ),
  (
    lexeme: "+d-0",
    initError: .invalidLexeme(lexeme: "+d-0"),
    pushedError: .invalidLexeme(lexeme: "+d-0")
  ),
  (
    lexeme: "+d-1",
    initError: .invalidLexeme(lexeme: "+d-1"),
    pushedError: .invalidLexeme(lexeme: "+d-1")
  ),
  (
    lexeme: "+d-9",
    initError: .invalidLexeme(lexeme: "+d-9"),
    pushedError: .invalidLexeme(lexeme: "+d-9")
  ),
  (
    lexeme: "+d+0",
    initError: .invalidLexeme(lexeme: "+d+0"),
    pushedError: .invalidLexeme(lexeme: "+d+0")
  ),
  (
    lexeme: "+d+1",
    initError: .invalidLexeme(lexeme: "+d+1"),
    pushedError: .invalidLexeme(lexeme: "+d+1")
  ),
  (
    lexeme: "+d+9",
    initError: .invalidLexeme(lexeme: "+d+9"),
    pushedError: .invalidLexeme(lexeme: "+d+9")
  ),
  (
    lexeme: "0d+",
    initError: .invalidLexeme(lexeme: "0d+"),
    pushedError: .invalidLexeme(lexeme: "0d+")
  ),
  (
    lexeme: "1d+",
    initError: .invalidLexeme(lexeme: "1d+"),
    pushedError: .invalidLexeme(lexeme: "1d+")
  ),
  (
    lexeme: "9d+",
    initError: .invalidLexeme(lexeme: "9d+"),
    pushedError: .invalidLexeme(lexeme: "9d+")
  ),
  (
    lexeme: "-0d+",
    initError: .invalidLexeme(lexeme: "-0d+"),
    pushedError: .invalidLexeme(lexeme: "-0d+")
  ),
  (
    lexeme: "-1d+",
    initError: .invalidLexeme(lexeme: "-1d+"),
    pushedError: .invalidLexeme(lexeme: "-1d+")
  ),
  (
    lexeme: "-9d+",
    initError: .invalidLexeme(lexeme: "-9d+"),
    pushedError: .invalidLexeme(lexeme: "-9d+")
  ),
  (
    lexeme: "+0d+",
    initError: .invalidLexeme(lexeme: "+0d+"),
    pushedError: .invalidLexeme(lexeme: "+0d+")
  ),
  (
    lexeme: "+1d+",
    initError: .invalidLexeme(lexeme: "+1d+"),
    pushedError: .invalidLexeme(lexeme: "+1d+")
  ),
  (
    lexeme: "+9d+",
    initError: .invalidLexeme(lexeme: "+9d+"),
    pushedError: .invalidLexeme(lexeme: "+9d+")
  ),
  (
    lexeme: "0d0\n1d1",
    initError: .invalidLexeme(lexeme: "0d0\n1d1"),
    pushedError: .invalidLexeme(lexeme: "0d0\n1d1")
  ),
  (lexeme: "=", initError: .invalidLexeme(lexeme: "="), pushedError: .invalidLexeme(lexeme: "=")),
  (lexeme: "[", initError: .invalidLexeme(lexeme: "["), pushedError: .invalidLexeme(lexeme: "[")),
  (lexeme: "]", initError: .invalidLexeme(lexeme: "]"), pushedError: .invalidLexeme(lexeme: "]")),
  (lexeme: "{", initError: .invalidLexeme(lexeme: "{"), pushedError: .invalidLexeme(lexeme: "{")),
  (lexeme: "}", initError: .invalidLexeme(lexeme: "}"), pushedError: .invalidLexeme(lexeme: "}")),
  (lexeme: "<", initError: .invalidLexeme(lexeme: "<"), pushedError: .invalidLexeme(lexeme: "<")),
  (lexeme: ">", initError: .invalidLexeme(lexeme: ">"), pushedError: .invalidLexeme(lexeme: ">")),
  (lexeme: ".", initError: .invalidLexeme(lexeme: "."), pushedError: .invalidLexeme(lexeme: ".")),
  (lexeme: ",", initError: .invalidLexeme(lexeme: ","), pushedError: .invalidLexeme(lexeme: ",")),
  (
    lexeme: "**",
    initError: .invalidLexeme(lexeme: "**"),
    pushedError: .invalidLexeme(lexeme: "**")
  ),
  (lexeme: "&", initError: .invalidLexeme(lexeme: "&"), pushedError: .invalidLexeme(lexeme: "&")),
  (lexeme: "|", initError: .invalidLexeme(lexeme: "|"), pushedError: .invalidLexeme(lexeme: "|")),
  (lexeme: "!", initError: .invalidLexeme(lexeme: "!"), pushedError: .invalidLexeme(lexeme: "!")),
  (lexeme: "~", initError: .invalidLexeme(lexeme: "~"), pushedError: .invalidLexeme(lexeme: "~")),
  (
    lexeme: "..<",
    initError: .invalidLexeme(lexeme: "..<"),
    pushedError: .invalidLexeme(lexeme: "..<")
  ),
  (
    lexeme: "...",
    initError: .invalidLexeme(lexeme: "..."),
    pushedError: .invalidLexeme(lexeme: "...")
  ),
  (
    lexeme: "<<",
    initError: .invalidLexeme(lexeme: "<<"),
    pushedError: .invalidLexeme(lexeme: "<<")
  ),
  (
    lexeme: ">>",
    initError: .invalidLexeme(lexeme: ">>"),
    pushedError: .invalidLexeme(lexeme: ">>")
  ),
  (lexeme: "%", initError: .invalidLexeme(lexeme: "%"), pushedError: .invalidLexeme(lexeme: "%")),
]
