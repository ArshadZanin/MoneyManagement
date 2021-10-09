import 'package:flutter/material.dart';
import 'package:money_management/accounts.dart';
import 'package:money_management/transaction/add_transaction.dart';
import 'package:money_management/settings.dart';
import 'package:money_management/stats.dart';
import 'package:money_management/transactions.dart';
import 'package:money_management/color/app_color.dart' as app_color;



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  TabController? controller;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
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
      extendBody: true,
      backgroundColor: app_color.back,
      body: TabBarView(
        controller: controller,
        children: const [
          Transaction(),
          Accounts(),
          Stats(),
          Settings()
        ],
      ),
      bottomNavigationBar: Container(
        color: app_color.widget,
        child: TabBar(
          controller: controller,
          indicatorWeight: 2.0,
          labelColor: Colors.red,
          unselectedLabelStyle: const TextStyle(backgroundColor: Colors.red),
          unselectedLabelColor: Colors.grey,
          indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: const Color(0xFFFCC3C3),
          tabs: const [
            Tab(
              icon: Icon(Icons.compare_arrows),
            ),
            Tab(
              icon: Icon(Icons.book_outlined),
            ),
            Tab(
              iconMargin: EdgeInsets.only(right: 0.0),
              icon: Icon(Icons.bar_chart_outlined),
            ),
            Tab(
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          backgroundColor: app_color.widget,
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 32.0,
            ),
          ),
          onPressed: () {
            debugPrint("Add Data Clicked");
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTrans()));
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
