import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/database_expense_category.dart';
import 'package:money_management/db/database_income_category.dart';
import 'package:money_management/db/database_transaction.dart';
import '../main.dart';



class AddTrans extends StatefulWidget {
  final User? student;
  final int? studentIndex;

  const AddTrans({this.student, this.studentIndex});

  @override
  _AddTransState createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  int section = 0;

  late var _saveDate = DateFormat('MMM dd, yyyy').format(DateTime.now());

  String _transaction = "income";
  // String _saveDate;
  String? _account = 'Assets';
  String? _category = '<select>';
  String? _amount;
  String? _note;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late DatabaseHandler handler;
  late DatabaseHandlerIncomeCategory handlerIncome;
  late DatabaseHandlerExpenseCategory handlerExpense;

  List<String>? incomeCate;
  List<String>? expenseCate;

  var income12 = [];
  var expense12 = [];

  var incomeCategory = ['<select>'];
  var expenseCategory = ['<select>'];



  @override
  void initState() {
    super.initState();
    incomeCate ??= ['Cash'];
    expenseCate ??= ['Food'];
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      // await this.addUsers();
      setState(() {

      });

    });
    if (widget.student != null) {
      _transaction = widget.student!.trans!;
      _saveDate = widget.student!.date!;
      _account = widget.student!.account;
      _category = widget.student!.category;
      _amount = widget.student!.amount!;
      _note = widget.student!.note;
    }

    ///income Category to list///
    handlerIncome = DatabaseHandlerIncomeCategory();
    handlerIncome.initializeDB().whenComplete(() async {
      List incomeCate12 = await handlerIncome.listIncomeCategory();
      if(incomeCate12 == null){
        incomeCate12.add("Cash");
      }
      else{
        incomeCate12.toSet().toList();
      }
      debugPrint("$incomeCate12");
      incomeCate = [...incomeCate12];
      for(int i = 0; i < incomeCate!.length; i++){
        incomeCategory.add(incomeCate![i]);
      }
      debugPrint("$incomeCategory");
      setState(() {

      });
    });

    ///expense category to list///
    handlerExpense = DatabaseHandlerExpenseCategory();
    handlerExpense.initializeDB().whenComplete(() async {
      List expenseCate12 = await handlerExpense.listExpenseCategory();
      if(expenseCate12 == null){
        expenseCate12.add("Cash");
      }
      else{
        expenseCate12.toSet().toList();
      }
      debugPrint("$expenseCate12");
      expenseCate = [...expenseCate12];
      for(int i = 0; i < expenseCate!.length; i++){
        expenseCategory.add(expenseCate![i]);
      }
      debugPrint("$expenseCategory");
      setState(() {

      });
    });
  }

  final _dateController = TextEditingController(text: DateFormat('MMM dd, yyyy').format(DateTime.now()));
  Widget _buildDate() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
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
            }
          });
        },
        decoration: const InputDecoration(labelText: 'Date'),
        style: const TextStyle(fontSize: 15),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Date is Required';
          }
          return null;
        },
        onSaved: (String? value) {
          _saveDate = value!;
        },
      ),
    );
  }

  Widget _buildAccount() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          const Text("Account:\t\t"),
          DropdownButton(
            items: <String>['Assets', 'Liabilities']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: _account,
            onChanged: (String? newValue) {
              setState(() {
                _account = newValue!;
              });
            },
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 0,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory1() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          const Text("Category:\t\t"),
          DropdownButton(
            hint: const Text("<select>"),
            items: incomeCategory
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: _category,
            onChanged: (String? newValue) {
              setState(() {
                _category = newValue!;
              });
            },
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 0,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory2() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          const Text("Category:\t\t"),
          DropdownButton(
            hint: const Text("<select>"),
            items: expenseCategory
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: _category,
            onChanged: (String? newValue) {
              setState(() {
                _category = newValue!;
              });
            },
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 0,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmount() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        initialValue: _amount,
        decoration: const InputDecoration(labelText: 'Amount'),
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 15),
        validator: (String? value) {
          int? amount = int.tryParse(value!);

          if (amount == null) {
            return 'amount required';
          }

          return null;
        },
        onSaved: (String? value) {
          _amount = value;
        },
      ),
    );
  }

  Widget _buildNote() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        initialValue: _note,
        decoration: const InputDecoration(labelText: 'Note'),
        maxLength: 30,
        style: const TextStyle(fontSize: 15),
        onSaved: (String? value) {
          _note = value;
        },
      ),
    );
  }

  @deprecated
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          section == 0 ? "Income" : "Expense",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF13254C),
      ),
      body: Container(
        color: const Color(0xFF13254C),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              section == 0
                  ? FlatButton(
                      onPressed: () {
                        setState(() {
                          _category = '<select>';
                          section = 0;
                          _transaction = "income";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue)),
                        child: const Text(
                          "Income",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ),
                    )
                  : FlatButton(
                      onPressed: () {
                        setState(() {
                          _category = '<select>';
                          section = 0;
                          _transaction = "income";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: const Text(
                          "Income",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ),
              section != 0
                  ? FlatButton(
                      onPressed: () {
                        setState(() {
                          _category = '<select>';
                          section = 1;
                          _transaction = "expense";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red)),
                        child: const Text(
                          "Expense",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                    )
                  : FlatButton(
                      onPressed: () {
                        setState(() {
                          _category = '<select>';
                          section = 1;
                          _transaction = "expense";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: const Text(
                          "Expense",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ),
            ],
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,),
              width: MediaQuery.of(context).size.width - 10,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDate(),
                  _buildAccount(),
                  section == 0 ?
                  _buildCategory1() : _buildCategory2(),
                  _buildAmount(),
                  _buildNote(),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    color: Colors.red,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      if(_category == '<select>' && section == 0){
                        _category = 'Cash';
                      }else if(_category == '<select>' && section == 1){
                        _category = 'Food';
                      }


                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      _formKey.currentState!.save();

                      User student = User(
                          trans: _transaction,
                          date: _saveDate,
                          account: _account,
                          category: _category,
                          amount: _amount,
                          note: _note);

                      List<User> listOfUser = [student];

                      DatabaseHandler db = DatabaseHandler();

                      await db.insertUser(listOfUser);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
