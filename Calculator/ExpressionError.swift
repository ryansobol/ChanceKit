public enum ExpressionError: Error {
  case divisionByZero
  case invalidToken
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperator
}
