enum Parenthesis: String, Markable {
  case close = ")"
  case open = "("

  // MARK: - Presentation

  var description: String {
    return rawValue
  }
}
