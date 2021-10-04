import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/db/database_expense_category.dart';

import 'expense_category.dart';

class AddExpenseData extends StatefulWidget {
  final ExpenseCategoryDb? user;
  final int? userIndex;

  const AddExpenseData({this.user, this.userIndex});


  @override
  State<AddExpenseData> createState() => _AddExpenseDataState();
}

class _AddExpenseDataState extends State<AddExpenseData> {

  String? _expenseCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _expenseCategory = widget.user!.expenseCategory;
    }
  }

  Widget _buildItem(){
    return TextFormField(
      initialValue: _expenseCategory,
      decoration: const InputDecoration(labelText: 'Expense Category'),
      maxLength: 15,
      style: const TextStyle(
          color: Colors.white
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _expenseCategory = value;
      },
      textAlign: TextAlign.left,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF020925),
        title: const Text(
          "Add expense category",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildItem(),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.red,
                padding: const EdgeInsets.only(top: 10,bottom: 10,right: 50,left: 50),
                onPressed: () async {
                  debugPrint("Saved");
                  debugPrint("clicked");
                  if(!_formKey.currentState!.validate()) {
                    return;
                  }

                  _formKey.currentState!.save();
                  debugPrint("saved");
                  ExpenseCategoryDb user = ExpenseCategoryDb(expenseCategory: _expenseCategory);

                  List<ExpenseCategoryDb> listofExpenseCategoryDb = [user];

                  DatabaseHandlerExpenseCategory db = DatabaseHandlerExpenseCategory();

                  await db.insertExpenseCategory(listofExpenseCategoryDb);
                  debugPrint("insert");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ExpenseCategory()));
                  debugPrint("completed");
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
