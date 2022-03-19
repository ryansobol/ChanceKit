enum Operator: String, CaseIterable {
  case addition = "+"
  case division = "÷"
  case multiplication = "×"
  case subtraction = "-"
}

// MARK: - Markable

extension Operator: Markable {
  var description: String {
    return self.rawValue
  }
}

// MARK: - Comparison

extension Operator {
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
}

// MARK: - Evaluation

extension Operator {
  func evaluate(_ operand1: any Operand, _ operand2: any Operand) throws -> any Operand {
    switch self {
    case .addition:
      return try operand1.added(operand2)

    case .division:
      return try operand1.divided(operand2)

    case .multiplication:
      return try operand1.multiplied(operand2)

    case .subtraction:
      return try operand1.subtracted(operand2)
    }
  }
}
