enum Operator: String, Tokenable {
  case addition = "+"
  case division = "÷"
  case multiplication = "×"
  case parenthesisClose = ")"
  case parenthesisOpen = "("
  case subtraction = "-"

  // TODO: - What about parenthesis?
  func hasLowerOrEqualPrecedence(_ other: Operator) -> Bool {
    switch self {
    case .division, .multiplication:
      switch other {
      case .addition, .subtraction:
        return false

      default:
        return true
      }

    default:
      return true
    }
  }

  // TODO: - What about tests?
  func evaluate(_ operand1: Operand, _ operand2: Operand) -> Operand? {
    switch self {
    case .addition:
      return operand1 + operand2

    case .division:
      return operand1 / operand2

    case .multiplication:
      return operand1 * operand2

    case .subtraction:
      return operand1 - operand2

    default:
      return nil
    }
  }
}
