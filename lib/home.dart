import 'package:flutter/material.dart';
import 'package:money_management/accounts.dart';
import 'package:money_management/transaction/add_transaction.dart';
import 'package:money_management/settings.dart';
import 'package:money_management/stats.dart';
import 'package:money_management/transactions.dart';


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
      backgroundColor: const Color(0xFF020925),
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
        color: const Color(0xFF13254C),
        child: TabBar(
          controller: controller,
          indicatorWeight: 2.0,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.white,
          indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: const Color(0xFF13254C),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF13254C),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 32.0,
          ),
        ),
        onPressed: () {
          debugPrint("Add Data Clicked");
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTrans()));
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(22.0),
          ),
        ),
      ),
    );
  }
}
