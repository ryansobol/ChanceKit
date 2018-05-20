enum Operator: String, Tokenable {
  case addition = "+"
  case division = "÷"
  case multiplication = "×"
  case parenthesisClose = ")"
  case parenthesisOpen = "("
  case subtraction = "-"

  // TODO: - Remove parenthesis
  func hasPrecedence(_ other: Operator) -> Bool {
    let precedenceSelf: Int
    let precendenceOther: Int

    switch self {
    case .parenthesisClose, .parenthesisOpen:
      precedenceSelf = 2

    case .division, .multiplication:
      precedenceSelf = 1

    case .addition, .subtraction:
      precedenceSelf = 0
    }

    switch other {
    case .parenthesisClose, .parenthesisOpen:
      precendenceOther = 2

    case .division, .multiplication:
      precendenceOther = 1

    case .addition, .subtraction:
      precendenceOther = 0
    }

    return precedenceSelf > precendenceOther
  }

  func evaluate(_ operand1: Operand, _ operand2: Operand) -> Operand? {
    switch self {
    case .addition:
      return operand1 + operand2

    case .division:
      return operand1 / operand2

    case .multiplication:
      return operand1 * operand2

    case .parenthesisClose, .parenthesisOpen:
      return nil

    case .subtraction:
      return operand1 - operand2
    }
  }
}
