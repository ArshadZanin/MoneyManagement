import 'package:flutter/material.dart';
import 'package:money_management/Stats/expenses.dart';
import 'package:money_management/Stats/income.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/database_transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> with SingleTickerProviderStateMixin {
  late final _date = DateFormat('MMM yyyy').format(DateTime.now());
  late final _dateToday = DateFormat('MMM dd, yyyy').format(DateTime.now());
  late final _dateYear = DateFormat('yyyy').format(DateTime.now());
  late final _dateMonth = DateFormat('MMM').format(DateTime.now());

  TabController? controller;
  String _value = "Today";

  void _value1(String value) {
    setState(() {
      _value = value;
    });
  }

  /// income///

  DatabaseHandler handler = DatabaseHandler();
  Map<String, double> totalData = {};

  List<_PieData> pieData1() {
    debugPrint(_value);
    if (_value == "Total") {
      return pieDataTotalIncome;
    }else if(_value == "Today"){
      return pieDataTodayIncome;
    }else if(_value == "Annually"){
      return pieDataAnnuallyIncome;
    } else {
      return pieDataMonthlyIncome;
    }
  }

  List<_PieData> pieData2() {
    debugPrint(_value);
    if (_value == "Total") {
      return pieDataTotalExpense;
    }else if(_value == "Today"){
      return pieDataTodayExpense;
    }else if(_value == "Annually"){
      return pieDataAnnuallyExpense;
    } else {
      return pieDataMonthlyExpense;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      ///income total///
      totalData = await handler.retrieveWithCategory("income");
      for (int i = 0; i < totalData.length; i++) {
        pieDataTotalIncome.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///expense total///
      totalData = await handler.retrieveWithCategory("expense");
      for (int i = 0; i < totalData.length; i++) {
        pieDataTotalExpense.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///income today///
      totalData = await handler.retrieveWithCategoryToday("income",_dateToday);
      for (int i = 0; i < totalData.length; i++) {
        pieDataTodayIncome.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///expense today///
      totalData = await handler.retrieveWithCategoryToday("expense",_dateToday);
      for (int i = 0; i < totalData.length; i++) {
        pieDataTodayExpense.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///income year///
      totalData = await handler.retrieveWithCategoryYear("income",_dateYear);
      for (int i = 0; i < totalData.length; i++) {
        pieDataAnnuallyIncome.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///expense year///
      totalData = await handler.retrieveWithCategoryYear("expense",_dateYear);
      for (int i = 0; i < totalData.length; i++) {
        pieDataAnnuallyExpense.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///income month///
      totalData = await handler.retrieveWithCategoryMonth("income",_dateMonth,_dateYear);
      for (int i = 0; i < totalData.length; i++) {
        pieDataMonthlyIncome.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      ///expense month///
      totalData = await handler.retrieveWithCategoryMonth("expense",_dateMonth,_dateYear);
      for (int i = 0; i < totalData.length; i++) {
        pieDataMonthlyExpense.add(
            _PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }

      setState(() {});
    });
  }

  List<_PieData> pieDataTotalIncome = [];
  List<_PieData> pieDataTotalExpense = [];

  List<_PieData> pieDataTodayIncome = [];
  List<_PieData> pieDataTodayExpense = [];

  // List<_PieData> pieDataWeeklyIncome = [];
  // List<_PieData> pieDataWeeklyExpense = [];

  List<_PieData> pieDataMonthlyIncome = [];
  List<_PieData> pieDataMonthlyExpense = [];

  List<_PieData> pieDataAnnuallyIncome = [];
  List<_PieData> pieDataAnnuallyExpense = [];


  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Widget _textTitle() {
    if (_value == 'Monthly') {
      return Text(_dateYear);
    } else if (_value == 'Annually') {
      return const Text("Annually");
    }
    // else if (_value == 'Weekly') {
    //   return Text(_date);
    // }
    else if (_value == "Today") {
      return Text(_dateToday);
    } else {
      return const Text("Total");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        title: _textTitle(),
        backgroundColor: const Color(0xFF13254C),
        actions: [
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              minWidth: 50,
              height: 20,
              alignedDropdown: true,
              child: DropdownButton<String>(
                iconSize: 15,
                value: _value,
                borderRadius: BorderRadius.circular(10.0),
                dropdownColor: Colors.blueGrey[900],
                items: <String>[
                  'Today',
                  // 'Weekly',
                  'Monthly',
                  'Annually',
                  'Total'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _value1(value!);
                },
              ),
            ),
          )
        ],
        bottom: TabBar(
          controller: controller,
          indicatorWeight: 2.0,
          indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: Colors.red[900],
          tabs: const [
            Tab(
              text: "Income",
            ),
            Tab(
              text: "Expense",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [

          ///income///


          Column(
            children: [
              //Initialize the chart widget
              Center(
                child: pieData1().isNotEmpty ?
                SfCircularChart(
                        title: ChartTitle(text: 'Amounts by Category'),
                        legend: Legend(
                            isVisible: true, backgroundColor: Colors.white),
                        series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                                explode: true,
                                explodeIndex: 0,
                                dataSource: pieData1(),
                                xValueMapper: (_PieData data, _) => data.xData,
                                yValueMapper: (_PieData data, _) => data.yData,
                                dataLabelMapper: (_PieData data, _) =>
                                    "${data.yData}",
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true)),
                          ])
                    : Container(
                        padding: const EdgeInsets.only(top: 100),
                        child: const Center(
                          child: Text(
                            "No data available!!",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
              ),
            ],
          ),

          ///expense///


          Column(
            children: [
              Center(
                child: pieData2().isNotEmpty ?
                SfCircularChart(
                        title: ChartTitle(text: 'Sales by sales person'),
                        legend: Legend(
                            isVisible: true, backgroundColor: Colors.white),
                        series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                                explode: true,
                                explodeIndex: 0,
                                dataSource: pieData2(),
                                xValueMapper: (_PieData data, _) => data.xData,
                                yValueMapper: (_PieData data, _) => data.yData,
                                dataLabelMapper: (_PieData data, _) =>
                                    "${data.yData}",
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true)),
                          ])
                    : Container(
                        padding: const EdgeInsets.only(top: 100),
                        child: const Center(
                          child: Text(
                            "No data available!!",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
