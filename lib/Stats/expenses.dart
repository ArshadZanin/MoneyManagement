import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  List<_ExpenseData> data = [
    _ExpenseData('Jan', 5),
    _ExpenseData('Feb', 20),
    _ExpenseData('Mar', 14),
    _ExpenseData('Apr', 32),
    _ExpenseData('May', 24)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
          primaryXAxis: CategoryAxis(),
      // Chart title
      title: ChartTitle(text: 'Expense analysis'),
      // Enable legend
      legend: Legend(isVisible: true),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<_ExpenseData, String>>[
        LineSeries<_ExpenseData, String>(
          dataSource: data,
          xValueMapper: (_ExpenseData expense, _) => expense.year,
          yValueMapper: (_ExpenseData expense, _) => expense.expense,
          name: 'Expense',
          // Enable data label
          dataLabelSettings: const DataLabelSettings(isVisible: true),),
      ],),
    ]));
  }
}
class _ExpenseData {
  _ExpenseData(this.year, this.expense);

  final String year;
  final double expense;
}