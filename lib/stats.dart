import 'package:flutter/material.dart';
import 'package:money_management/Stats/expenses.dart';
import 'package:money_management/Stats/income.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> with SingleTickerProviderStateMixin {
  TabController? controller;
  String _value = "Monthly";

  void _value1(String value){
    setState(() {
      _value = value;
    });
  }

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        title: const Text("SEP 2021"),
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
                items: <String>['Total', 'Weekly', 'Monthly', 'Annually','Period'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: const TextStyle(color: Colors.white),),
                  );
                }).toList(),
                onChanged: (value) {_value1(value!);},
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
        children: const [
          Income(),
          Expenses()
        ],
      ),
    );
  }
}
