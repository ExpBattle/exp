import 'package:exp/Expense.dart';

class Summary {
  var expenses = <Expense>[];
  var totalExpenses = 0.0;

  void addExpense(Expense newExpense) {
    expenses.add(newExpense);
    totalExpenses += newExpense.amount;
  }

  void removeExpense(Expense expenseToRemove) {
    expenses.remove(expenseToRemove);
    totalExpenses -= expenseToRemove.amount;
  }

  List getAllExpenses() {
    return expenses;
  }

  double getTotalExpenses() {
    return totalExpenses;
  }
}
