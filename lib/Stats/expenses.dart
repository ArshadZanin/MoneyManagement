import 'package:flutter/material.dart';
import 'package:money_management/db/database_transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  Map<String, double> totalData = {};

  DatabaseHandler handler = DatabaseHandler();

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      totalData = await handler.retrieveWithCategory("expense");
      debugPrint('$totalData');
      for(int i = 0; i < totalData.length; i++){
        pieData.add(_PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      setState(() {});
    });
  }

  List<_PieData> pieData = [
    // _PieData('Jan', 5,'card'),
    // _PieData('Feb', 20,'food'),
    // _PieData('Mar', 14,'dress'),
    // _PieData('Apr', 32,'expenditure'),
    // _PieData('May', 24,'shelter')
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      body: Column(
        children: [
          Center(
              child: pieData.isNotEmpty ?
              SfCircularChart(
                  title: ChartTitle(text: 'Expense Stats by category'),
                  legend: Legend(isVisible: true,backgroundColor: Colors.white),
                  series: <PieSeries<_PieData, String>>[
                    PieSeries<_PieData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: pieData,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataLabelMapper: (_PieData data, _) => "${data.yData}",
                        dataLabelSettings: const DataLabelSettings(isVisible: true)),
                  ]
              ) :
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: const Center(
                  child: Text("No data available!!", style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),
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