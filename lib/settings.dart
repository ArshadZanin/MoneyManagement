import 'package:flutter/material.dart';
import 'package:money_management/db/database_expense_category.dart';
import 'package:money_management/db/database_income_category.dart';
import 'package:money_management/db/database_transaction.dart';
import 'package:money_management/onboard_anime/onboard_01.dart';
import 'package:money_management/settings/configure.dart';
import 'package:money_management/settings/help.dart';
import 'package:money_management/color/app_color.dart' as app_color;
import 'package:money_management/splash%20screen/splash_screen.dart';

import 'db/database_passcode.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  DatabaseHandler handler = DatabaseHandler();
  DatabaseHandlerIncomeCategory handler1 = DatabaseHandlerIncomeCategory();
  DatabaseHandlerExpenseCategory handler2 = DatabaseHandlerExpenseCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_color.back,
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.note),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen1Sub()));
          },
          )
        ],
        elevation: 0.2,
        backgroundColor: app_color.widget,
        title: const Text("Settings"),
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 20,),
                IconButton(
                    onPressed:(){
                      debugPrint("Configuration");
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Configure()));
                    },
                    icon: const Icon(Icons.settings_outlined,color: Colors.black,
                    ),
                ),
                const Center(child: Text("Configuration",style: TextStyle(color: Colors.black),)),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20,),
                IconButton(
                  onPressed:(){
                    debugPrint("Reset App");
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('it will delete permanently all data....'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              handler.deleteDb();
                              handler1.deleteDb();
                              handler2.deleteDb();


                              Navigator.pop(context, 'OK');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Onboard()));
                              },
                            child: const Text('OK',style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings_backup_restore,color: Colors.black,),),
                const Center(child: Text("Reset App",style: TextStyle(color: Colors.black),)),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20,),
                IconButton(
                  onPressed:(){
                    debugPrint("Helppp");
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Help()));
                  },
                  icon: const Icon(Icons.help,color: Colors.black,),),
                const Center(child: Text("Help",style: TextStyle(color: Colors.black),)),
              ],
            ),

          ]
      ),
    );
  }
}
