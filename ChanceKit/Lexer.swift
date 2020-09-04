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

  case let lastOperand as Operand:

    switch lastOperand {
    case .constant:

      switch operand {
      case .constant:
        let nextOperand = try lastOperand.combined(operand)

        tokens.removeLast()
        tokens.append(nextOperand)

      default:
        tokens.append(Operator.addition)
        tokens.append(operand)
      }

    case let .roll(_, sidesLast):

      switch operand {
      case .constant:
        let nextOperand = try lastOperand.combined(operand)

        tokens.removeLast()
        tokens.append(nextOperand)

      case let .roll(_, sidesCurrent):
        if sidesLast == sidesCurrent {
          let nextOperand = try lastOperand.combined(operand)

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

    case .rollNegativeSides:

      switch operand {
      case .constant:
        let nextOperand = try lastOperand.combined(operand)

        tokens.removeLast()
        tokens.append(nextOperand)

      case .rollNegativeSides:
        let nextOperand = try lastOperand.combined(operand)

        tokens.removeLast()
        tokens.append(nextOperand)

      default:
        tokens.append(Operator.addition)
        tokens.append(operand)
      }

    case .rollPositiveSides:

      switch operand {
      case .constant:
        let nextOperand = try lastOperand.combined(operand)

        tokens.removeLast()
        tokens.append(nextOperand)

      case .rollPositiveSides:
        let nextOperand = try lastOperand.combined(operand)

        tokens.removeLast()
        tokens.append(nextOperand)

      default:
        tokens.append(Operator.addition)
        tokens.append(operand)
      }
    }

  default:
    preconditionFailure()
  }

  return tokens
}
