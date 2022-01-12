func lexed(parenthesis: Parenthesis, into: [Tokenable]) -> [Tokenable] {
  var tokens = into

  if parenthesis == .close {
    if !tokens.isEmpty {
      let parenthesisRatio = tokens
        .filter { $0 is Parenthesis }
        .map { $0 as! Parenthesis }
        .map { $0 == .open ? 1 : -1 }
        .reduce(0, +)

      if parenthesisRatio == 0 && (tokens.last is Constant || tokens.last is Roll) {
        tokens.insert(Parenthesis.open, at: 0)
      }
    }

    tokens.append(parenthesis)

    return tokens
  }

  if let lastParenthesis = tokens.last as? Parenthesis, lastParenthesis == .close {
    tokens.append(Operator.multiplication)
  }
  else if tokens.last is Constant || tokens.last is Roll {
    tokens.append(Operator.multiplication)
  }

  tokens.append(parenthesis)

  return tokens
}

func lexed(operator: Operator, into: [Tokenable]) -> [Tokenable] {
  var tokens = into

  if `operator` == .addition {
    if tokens.last is RollPositiveSides {
      return tokens
    }

    if let lastRollNegativeSides = tokens.last as? RollNegativeSides {
      let rollPositiveSides = try! lastRollNegativeSides.negated()

      tokens.removeLast()
      tokens.append(rollPositiveSides)

      return tokens
    }
  }

  if `operator` == .subtraction, let lastRollPositiveSides = tokens.last as? RollPositiveSides {
    let rollNegativeSides = try! lastRollPositiveSides.negated()

    tokens.removeLast()
    tokens.append(rollNegativeSides)

    return tokens
  }

  if tokens.last is Operator {
    tokens.removeLast()
  }

  tokens.append(`operator`)

  return tokens
}

func lexed(operand: Operand, into: [Tokenable]) throws -> [Tokenable] {
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
    case let currentConstant as Constant:
      let nextOperand = try lastConstant.combined(currentConstant)

      tokens.removeLast()
      tokens.append(nextOperand)

    case is Roll, is RollNegativeSides, is RollPositiveSides:
      tokens.append(Operator.addition)
      tokens.append(operand)

    default:
      preconditionFailure()
    }

  case let lastRoll as Roll:

    switch operand {
    case let currentConstant as Constant:
      let nextOperand = try lastRoll.combined(currentConstant)

      tokens.removeLast()
      tokens.append(nextOperand)

    case let currentRoll as Roll where lastRoll.sides == currentRoll.sides:
      let nextOperand = try lastRoll.combined(currentRoll)

      tokens.removeLast()
      tokens.append(nextOperand)

    case let currentRoll as Roll where lastRoll.sides != currentRoll.sides:
      tokens.append(Operator.addition)
      tokens.append(operand)

    case is RollNegativeSides, is RollPositiveSides:
      tokens.append(Operator.addition)
      tokens.append(operand)

    default:
      preconditionFailure()
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

    case is Roll, is RollPositiveSides:
      tokens.append(Operator.addition)
      tokens.append(operand)

    default:
      preconditionFailure()
    }

  case let lastRollPositiveSides as RollPositiveSides:

    switch operand {
    case let currentConstant as Constant:
      let nextOperand = try lastRollPositiveSides.combined(currentConstant)

      tokens.removeLast()
      tokens.append(nextOperand)

    case let currentRollPositiveSides as RollPositiveSides:
      let nextOperand = try lastRollPositiveSides.combined(currentRollPositiveSides)

      tokens.removeLast()
      tokens.append(nextOperand)

    case is Roll, is RollNegativeSides:
      tokens.append(Operator.addition)
      tokens.append(operand)

    default:
      preconditionFailure()
    }

  default:
    preconditionFailure()
  }

  return tokens
}
