import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/settings/income_category.dart';
import 'package:money_management/db/database_income_category.dart';

class AddIncomeData extends StatefulWidget {
  final IncomeCategoryDb? user;
  final int? userIndex;

  const AddIncomeData({this.user, this.userIndex});

  @override
  State<AddIncomeData> createState() => _AddIncomeDataState();
}

class _AddIncomeDataState extends State<AddIncomeData> {
  String? _incomeCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _incomeCategory = widget.user!.incomeCategory;
    }
  }

  Widget _buildItem(){
    return TextFormField(
      initialValue: _incomeCategory,
      decoration: const InputDecoration(labelText: 'Income Category',hoverColor: Colors.black,fillColor: Colors.black,focusColor: Colors.black),
      maxLength: 15,
      style: const TextStyle(
          color: Colors.black
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _incomeCategory = value;
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
          "Add income category",
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  debugPrint("clicked");
                  if(!_formKey.currentState!.validate()) {
                    return;
                  }

                  _formKey.currentState!.save();
                  debugPrint("saved");
                  IncomeCategoryDb user = IncomeCategoryDb(incomeCategory: _incomeCategory);

                  List<IncomeCategoryDb> listofIncomeCategoryDb = [user];

                  DatabaseHandlerIncomeCategory db = DatabaseHandlerIncomeCategory();

                  await db.insertIncomeCategory(listofIncomeCategoryDb);
                  debugPrint("insert");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const IncomeCategory()));
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
