enum ExpressionError: Error {
  case divisionByZero
  case invalidMark
  case invalidOperator
  case invalidToken
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperator
}
