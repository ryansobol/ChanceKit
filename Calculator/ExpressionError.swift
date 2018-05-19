enum ExpressionError: Error {
  case invalidOperator
  case invalidToken
  case missingCloseParenthesis
  case missingOperand
  case missingOperator
  case missingOpenParenthesis
}
