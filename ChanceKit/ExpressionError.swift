public enum ExpressionError: Error, Equatable {
  case divisionByZero
  case invalidLexeme(String)
  case invalidCombinationOperands(String, String)
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperandRollSides
  case missingOperator
//  TODO: Split into the following error cases
//  case overflowAdditionOperands(Int, Int)
//  case overflowDivisionOperands(Int, Int)
//  case overflowMultiplicationOperands(Int, Int)
//  case overflowNegationOperand(Int)
//  case overflowSubtractionOperands(Int, Int)
  case operationOverflow
}
