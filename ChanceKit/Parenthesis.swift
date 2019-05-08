enum Parenthesis: String {
  case close = ")"
  case open = "("
}

// MARK: - Markable

extension Parenthesis: Markable {
  var description: String {
    return rawValue
  }
}
