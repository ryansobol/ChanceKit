enum Operand : Tokenable {
  case number(Int)

  // TODO: - What about tests?
  func value() -> Int {
    switch self {
    case .number(let value):
      return value
    }
  }

  static func +(left: Operand, right: Operand) -> Operand {
    return Operand.number(left.value() + right.value())
  }

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
