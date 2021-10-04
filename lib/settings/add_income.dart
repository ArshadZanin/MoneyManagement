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
              color: const Color(0xFF13254C).withOpacity(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _incomeCategory,
                    decoration: const InputDecoration(labelText: 'Income Category'),
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
                      _incomeCategory = value;
                    },
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: FlatButton(
                height: 30,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.red,
                minWidth: MediaQuery.of(context).size.width - 100,
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
