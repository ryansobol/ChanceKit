enum Operand : Tokenable {
  case number(Int)

  // TODO: - What about tests?
  func evaluate() -> Int {
    switch self {
    case .number(let value):
      return value
    }
  }
}
