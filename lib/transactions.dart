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


  int flag = 0;

  List<String> listDate = [];


  late var _date = DateFormat('MMM dd, yyyy').format(DateTime.now());
  final _dateController = TextEditingController(text: DateFormat('MMM dd, yyyy').format(DateTime.now()));



  DatabaseHandler handler = DatabaseHandler();
  
  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {



      late final _dateYear = _dateController.text.substring(8, _dateController.text.length);
      late final _dateMonth = _dateController.text.substring(0, _dateController.text.length - 9);
      // handler.retrieveWithCategory("income");
      //
      // String? income12 = await handler.calculateIncomeTotal();
      // income = double.parse(income12!);
      //
      // String? expense12 = await handler.calculateExpenseTotal();
      // expense = double.parse(expense12!);
      //
      // balance = (income! - expense!);


      ///take database list to here///
      List<Map<String, Object?>> databaseList = await handler.retrieveUsersDatabase();
      // debugPrint("hello : $databaseList");


      ///take date///
      Set<String> dateSet = {};
      for(int i = 0; i < databaseList.length; i++){
          String data = databaseList[i]["date"].toString();
          dateSet.add(data);
      }
      listDate = [...dateSet.toList()];
      for(int i = 0; i < listDate.length; i++){
        if(listDate[i] == _dateController.text){
          setState(() {
            flag = 1;
          });
        }
      }


      ///income month///
      double total = 0;
      for (int j = 0; j < databaseList.length; j++) {
        String dateIs = databaseList[j]['date'].toString().substring(
            0, databaseList[j]['date']
            .toString()
            .length - 9);
        String dateLast = databaseList[j]['date'].toString().substring(
            8, databaseList[j]['date']
            .toString()
            .length);
        if (dateIs == _dateMonth && dateLast == _dateYear &&
            databaseList[j]['trans'] == "income") {
          double value = double.parse(databaseList[j]["amount"].toString());
          total = total + value;
        }
      }
      income = total;


      ///expense month///
      double total1 = 0;
      for (int j = 0; j < databaseList.length; j++) {
        String dateIs = databaseList[j]['date'].toString().substring(
            0, databaseList[j]['date']
            .toString()
            .length - 9);
        String dateLast = databaseList[j]['date'].toString().substring(
            8, databaseList[j]['date']
            .toString()
            .length);
        if (dateIs == _dateMonth && dateLast == _dateYear &&
            databaseList[j]['trans'] == "expense") {
          debugPrint("$dateIs $_dateMonth \n $dateLast $_dateYear");
          double value = double.parse(databaseList[j]["amount"].toString());
          total1 = total1 + value;
        }
      }
      expense = total1;
      // await this.addUsers();
      setState(() {});
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
      });
    });
  }


  int countIs(int count){
    count++;
    return count;
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
                      for(int i = 0; i < listDate.length; i++){
                        if(listDate[i] == _dateController.text){
                          flag = 1;
                          break;
                        }else{
                          flag = 0;
                        }
                      }
                      setState(() {

                      });
                      handler.initializeDB().whenComplete(() async {
                        late final _dateYear = _dateController.text.substring(8, _dateController.text.length);
                        late final _dateMonth = _dateController.text.substring(0, _dateController.text.length - 9);
                        ///take database list to here///
                        List<Map<String, Object?>> databaseList = await handler.retrieveUsersDatabase();
                        debugPrint("hello : $databaseList");
                        ///income month///
                        double total = 0;
                        for (int j = 0; j < databaseList.length; j++) {
                          String dateIs = databaseList[j]['date'].toString().substring(
                              0, databaseList[j]['date']
                              .toString()
                              .length - 9);
                          String dateLast = databaseList[j]['date'].toString().substring(
                              8, databaseList[j]['date']
                              .toString()
                              .length);
                          if (dateIs == _dateMonth && dateLast == _dateYear &&
                              databaseList[j]['trans'] == "income") {
                            double value = double.parse(databaseList[j]["amount"].toString());
                            total = total + value;
                          }
                        }
                        income = total;
                        ///expense month///
                        double total1 = 0;
                        for (int j = 0; j < databaseList.length; j++) {
                          String dateIs = databaseList[j]['date'].toString().substring(
                              0, databaseList[j]['date']
                              .toString()
                              .length - 9);
                          String dateLast = databaseList[j]['date'].toString().substring(
                              8, databaseList[j]['date']
                              .toString()
                              .length);
                          if (dateIs == _dateMonth && dateLast == _dateYear &&
                              databaseList[j]['trans'] == "expense") {
                            debugPrint("$dateIs $_dateMonth \n $dateLast $_dateYear");
                            double value = double.parse(databaseList[j]["amount"].toString());
                            total1 = total1 + value;
                          }
                        }
                        expense = total1;
                        // await this.addUsers();
                        setState(() {});
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
          "MoneyQuipo",
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
                    shadowColor: const Color(0xff00c9af),
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
                    elevation: 8,
                    shadowColor: const Color(0xffce009c),
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
            const Text(
              "Transactions",
              style: TextStyle(color: app_color.text,fontSize: 15),
            ),
            const SizedBox(
              height: 4,
            ),
            flag != 1 ?
             Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const [
                    Icon(Icons.add_to_photos_sharp,size: 50,color: Colors.black26,),
                    Text("No data available!",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black26,),),
                  ],
                ),
              ),
            ) : Expanded(
              child: FutureBuilder(
                future: handler.retrieveUsers(),
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
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
                            margin: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 4),
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
                                        child: const Text('Go Back',style: TextStyle(color: Colors.blue),),
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
                                style: const TextStyle(color: Colors.green,fontSize: 18),
                              ) :
                              Text(
                                "- ${snapshot.data![index].amount.toString()}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(color: Colors.red,fontSize: 18),
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
