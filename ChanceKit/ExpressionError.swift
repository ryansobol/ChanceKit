public enum ExpressionError: Error, Equatable {
  case divisionByZero
  case invalidLexeme(String)
  case invalidCombinationOperands(String, String)
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperandRollSides
  case missingOperator
  // TODO: Split into the following error cases
  //  overflowAdditionOperands(String, String)
  //  overflowDivisionOperands(String, String)
  //  overflowMultiplicationOperands(String, String)
  //  overflowNegationOperand(String)
  //  overflowSubtractionOperands(String, String)
  case operationOverflow
}
