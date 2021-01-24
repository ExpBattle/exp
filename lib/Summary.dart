import 'package:exp/Expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';

class Summary {
  var expenses = <Expense>[];
  var colorMap = new Map<String, Color>();
  var totalExpenses = 0.0;

  void addExpense(Expense newExpense) {
    expenses.add(newExpense);
    totalExpenses += newExpense.amount;
    _setColor(newExpense.type);
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

  void _setColor(String type) {
    RandomColor _randomColor = RandomColor();
    Color newC = _randomColor.randomColor(
      colorBrightness: ColorBrightness.dark,
    );
    colorMap.putIfAbsent(type, () => newC);
  }

  Widget buildChart() {
    return Container(
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 40,
          sections: _buildSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    Expense expense = new Expense();
    List<PieChartSectionData> sections = new List();
    for (String type in expense.possibleTypes) {
      var percentage = _getPercentage(type);
      if (percentage > 0.0) {
        sections.add(PieChartSectionData(
            color: _getColorForType(type),
            value: percentage,
            title: ((percentage.toInt() <= 5)
                ? ""
                : (percentage.toInt().toString() + "%")),
            radius: 50,
            titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff))));
      }
    }

    return sections;
  }

  double _getPercentage(String type) {
    double typeTotal = 0;
    for (Expense expense in expenses) {
      if (expense.type == type) {
        typeTotal += expense.amount;
      }
    }
    return (typeTotal / totalExpenses) * 100;
  }

  Color _getColorForType(String type) {
    for (String s in colorMap.keys) {
      if (s == type) {
        return colorMap[s];
      }
    }
    return null;
  }
}
