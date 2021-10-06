import 'package:flutter/material.dart';
import 'package:money_management/db/database_expense_category.dart';
import 'package:money_management/db/database_income_category.dart';
import 'package:money_management/db/database_transaction.dart';
import 'package:money_management/settings/configure.dart';
import 'package:money_management/settings/help.dart';

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
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF020925),
        title: const Text("Settings"),
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
                    icon: const Icon(Icons.settings_outlined,color: Colors.grey,
                    ),
                ),
                const Center(child: Text("Configuration",style: TextStyle(color: Colors.grey),)),
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

                              User student = User(
                                  trans: 'income',
                                  date: 'Jan 01, 2015',
                                  account: 'Assets',
                                  category: 'Cash',
                                  amount: '0',
                                  note: 'it not affect the user');
                              User student1 = User(
                                  trans: 'expense',
                                  date: 'Jan 01, 2015',
                                  account: 'Liabilities',
                                  category: 'Food',
                                  amount: '0',
                                  note: 'it not affect the user');

                              List<User> listOfUser = [student,student1];
                              DatabaseHandler db = DatabaseHandler();
                              await db.insertUser(listOfUser);

                              IncomeCategoryDb user1 = IncomeCategoryDb(incomeCategory: 'Cash');
                              List<IncomeCategoryDb> listofIncomeCategoryDb = [user1];
                              DatabaseHandlerIncomeCategory db1 = DatabaseHandlerIncomeCategory();
                              await db1.insertIncomeCategory(listofIncomeCategoryDb);

                              ExpenseCategoryDb user2 = ExpenseCategoryDb(expenseCategory: 'Food');
                              List<ExpenseCategoryDb> listofExpenseCategoryDb = [user2];
                              DatabaseHandlerExpenseCategory db2 = DatabaseHandlerExpenseCategory();
                              await db2.insertExpenseCategory(listofExpenseCategoryDb);

                              Navigator.pop(context, 'OK');
                              },
                            child: const Text('OK',style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings_backup_restore,color: Colors.grey,),),
                const Center(child: Text("Reset App",style: TextStyle(color: Colors.grey),)),
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
                  icon: const Icon(Icons.help,color: Colors.grey,),),
                const Center(child: Text("Help",style: TextStyle(color: Colors.grey),)),
              ],
            ),

          ]
      ),
    );
  }
}
