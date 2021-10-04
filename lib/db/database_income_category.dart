import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//income category database

class IncomeCategoryDb {
  final int? id;
  final String? incomeCategory;

  IncomeCategoryDb({this.id, this.incomeCategory});

  IncomeCategoryDb.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        incomeCategory = res["incomeCategory"];

  Map<String, Object?> toMap() {
    return {'id': id, 'incomeCategory': incomeCategory};
  }
}

class DatabaseHandlerIncomeCategory {
  Database? _database;

  Future<Database?> get database async {
    debugPrint("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await initializeDB();

    return _database;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'incomeCategory.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE incomeCategories(id INTEGER PRIMARY KEY AUTOINCREMENT, incomeCategory TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertIncomeCategory(List<IncomeCategoryDb> incomeCategories) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var incomeCategory in incomeCategories) {
      result = await db.insert('incomeCategories', incomeCategory.toMap());
    }
    return result;
  }

  Future<List<IncomeCategoryDb>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('incomeCategories');
    return queryResult.map((e) => IncomeCategoryDb.fromMap(e)).toList();
  }

  Future<void> deleteIncomeCategory(int id) async {
    final db = await initializeDB();
    await db.delete(
      'incomeCategories',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<dynamic>> listIncomeCategory() async {
    var dbClient = await initializeDB();
    var result = await dbClient.rawQuery("SELECT incomeCategory FROM incomeCategories");
    var incomeCate = [];
    for (int x = 0 ; x < result.length; x++) {
      debugPrint("${result[x].values}");
      incomeCate.add(result[x].values.toString().replaceAll( RegExp(r"\p{P}", unicode: true), ""));
    }
    return incomeCate;
  }

}
