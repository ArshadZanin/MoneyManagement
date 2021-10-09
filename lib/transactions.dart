import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/database_transaction.dart';
import 'package:money_management/color/app_color.dart' as app_color;



class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {


  double? income = 0.0;
  double? expense = 0.0;
  double? balance = 0.0;



  late var _date = DateFormat('MMM dd, yyyy').format(DateTime.now());
  final _dateController = TextEditingController(text: DateFormat('MMM dd, yyyy').format(DateTime.now()));

  DatabaseHandler handler = DatabaseHandler();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {

      handler.retrieveWithCategory("income");

      String? income12 = await handler.calculateIncomeTotal();
      income = double.parse(income12!);

      String? expense12 = await handler.calculateExpenseTotal();
      expense = double.parse(expense12!);

      balance = (income! - expense!);
      // await this.addUsers();
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: app_color.back,
      appBar: AppBar(
        backgroundColor: app_color.appBar,
        title: const Text(
          "Money Management",
          style: TextStyle(color: app_color.text, letterSpacing: 1),
        ),
        centerTitle: true,
        elevation: 0.2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10,),
            Material(
              elevation: 20,
              shadowColor: const Color(0xff4700fd),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width - 12,
                height: MediaQuery.of(context).size.height / 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: app_color.widget,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // Alignment(0.8, 0.8), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color(0xff4700fd),
                      Color(0xff541ce5),
                      Color(0xff6325ff)
                    ], // red to yellow
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    controller: _dateController,
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now(),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          _dateController.text =
                              DateFormat('MMM dd, yyyy').format(selectedDate);
                          _date = _dateController.text;
                          setState(() {

                          });

                        }
                      });
                    },
                    style: const TextStyle(fontSize: 15,color: Colors.white),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Date is Required';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _date = value!;
                    },
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  elevation: 10,
                  shadowColor: const Color(0xff0AF439),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: MediaQuery.of(context).size.height / 9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: app_color.widget,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end:
                        Alignment(0.8, 0.8), // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Color(0xff169e3c),
                          Color(0xff0AF439)
                        ], // red to yellow
                        tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "INCOME",
                            style: TextStyle(
                              color: app_color.text,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "+$income",
                            style: const TextStyle(
                              color: Color(0xFFffffff),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 10,),

                Material(
                  elevation: 10,
                  shadowColor: const Color(0xfff40a0a),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: MediaQuery.of(context).size.height / 9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: app_color.widget,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end:
                        Alignment(0.8, 0.8), // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Color(0xff9e1616),
                          Color(0xfff40a0a)
                        ], // red to yellow
                        tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "EXPENSE",
                            style: TextStyle(
                              color: app_color.text,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "-$expense",
                            style: const TextStyle(
                              color: Color(0xFFffffff),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 10,),

                Material(
                  elevation: 10,
                  shadowColor: const Color(0xff0a68f4),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: MediaQuery.of(context).size.height / 9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: app_color.widget,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end:
                        Alignment(0.8, 0.8), // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Color(0xff163d9e),
                          Color(0xff0a68f4)
                        ], // red to yellow
                        tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "BALANCE",
                            style: TextStyle(
                              color: app_color.text,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "${income! - expense!}",
                            style: const TextStyle(
                              color: Color(0xFFffffff),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Transactions",
              style: TextStyle(color: app_color.text),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: FutureBuilder(
                future: handler.retrieveUsers(),
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if(snapshot.data![index].trans == 'income'){
                        //   income = income! + double.parse(snapshot.data![index].amount.toString());
                        // }else{
                        //   expense = expense! + double.parse(snapshot.data![index].amount.toString());
                        // }
                        index = snapshot.data!.length - index -1;
                        return Dismissible(
                          direction: DismissDirection.none,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: const Icon(Icons.delete_forever),
                          ),
                          key: ValueKey<int>(snapshot.data![index].id!),
                          onDismissed: (DismissDirection direction) async {
                            await handler.deleteUser(snapshot.data![index].id!);
                            setState(() {
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: snapshot.data![index].date == _dateController.text ?
                          Card(
                            color: app_color.list,
                            child:
                            ListTile(
                              onLongPress: (){
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text('Date: ${snapshot.data![index].date}\nTransaction: ${snapshot.data![index].trans}\nAccount: ${snapshot.data![index].account}\nCategory: ${snapshot.data![index].category}\nNote: ${snapshot.data![index].note}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    content: Text(
                                      "Amount: ${snapshot.data![index].amount.toString()}",
                                      style: snapshot.data![index].trans == 'income' ?
                                      const TextStyle(color: Colors.green,fontSize: 20) :
                                      const TextStyle(color: Colors.red,fontSize: 20),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context, 'go back');
                                        },
                                        child: const Text('go back',style: TextStyle(color: Colors.blue),),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(9.0),
                              title: Text(
                                "${snapshot.data![index].category!} \n ${snapshot.data![index].date}",
                                style: const TextStyle(color: app_color.text),
                              ),
                              subtitle: Text(
                                snapshot.data![index].amount.toString(),
                                textAlign: TextAlign.end,
                                style: snapshot.data![index].trans == 'income' ?
                                const TextStyle(color: Colors.green) :
                                const TextStyle(color: Colors.red),
                              ),
                            ),
                          ) :
                          Container(),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            //no data

            // child: const Center(
            //   child: Text("No Data Available",style: TextStyle(color: Colors.grey,fontSize: 15),),
            // ),
          ],
        ),
      ),
    );
  }
}
