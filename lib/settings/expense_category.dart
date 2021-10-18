import 'package:flutter/material.dart';
import 'package:money_management/db/database_expense_category.dart';
import 'package:money_management/settings/add_expense.dart';
import 'package:money_management/settings/configure.dart';
import 'package:money_management/color/app_color.dart' as app_color;


class ExpenseCategory extends StatefulWidget {
  const ExpenseCategory({Key? key}) : super(key: key);

  @override
  State<ExpenseCategory> createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {

  late DatabaseHandlerExpenseCategory handler;


  @override
  void initState() {
    super.initState();
    handler = DatabaseHandlerExpenseCategory();
    handler.initializeDB().whenComplete(() async {
      // await this.addUsers();
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Configure()));
        return true;
      },
      child: Scaffold(
        backgroundColor: app_color.back,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF020925),
          title: const Text("Expense Category Settings"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Configure()));
            },
          ),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExpenseData()));
                debugPrint("options clicked");
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: handler.retrieveUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<ExpenseCategoryDb>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text("Are you sure you wish to delete this item?"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text("DELETE",style: TextStyle(color: Colors.red),)
                              ),
                              FlatButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("CANCEL"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Icon(Icons.delete_forever),
                    ),
                    key: ValueKey<int>(snapshot.data![index].id!),
                    onDismissed: (DismissDirection direction) async {
                      await handler.deleteExpenseCategory(snapshot.data![index].id!);
                      setState(() {
                        snapshot.data!.remove(snapshot.data![index]);
                      });
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        tileColor: const Color(0xFFffffff),
                        contentPadding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                        title: Text(snapshot.data![index].expenseCategory!,style: const TextStyle(color: Colors.black),),
                        // onLongPress: () {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           StudentForm(student: snapshot.data![index]),
                        //     ),
                        //   );
                        // },
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        // body: Column(
        //   children: const [
        //     ListTile(
        //       tileColor: Color(0xFF13254C),
        //       title: Text("Food",style: TextStyle(color: Colors.white),),
        //     ),
        //     ListTile(
        //       tileColor: Color(0xFF13254C),
        //       title: Text("Transportation",style: TextStyle(color: Colors.white),),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
