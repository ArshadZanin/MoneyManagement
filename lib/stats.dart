import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/database_transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:money_management/color/app_color.dart' as app_color;


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
  String _value = "Monthly";

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

      ///take database list to here///
      List<Map<String, Object?>> databaseList = await handler.retrieveUsersDatabase();
      debugPrint("hello : $databaseList");


      ///income today///
      Set<String> categorySet = {};
      for(int i = 0; i < databaseList.length; i++){
        if(databaseList[i]["trans"] == "income"){
          String data = databaseList[i]["category"].toString();
          categorySet.add(data);
        }
      }
      List<String> listCategory = [...categorySet.toList()];
      Map<String, double> categoryAmount = {};
      for(int i = 0; i < categorySet.length; i++){
        double total = 0;
        for(int j = 0; j < databaseList.length; j++ ){
          if(databaseList[j]['date'] == _dateToday && databaseList[j]['category'] == listCategory[i]){
            double value = double.parse(databaseList[j]["amount"].toString());
            total = total + value;
          }
        }
        categoryAmount.addAll({listCategory[i]: total});
      }
      for (int i = 0; i < categoryAmount.length; i++) {
        pieDataTodayIncome.add(
            _PieData(categoryAmount.keys.toList()[i], categoryAmount.values.toList()[i]));
      }

      ///expense today///
      Set<String> categorySet1 = {};
      for(int i = 0; i < databaseList.length; i++){
        if(databaseList[i]["trans"] == "expense"){
          String data = databaseList[i]["category"].toString();
          categorySet1.add(data);
        }
      }
      List<String> listCategory1 = [...categorySet1.toList()];
      Map<String, double> categoryAmount1 = {};
      for(int i = 0; i < categorySet1.length; i++){
        double total = 0;
        for(int j = 0; j < databaseList.length; j++ ){
          if(databaseList[j]['date'] == _dateToday && databaseList[j]['category'] == listCategory1[i]){
            double value = double.parse(databaseList[j]["amount"].toString());
            total = total + value;
          }
        }
        categoryAmount1.addAll({listCategory1[i]: total});
      }
      for (int i = 0; i < categoryAmount1.length; i++) {
        pieDataTodayExpense.add(
            _PieData(categoryAmount1.keys.toList()[i], categoryAmount1.values.toList()[i]));
      }

      ///income month///
      Set<String> categorySet2 = {};
      for(int i = 0; i < databaseList.length; i++){
        if(databaseList[i]["trans"] == "income"){
          String data = databaseList[i]["category"].toString();
          categorySet2.add(data);
        }
      }
      List<String> listCategory2 = [...categorySet2.toList()];
      Map<String, double> categoryAmount2 = {};
      for(int i = 0; i < categorySet2.length; i++){
        double total = 0;
        for(int j = 0; j < databaseList.length; j++ ){
          String dateIs = databaseList[j]['date'].toString().substring(0, databaseList[j]['date'].toString().length - 9);
          String dateLast = databaseList[j]['date'].toString().substring(8, databaseList[j]['date'].toString().length);
          if(dateIs == _dateMonth && dateLast == _dateYear && databaseList[j]['category'] == listCategory2[i]){
            double value = double.parse(databaseList[j]["amount"].toString());
            total = total + value;
          }
        }
        categoryAmount2.addAll({listCategory2[i]: total});
      }
      for (int i = 0; i < categoryAmount2.length; i++) {
        pieDataMonthlyIncome.add(
            _PieData(categoryAmount2.keys.toList()[i], categoryAmount2.values.toList()[i]));
      }


      ///expense month///
      Set<String> categorySet3 = {};
      for(int i = 0; i < databaseList.length; i++){
        if(databaseList[i]["trans"] == "expense"){
          String data = databaseList[i]["category"].toString();
          categorySet3.add(data);
        }
      }
      List<String> listCategory3 = [...categorySet3.toList()];
      Map<String, double> categoryAmount3 = {};
      for(int i = 0; i < categorySet3.length; i++){
        double total = 0;
        for(int j = 0; j < databaseList.length; j++ ){
          String dateIs = databaseList[j]['date'].toString().substring(0, databaseList[j]['date'].toString().length - 9);
          String dateLast = databaseList[j]['date'].toString().substring(8, databaseList[j]['date'].toString().length);
          if(dateIs == _dateMonth && dateLast == _dateYear && databaseList[j]['category'] == listCategory3[i]){
            double value = double.parse(databaseList[j]["amount"].toString());
            total = total + value;
          }
        }
        categoryAmount3.addAll({listCategory3[i]: total});
      }
      for (int i = 0; i < categoryAmount3.length; i++) {
        pieDataMonthlyExpense.add(
            _PieData(categoryAmount3.keys.toList()[i], categoryAmount3.values.toList()[i]));
      }

      ///income year///
      Set<String> categorySet4 = {};
      for(int i = 0; i < databaseList.length; i++){
        if(databaseList[i]["trans"] == "income"){
          String data = databaseList[i]["category"].toString();
          categorySet4.add(data);
        }
      }
      List<String> listCategory4 = [...categorySet4.toList()];
      Map<String, double> categoryAmount4 = {};
      for(int i = 0; i < categorySet4.length; i++){
        double total = 0;
        for(int j = 0; j < databaseList.length; j++ ){
          String dateIs = databaseList[j]['date'].toString().substring(8, databaseList[j]['date'].toString().length);
          debugPrint("Date is : $dateIs");
          if(dateIs == _dateYear && databaseList[j]['category'] == listCategory4[i]){
            double value = double.parse(databaseList[j]["amount"].toString());
            total = total + value;
          }
        }
        categoryAmount4.addAll({listCategory4[i]: total});
      }
      for (int i = 0; i < categoryAmount4.length; i++) {
        pieDataAnnuallyIncome.add(
            _PieData(categoryAmount4.keys.toList()[i], categoryAmount4.values.toList()[i]));
      }

      ///expense year///
      Set<String> categorySet5 = {};
      for(int i = 0; i < databaseList.length; i++){
        if(databaseList[i]["trans"] == "expense"){
          String data = databaseList[i]["category"].toString();
          categorySet5.add(data);
        }
      }
      List<String> listCategory5 = [...categorySet5.toList()];
      Map<String, double> categoryAmount5 = {};
      for(int i = 0; i < categorySet5.length; i++){
        double total = 0;
        for(int j = 0; j < databaseList.length; j++ ){
          String dateIs = databaseList[j]['date'].toString().substring(8, databaseList[j]['date'].toString().length);
          if(dateIs == _dateYear && databaseList[j]['category'] == listCategory5[i]){
            double value = double.parse(databaseList[j]["amount"].toString());
            total = total + value;
          }
        }
        categoryAmount5.addAll({listCategory5[i]: total});
      }
      for (int i = 0; i < categoryAmount5.length; i++) {
        pieDataAnnuallyExpense.add(
            _PieData(categoryAmount5.keys.toList()[i], categoryAmount5.values.toList()[i]));
      }

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
      return Text(_dateMonth);
    } else if (_value == 'Annually') {
      return Text(_dateYear);
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
      backgroundColor: app_color.back,
      appBar: AppBar(
        title: _textTitle(),
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: app_color.widget,
        actions: [
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              buttonColor: Colors.black,
              disabledColor: Colors.black,
              focusColor: Colors.black,
              highlightColor: Colors.black,
              hoverColor: Colors.black,
              splashColor: Colors.black,
              minWidth: 50,
              height: 20,
              alignedDropdown: true,
              child: DropdownButton<String>(
                iconSize: 15,
                value: _value,
                borderRadius: BorderRadius.circular(10.0),
                dropdownColor: app_color.back,
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
                      style: const TextStyle(color: app_color.text),
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
          unselectedLabelColor: Colors.black,
          labelColor: Colors.red,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const SizedBox(height: 30,),

              const Center(
                child: Text("Income Stats by category",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              ),

              //Initialize the chart widget
              Center(
                child: pieData1().isNotEmpty ?
                SfCircularChart(
                        // title: ChartTitle(text: 'Income Stats by category'),
                        legend: Legend(
                          // alignment: ChartAlignment.near,
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
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 30,),const SizedBox(height: 30,),
            ],
          ),

          ///expense///


          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const SizedBox(height: 30,),

              const Center(
                child: Text("Expense Stats by category",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              ),

              Center(
                child: pieData2().isNotEmpty ?
                SfCircularChart(
                        // title: ChartTitle(text: 'Expense Stats by category'),
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
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 30,),const SizedBox(height: 30,),
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
