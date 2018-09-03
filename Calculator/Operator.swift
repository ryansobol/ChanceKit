enum Operator: String, Markable {
  case addition = "+"
  case division = "÷"
  case multiplication = "×"
  case subtraction = "-"

  // MARK: - Presentation

  var description: String {
    return rawValue
  }

  func hasPrecedence(_ other: Operator) -> Bool {
    let precedenceSelf: Int
    let precendenceOther: Int

    switch self {
    case .division, .multiplication:
      precedenceSelf = 1

    case .addition, .subtraction:
      precedenceSelf = 0
    }

    switch other {
    case .division, .multiplication:
      precendenceOther = 1

    case .addition, .subtraction:
      precendenceOther = 0
    }

    return precedenceSelf > precendenceOther
  }

  func evaluate(_ operand1: Operand, _ operand2: Operand) throws -> Operand {
    switch self {
    case .addition:
      return try operand1 + operand2

    case .division:
      return try operand1 / operand2

    case .multiplication:
      return try operand1 * operand2

    case .subtraction:
      return try operand1 - operand2
    }
  }
}
