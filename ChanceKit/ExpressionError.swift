public enum ExpressionError: Error, Equatable {
  case divisionByZero
  case invalidLexeme(String)
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperandRollSides
  case missingOperator
  case operationOverflow
}
