public enum ExpressionError: Error, Equatable {
  case divisionByZero
  case internalError(Int, String, String)
  case invalidToken(String)
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperator
  case operationOverflow
}
