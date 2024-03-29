struct Constant {
	let term: Int
}

// MARK: - Operand, Equatable

extension Constant: Operand, Equatable {
	// MARK: - Tokenable

	var description: String {
		return String(self.term)
	}

	// MARK: - Initialization

	init?(rawLexeme: String) {
		guard let term = Int(rawLexeme) else {
			return nil
		}

		self.term = term
	}

	// MARK: - Inclusion

	func combined(_ other: Constant) throws -> any Operand {
		let lexemeSelf = String(describing: self)
		let lexemeOther = String(describing: other)

		guard let termResult = Int(lexemeSelf + lexemeOther) else {
			throw Expression.PushedError.invalidCombination(
				operandLeft: lexemeSelf,
				operandRight: lexemeOther
			)
		}

		return Constant(term: termResult)
	}

	func combined(_ other: Roll) throws -> any Operand {
		throw Expression.PushedError.invalidCombination(
			operandLeft: String(describing: self),
			operandRight: String(describing: other)
		)
	}

	func combined(_ other: RollNegativeSides) throws -> any Operand {
		throw Expression.PushedError.invalidCombination(
			operandLeft: String(describing: self),
			operandRight: String(describing: other)
		)
	}

	func combined(_ other: RollPositiveSides) throws -> any Operand {
		throw Expression.PushedError.invalidCombination(
			operandLeft: String(describing: self),
			operandRight: String(describing: other)
		)
	}

	// MARK: - Exclusion

	func dropped() -> (any Tokenable)? {
		let quotient = self.term / 10

		if quotient != 0 {
			return Constant(term: quotient)
		}

		let remainder = self.term % 10

		if remainder < 0 {
			return Operator.subtraction
		}

		return nil
	}

	// MARK: - Evaluation

	func value() throws -> Int {
		return self.term
	}

	// MARK: - Operation

	func negated() throws -> any Operand {
		// Because -Int.min > Int.max
		if self.term == Int.min {
			throw Expression.PushedError.overflowNegation(operand: String(describing: self))
		}

		return Constant(term: -self.term)
	}
}
