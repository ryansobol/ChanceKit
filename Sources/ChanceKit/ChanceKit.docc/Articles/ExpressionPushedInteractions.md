# Expression Pushed Interactions

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

### Number

Given the last lexeme of an existing expression is a number, when a non-negative number lexeme is pushed onto the end of the expression, then the two lexemes are combined and it replaces the last lexeme in the new expression.

| Existing | Pushed | New       |
| --------:| ------:| ---------:|
|  `1 + 2` |    `3` |  `1 + 23` |
| `1 + -2` |    `3` | `1 + -23` |

Given the last and only lexeme of an existing expression is a `"0"` number, when any number lexeme is pushed onto the end of the expression, then the pushed lexeme replaces the `"0"` lexeme in the new expression.

| Existing | Pushed | New  |
| --------:| ------:| ----:|
|      `0` |    `3` |  `3` |
|      `0` |   `-3` | `-3` |
|      `0` |    `0` |  `0` |

TODO polyhedryal dice rolls
TODO partial polyhedral dice rolls

Given the last and only lexeme of an existing expression is a `"+"` arithmetic operator, when any number lexeme is pushed onto the end of the expression, then the pushed lexeme replaces the `"+"` lexeme in the new expression.

| Existing | Pushed | New  |
| --------:| ------:| ----:|
|      `+` |    `3` |  `3` |
|      `+` |   `-3` | `-3` |
|      `+` |    `0` |  `0` |

Given the last and only lexeme of an existing expression is a `"-"` arithmetic operator, when any number lexeme is pushed onto the end of the expression, then the pushed lexeme is negated and it replaces the `"-"` lexeme in the new expression.

| Existing | Pushed | New  |
| --------:| ------:| ----:|
|      `-` |    `3` | `-3` |
|      `-` |   `-3` |  `3` |
|      `-` |    `0` |  `0` |

Given the last lexeme of an existing expression is a `")"` arithmetic group, when any number lexeme is pushed onto the end of the expression, then a `"×"` lexeme is inserted between the `")"` lexeme and the pushed lexeme in the new expression.

| Existing  | Pushed | New              |
| ---------:| ------:| ----------------:|
| `(1 + 2)` |    `3` |  `(1 + 2) × 3` |
| `(1 + 2)` |   `-3` | `(1 + 2) × -3` |
| `(1 + 2)` |    `0` |  `(1 + 2) × 0` |

### Polyhedral Dice Roll

TODO

### Partial Polyhedral Dice Roll

TODO

### Arithmetic Operator

Given the last lexeme of an existing expression is a `"+"`, `"-"`, `"×"`, or `"÷"` arithmetic operator, when any arithmetic operator lexeme is pushed onto the end of the expression, then the last lexeme is replaced by the pushed lexeme in the new expression.

| Existing | Pushed | New       |
| --------:| ------:| ---------:|
|    `3 +` |    `-` | `3 -`     |
|    `3 +` |    `+` | `3 +`     |
|    `3 -` |    `-` | See below |
|    `3 -` |    `+` | `3 +`     |

Given the last lexeme of an existing expression is a `"-"` arithmetic operator, when another `"-"` arithmetic operator lexeme is pushed onto the end of the expression, then a `"("` arithmetic group lexeme is inserted between the two `"-"` lexemes in the new expression.

| Existing | Pushed | New      |
| --------:| ------:| --------:|
|    `3 -` |    `-` | `3 - (-` |

Given the last lexeme of an existing expression is a partial polyhedral dice roll, when a `"+"` or `"-"` lexeme is pushed onto the end of the expression, then the lexeme becomes the sign for the missing sides value of the partial polyhedral dice roll in the new expression.

| Existing | Pushed | New   |
| --------:| ------:| -----:|
|     `3d` |    `-` | `3d-` |
|     `3d` |    `+` |  `3d` |
|    `3d-` |    `-` | `3d-` |
|    `3d-` |    `+` |  `3d` |

### Arithmetic Group

Given the last lexeme of an existing expression is a number, polyhedral dice roll, or `")"`, when a `"("` lexeme is pushed onto the end of the expression, then a `"×"` lexeme is inserted before the pushed `"("` lexeme in the new expression.

| Existing    | Pushed | New             |
| -----------:| ------:| ---------------:|
|         `3` |    `(` |         `3 × (` |
|       `3d6` |    `(` |       `3d6 × (` |
| `(3d6 + 2)` |    `(` | `(3d6 + 2) × (` |

 Given there is a balanced ratio of `"("` and `")"` lexemes in an existing expression, when a `")"` lexeme is pushed onto the end of the expression, then a `"("` lexeme is also inserted at the front of the new expression.

| Existing | Pushed | New       |
| --------:| ------:| ---------:|
|      `3` |    `)` |     `(3)` |
|    `(3)` |    `)` |   `((3))` |
