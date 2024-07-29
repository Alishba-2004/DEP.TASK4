import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseChart extends StatelessWidget {
  final List<charts.Series<Expense, String>> seriesList; // Update the type here
  final bool animate;

  ExpenseChart(this.seriesList, {required this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}

class Expense {
  final String category;
  final double amount;

  Expense(this.category, this.amount);
}