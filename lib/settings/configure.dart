import 'package:flutter/material.dart';
import 'package:money_management/home.dart';
import 'package:money_management/main.dart';
import 'package:money_management/settings.dart';
import 'package:money_management/settings/expense_category.dart';
import 'package:money_management/settings/income_category.dart';

class Configure extends StatefulWidget {
  const Configure({Key? key}) : super(key: key);

  @override
  _ConfigureState createState() => _ConfigureState();
}

class _ConfigureState extends State<Configure> {

  bool reminder = false;
  bool finger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        title: const Text("Configuration"),
        backgroundColor: const Color(0xFF13254C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyApp()));
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5,),
          const Text("Category",style: TextStyle(color: Colors.white54,fontSize: 15),),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF13254C),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: (){
                      debugPrint("Income Category Settings");
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const IncomeCategory()));
                    },
                    child: const Text("Income Category Settings",style: TextStyle(color: Colors.white,fontSize: 17),),
                ),
                TextButton(
                  onPressed: (){
                    debugPrint("Expenses Category Settings");
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseCategory()));
                  },
                  child: const Text("Expenses Category Settings",style: TextStyle(color: Colors.white,fontSize: 17),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF13254C),
            child: Column(
              children: [
                SwitchListTile(
                  inactiveTrackColor: Colors.red,
                  inactiveThumbColor: Colors.blueGrey[800],
                  activeTrackColor: Colors.blueGrey[800],
                  title: const Text("Fingerprint Lock", style: TextStyle(color: Colors.white,fontSize: 20)),
                  value: finger,
                  onChanged: (bool newValue) => setState(() {
                    finger == false ? finger = true : finger = false;
                  }),
                ),
                SwitchListTile(
                  inactiveTrackColor: Colors.red,
                  inactiveThumbColor: Colors.blueGrey[800],
                  activeTrackColor: Colors.blueGrey[800],
                  title: const Text("Set Reminder?", style: TextStyle(color: Colors.white,fontSize: 20)),
                  value: reminder,
                  onChanged: (bool newValue) => setState(() {
                    reminder == false ? reminder = true : reminder = false;
                  }),
                ),
                reminder == false ? Container() : FlatButton(
                  color: const Color(0xFF13254C),
                    onPressed: (){
                    debugPrint("reminder");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                      Text("Time?",style: TextStyle(color: Colors.white,fontSize: 20),),
                      SizedBox(width: 10,),
                      Text("10.00 pm",style: TextStyle(color: Colors.white54,fontSize: 20),)
                    ],),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
