# Getting Started

**ChanceKit** is a Swift library for building apps and games that use probability. 

## Overview

Building an app or game with probablistic logic is astonishingly complex. That logic must include:

- Determining an appropriate pseudorandom number generator and distribution algorithm
- Balancing unpredictability, performance, and independence when generating random numbers
- Providing a natural, domain-specific language to express and encapsulate these complexities

ChanceKit does all of this so you can focus on the creative parts of building apps and games. It provides models and utilities for initializing, interpretting, and deriving mathematical expressions that support probabilities.

At the heart of ChanceKit is the ``Expression`` structure–a composition of sequential lexemes such as numbers, polyhedral dice rolls, arithmetic operations, and arithmetic groups. For example:

- `6`
- `1d6`
- `1d6 + 4`
- `1d6 + 2d4`
- `(1d6 + 2d4) × 2`

### Initialize an Expression

To create a blank expression, you initialize a new instance of the ``Expression`` structure using the ``Expression/init()`` initializer without any lexemes:

```swift
import ChanceKit

var expression = Expression()

print("The expression is \(expression)")
// Prints "The expression is "
```

Alternatively, you can specify a sequence of lexemes at creation, so long as you handle the potential for a thrown ``Expression/InitError``:

```swift
do {
  expression = try Expression(lexemes: ["1d6", "+", "4"])

  print("The expression is \(expression)")
  // Prints "The expression is 1d6 + 4"
}
catch Expression.InitError.invalidLexeme(let lexeme) {
  print("The lexeme \(lexeme) is invalid")
}
```

ChanceKit supports many kinds of lexemes. To learn more them, see the documentation on the ``Expression/init(lexemes:)`` method.

### Interpret an Expression

Once initialized, you can interpret an expression using the ``Expression/interpret()`` method. As long as you handle the potential for a thrown ``Expression/InterpretError``, it produces a single, probablistic result:

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

### Derive an Expression

ChanceKit provides a few ways to derive new expressions from existing ones. First, dropping a character from the last lexeme of an expression using the ``Expression/dropped()`` method produces a new, shorter expression.

```swift
var shorter = expression.dropped()

print("The shorter expression is \(shorter)")
// Prints "The shorter expression is 1d6 +"
```

Continuing to drop characters from an expression produces shorter and shorter expressions.

```swift
shorter = shorter.dropped()

print("The shorter expression is \(shorter)")
// Prints "The shorter expression is 1d6"

shorter = shorter.dropped()

print("The shorter expression is \(shorter)")
// Prints "The shorter expression is 1d"

shorter = shorter.dropped()

print("The shorter expression is \(shorter)")
// Prints "The shorter expression is 1"
```

Pushing a lexeme onto the end of an expression using the ``Expression/pushed(lexeme:)`` method produces a new, longer expression. However, be sure to handle the potential for a thrown ``Expression/PushedError``:

```swift
var lexeme = "d"

var longer: Expression

do {
  longer = try shorter.pushed(lexeme: lexeme)

  print("The longer expression is \(longer)")
  // Prints "The longer expression is 1d"
}
catch let error as Expression.PushedError {
  print("The lexeme \(lexeme) cannot be pushed because \(error)")
}
```

Continuing to push lexemes onto an expression produces longer and longer expressions. You can omit error handling if you know the lexeme won't throw an ``Expression/PushedError``:

```swift
longer = try! longer.pushed(lexeme: "6")

print("The longer expression is \(longer)")
// Prints "The longer expression is 1d6"

longer = try! longer.pushed(lexeme: "+")

print("The longer expression is \(longer)")
// Prints "The longer expression is 1d6 +"

longer = try! longer.pushed(lexeme: "2d4")

print("The longer expression is \(longer)")
// Prints "The longer expression is 1d6 + 2d4"

longer = try! longer.pushed(lexeme: ")")

print("The longer expression is \(longer)")
// Prints "The longer expression is (1d6 + 2d4)"

longer = try! longer.pushed(lexeme: "×")

print("The longer expression is \(longer)")
// Prints "The longer expression is (1d6 + 2d4) ×"

longer = try! longer.pushed(lexeme: "2")

print("The longer expression is \(longer)")
// Prints "The longer expression is (1d6 + 2d4) × 2"
```

Notice that pushing a `")"` lexeme caused a missing `"("` lexeme to be inserted at the front of a resulting ``Expression``. ChanceKit supports many convienent interactions like this when pushing lexemes. To learn more about them, see the documentation on the ``Expression/pushed(lexeme:)`` method.
