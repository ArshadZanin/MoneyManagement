import 'package:flutter/material.dart';
import 'package:money_management/db/database_transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Income extends StatefulWidget {
  String? value;
  Income(this.value, {Key? key}) : super(key: key);

  @override
  _IncomeState createState() => _IncomeState(value!);
}

class _IncomeState extends State<Income> {
  String? _value;
  _IncomeState(this._value);


  String? value;

  DatabaseHandler handler = DatabaseHandler();
  Map<String, double> totalData = {};

  List<_PieData> pieData1(){
    debugPrint(_value);
    if(_value == "Total"){
      return pieData;
    }else{
      return pieDataMonthly;
    }
  }

  @override
  void initState() {
    super.initState();
    value = _value!;
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      totalData = await handler.retrieveWithCategory("income");
      for(int i = 0; i < totalData.length; i++){
        pieData.add(_PieData(totalData.keys.toList()[i], totalData.values.toList()[i]));
      }
      setState(() {});
    });
  }


  List<_PieData> pieData = [
    // _PieData('Cash', 5),
    // _PieData('Card', 20),
    // _PieData('Debit', 14),
    // _PieData('Income', 32),
    // _PieData('Gift', 24)
  ];

  List<_PieData> pieDataMonthly = [
    _PieData('Cash', 5),
    _PieData('Card', 20),
    _PieData('Debit', 14),
    _PieData('Income', 32),
    _PieData('Gift', 24)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
        body: Column(
          children: [
          //Initialize the chart widget
          Center(
              child: pieData.isNotEmpty ?
              SfCircularChart(
                  title: ChartTitle(text: 'Amounts by Category'),
                  legend: Legend(isVisible: true,backgroundColor: Colors.white),
                  series: <PieSeries<_PieData, String>>[
                    PieSeries<_PieData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: pieData1(),
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
        ],),
    );
  }
}
class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}