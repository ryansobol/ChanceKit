public enum ExpressionError: Error, Equatable {
  case divisionByZero(operandLeft: String)
  case invalidCombination(operandLeft: String, operandRight: String)
  case invalidInput(lexeme: String)
  case missingParenthesisClose
  case missingParenthesisOpen
  case missingOperand
  case missingOperator
  case missingRollSides(operand: String)
  case overflowAddition(operandLeft: String, operandRight: String)
  case overflowDivision(operandLeft: String, operandRight: String)
  case overflowMultiplication(operandLeft: String, operandRight: String)
  case overflowNegation(operand: String)
  case overflowSubtraction(operandLeft: String, operandRight: String)
}
