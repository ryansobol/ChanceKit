enum Operand : Tokenable, Equatable {
  case number(Int)

  func value() -> Int {
    switch self {
    case .number(let value):
      return value
    }
  }

  static func +(left: Operand, right: Operand) -> Operand {
    return Operand.number(left.value() + right.value())
  }

  // TODO: - Handle division by zero
  static func /(left: Operand, right: Operand) -> Operand {
    return Operand.number(left.value() / right.value())
  }

  static func *(left: Operand, right: Operand) -> Operand {
    return Operand.number(left.value() * right.value())
  }

  static func -(left: Operand, right: Operand) -> Operand {
    return Operand.number(left.value() - right.value())
  }
}
