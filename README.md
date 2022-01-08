# ChanceKit

Create mathematical expressions that support probabilities.

An expression is composed of a sequence of lexemes—numbers and polyhedral dice rolls, separated by arithmetic operations and potentially organized into arithmetic groups. Interpretting an expression produces a single, probablistic result.

An expression is initialized with zero or more lexemes using the `init(lexemes:)` initializer.

```swift
import ChanceKit

let expression: Expression

do {
  expression = try Expression(lexemes: ["1d6", "+", "4"])

  print("The expression is \(expression)")
  // Prints "The expression is 1d6 + 4"
}
catch Expression.InitError.invalidLexeme(let lexeme) {
  print("The lexeme \(lexeme) is invalid")
}
```

Interpretting an expression using the `interpret()` method produces a single, probablistic result.

```swift
do {
  let result = try expression.interpret()

  print("The result \(result) is between 5 and 10")
  // Prints "The result 7 is between 5 and 10"
}
catch let error as Expression.InterpretError {
  print("The expression \(expression) cannot be interpretted because \(error)")
}
```

Dropping a character from the last lexeme of an expression using the `dropped()` method produces a new, shorter expression.

```swift
let shorter = expression.dropped()

print("The shorter expression is \(shorter)")
// Prints "The shorter expression is 1d6 +"
```

Pushing a lexeme onto the end of an expression using the `pushed(lexeme:)` method produces a new, longer expression.

```swift
do {
  let longer = try shorter.pushed(lexeme: "2d4")

  print("The longer expression is \(longer)")
  // Prints "The longer expression is 1d6 + 2d4"
}
catch Expression.PushedError.invalidLexeme(let lexeme) {
  print("The lexeme \(lexeme) is invalid")
}
```
