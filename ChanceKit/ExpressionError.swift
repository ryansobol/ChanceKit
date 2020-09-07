public enum ExpressionError: Error, Equatable {
  case divisionByZero(operandLeft: String)
  case invalidInput(lexeme: String)
//  TODO: Refactor into the following error case
//  case invalidCombination(operandLeft: String, operandRight: String)
  case invalidCombinationOperands(String, String)
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
//  TODO: Refactor into the following error case
//  case missingRollSides(operand: String)
  case missingOperandRollSides
  case missingOperator
//  TODO: Refactor into the following error cases
//  case overflowAddition(operandLeft: String, operandRight: String)
//  case overflowDivision(operandLeft: String, operandRight: String)
//  case overflowMultiplication(operandLeft: String, operandRight: String)
//  case overflowNegation(operand: String)
//  case overflowSubtraction(operandLeft: String, operandRight: String)
  case operationOverflow
}
