func lexed(parenthesis: Parenthesis, into: [Tokenable]) -> [Tokenable] {
  var tokens = into

  if parenthesis == .close {
    tokens.append(parenthesis)

    return tokens
  }

  if let lastParenthesis = tokens.last as? Parenthesis, lastParenthesis == .close {
    tokens.append(Operator.multiplication)
  }
  else if tokens.last is Operand2 {
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

func lexed(operand: Operand2, into: [Tokenable]) throws -> [Tokenable] {
  var tokens = into

  switch tokens.last {
  case nil:
    tokens.append(operand)

  case let lastParenthesis as Parenthesis:
    if lastParenthesis == .close {
      tokens.append(Operator.multiplication)
    }

    tokens.append(operand)

  case let lastOperator as Operator:
    let tokensCount = tokens.count

    if tokensCount == 1 && lastOperator == .addition {
      tokens.removeLast()
    }

    var operand = operand

    if tokensCount == 1 && lastOperator == .subtraction {
      tokens.removeLast()

      operand = try operand.negated()
    }

    tokens.append(operand)

  case let lastConstant as Constant:

    switch operand {
    case let currentOperand as Constant:
      let nextOperand = try lastConstant.combined(currentOperand)

      tokens.removeLast()
      tokens.append(nextOperand)

    default:
      tokens.append(Operator.addition)
      tokens.append(operand)
    }

  case let lastRoll as Roll:

    switch operand {
    case let currentOperand as Constant:
      let nextOperand = try lastRoll.combined(currentOperand)

      tokens.removeLast()
      tokens.append(nextOperand)

    case let currentRoll as Roll:
      if lastRoll.sides == currentRoll.sides {
        let nextOperand = try lastRoll.combined(currentRoll)

        tokens.removeLast()
        tokens.append(nextOperand)
      }
      else {
        tokens.append(Operator.addition)
        tokens.append(operand)
      }

    default:
      tokens.append(Operator.addition)
      tokens.append(operand)
    }

  case let lastRollNegativeSides as RollNegativeSides:

    switch operand {
    case let currentConstant as Constant:
      let nextOperand = try lastRollNegativeSides.combined(currentConstant)

      tokens.removeLast()
      tokens.append(nextOperand)

    case let currentRollNegativeSides as RollNegativeSides:
      let nextOperand = try lastRollNegativeSides.combined(currentRollNegativeSides)

      tokens.removeLast()
      tokens.append(nextOperand)

    default:
      tokens.append(Operator.addition)
      tokens.append(operand)
    }

  case let lastRollPositiveSides as RollPositiveSides:

    switch operand {
    case let currentConstant as Constant:
      let nextOperand = try lastRollPositiveSides.combined(currentConstant)

      tokens.removeLast()
      tokens.append(nextOperand)

    case let currentRollPositiveSidess as RollPositiveSides:
      let nextOperand = try lastRollPositiveSides.combined(currentRollPositiveSidess)

      tokens.removeLast()
      tokens.append(nextOperand)

    default:
      tokens.append(Operator.addition)
      tokens.append(operand)
    }

  default:
    preconditionFailure()
  }

  return tokens
}
