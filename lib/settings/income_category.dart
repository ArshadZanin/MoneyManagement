import 'package:flutter/material.dart';
import 'package:money_management/db/database_income_category.dart';
import 'package:money_management/settings/add_income.dart';
import 'package:money_management/settings/configure.dart';
import 'package:money_management/color/app_color.dart' as app_color;


class IncomeCategory extends StatefulWidget {
  const IncomeCategory({Key? key}) : super(key: key);

  @override
  State<IncomeCategory> createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {

  late DatabaseHandlerIncomeCategory handler;

  int delete = 0;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandlerIncomeCategory();
    handler.initializeDB().whenComplete(() async {
      // await this.addUsers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_color.back,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF020925),
        title: const Text("Income Category Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Configure()));
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              if(delete == 0){
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Swap the data right to left to delete....'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: (){
                            setState(() {
                              delete = 0;
                            });
                            Navigator.pop(context, 'Cancel');
                            },
                          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK',style: TextStyle(color: Colors.red),),
                        ),
                      ],
                    ),);
              }
              setState(() {
                delete == 0 ? delete = 1 : delete = 0;
              });
              debugPrint("delete clicked $delete");
            },
            icon: delete == 0 ?
            const Icon(
              Icons.delete_outlined,
              color: Colors.white,
            ):
            const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddIncomeData()));
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
        builder: (BuildContext context, AsyncSnapshot<List<IncomeCategoryDb>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: delete == 1 ? DismissDirection.endToStart : DismissDirection.none,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data![index].id!),
                  onDismissed: (DismissDirection direction) async {
                    await handler.deleteIncomeCategory(snapshot.data![index].id!);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      tileColor: const Color(0xFFffffff),
                      contentPadding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                      title: Text(snapshot.data![index].incomeCategory!,style: const TextStyle(color: Colors.black),),
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
      //       title: Text("Accounts",style: TextStyle(color: Colors.white),),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xFF13254C),
      //       title: Text("Card",style: TextStyle(color: Colors.white),),
      //     ),
      //   ],
      // ),
    );
  }
}
