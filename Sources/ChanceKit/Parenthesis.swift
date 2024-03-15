enum Parenthesis: String, CaseIterable {
	case close = ")"
	case open = "("
}

// MARK: - Markable

extension Parenthesis: Markable {
	var description: String {
		return self.rawValue
	}
}
