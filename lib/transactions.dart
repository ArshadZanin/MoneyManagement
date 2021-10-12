import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'db/database_transaction.dart';
import 'package:money_management/color/app_color.dart' as app_color;
import 'package:money_management/settings/configure.dart';



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
        actions: [
          SizedBox(
            width: 100,
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
                style: const TextStyle(fontSize: 15,color: Colors.black),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Date is Required';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _date = value!;
                },
              ),
            ),
          )
        ],
        backgroundColor: app_color.appBar,
        title: const Text(
          "Money Management",
          style: TextStyle(color: app_color.text, letterSpacing: 1),
        ),
        elevation: 0.2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Material(
                    elevation: 10,
                    shadowColor: const Color(0xff61ff82),
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
                          Alignment.bottomRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color(0xff00c9af),
                            // Color(0xff11c211),
                            // Color(0xff2ad054),
                            Color(0xff61f680)
                          ], // red to yellow
                          tileMode: TileMode.repeated, // repeats the gradient over the canvas
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Earned",
                              style: TextStyle(
                                color: app_color.textWhite,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "+$income",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFffffff),
                                letterSpacing: 1,
                              ),
                            ),
                            const Text(
                              "income this month",
                              style: TextStyle(
                                color: app_color.textWhite,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Material(
                    elevation: 10,
                    shadowColor: const Color(0xfffd5050),
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
                          Alignment.bottomRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color(0xffce009c),
                            // Color(0xffec0303),
                            // Color(0xffee2f2f),
                            Color(0xfff36d6d)
                          ], // red to yellow
                          tileMode: TileMode.repeated, // repeats the gradient over the canvas
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Spent",
                              style: TextStyle(
                                color: app_color.textWhite,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "-$expense",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFffffff),
                                letterSpacing: 1,
                              ),
                            ),
                            const Text(
                              "expenses this month",
                              style: TextStyle(
                                color: app_color.textWhite,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                elevation: 5,
                shadowColor: const Color(0xff4792ff),
                  borderRadius: BorderRadius.circular(10),
                  color: app_color.widget,
                // margin: const EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  children: [
                    const Text("Budget so far", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: expense! <= income! ? 1 - expense! / income! : expense! / income! - 1,
                          center: income! - expense! < 0 ?
                          Text(
                            "${income! - expense!}",
                            style: const TextStyle(
                              color: Color(0xffb10000),
                              letterSpacing: 1,
                            ),
                          ) :
                          Text(
                            "${income! - expense!}",
                            style: const TextStyle(
                              color: Color(0xFFffffff),
                              letterSpacing: 1,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: expense! <= income! ? Colors.lightBlueAccent : Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Material(
            //   elevation: 10,
            //   shadowColor: const Color(0xff4792ff),
            //   borderRadius: BorderRadius.circular(10),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width / 3.2,
            //     height: MediaQuery.of(context).size.height / 9,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: app_color.widget,
            //     ),
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const Text(
            //             "BALANCE",
            //             style: TextStyle(
            //               color: app_color.text,
            //               letterSpacing: 1,
            //             ),
            //           ),
            //           income! - expense! < 0 ?
            //           Text(
            //             "${income! - expense!}",
            //             style: const TextStyle(
            //               color: Color(0xFFff0000),
            //               letterSpacing: 1,
            //             ),
            //           ) :
            //           Text(
            //             "${income! - expense!}",
            //             style: const TextStyle(
            //               color: Color(0xFF000000),
            //               letterSpacing: 1,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            const Text(
              "Transactions",
              style: TextStyle(color: app_color.text,fontSize: 15),
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
                            elevation: 3,
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
                                          Navigator.pop(context, 'Go Back');
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
                              subtitle:
                              snapshot.data![index].trans == 'income' ?
                              Text(
                                "+ ${snapshot.data![index].amount.toString()}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(color: Colors.green),
                              ) :
                              Text(
                                "- ${snapshot.data![index].amount.toString()}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(color: Colors.red),
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
