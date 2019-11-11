func lexed(parenthesis: Parenthesis, into: [Tokenable]) -> [Tokenable] {
  var tokens = into

  if parenthesis == .close {
    tokens.append(parenthesis)

    return tokens
  }

  if let lastParenthesis = tokens.last as? Parenthesis, lastParenthesis == .close {
    tokens.append(Operator.multiplication)
  }
  else if tokens.last is Operand {
    tokens.append(Operator.multiplication)
  }

  tokens.append(parenthesis)

  return tokens
}


func lexed(operator: Operator, into: [Tokenable]) -> [Tokenable] {
  var tokens = into

  if tokens.last is Operator {
    tokens.removeLast()
  }

  tokens.append(`operator`)

  return tokens
}

func lexed(integer: Int, into: [Tokenable]) throws -> [Tokenable] {
  var tokens = into

  switch tokens.last {
  case nil:
    tokens.append(Operand.number(integer))

  case let lastParenthesis as Parenthesis:
    if lastParenthesis == .close {
      tokens.append(Operator.multiplication)
    }

    tokens.append(Operand.number(integer))

  case let lastOperator as Operator:
    let tokensCount = tokens.count

    if tokensCount == 1 && lastOperator == .addition {
      tokens.removeLast()
    }

    var integer = integer

    if tokensCount == 1 && lastOperator == .subtraction {
      tokens.removeLast()

      integer.negate()
    }

    tokens.append(Operand.number(integer))

  case let lastOperand as Operand:
    // TODO: If current operand is .number
    //       and last operand is a .roll,
    //       then combine current .number into last .roll and replace

    // TODO: If current operand is a .roll
    //       and last operand is a .roll
    //       and current operand sides == last operand sides
    //       then combine current .roll into last .roll and replace

    // TODO: If current operand is a .roll
    //       and last operand is a .roll
    //       and current operand sides != last operand sides
    //       then append addition operator, then append current .roll

    // TODO: If current operand is .number
    //       and last operand is a .number
    //       then combine current .number into last .number and replace

    // TODO: If current operand is a .roll
    //       and last operand is a .number
    //       then append addition operator, then append current .roll
    let nextOperand = try lastOperand.pushed(integer)

    tokens.removeLast()
    tokens.append(nextOperand)

  default:
    preconditionFailure()
  }

  return tokens
}
