import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const dbName = "myDatabase.db";
  static const dbVersion = 1;
  static const dbTable = 'partsOrder';
  static const columnId = "id";
  static const columnName = "name";
  static const columnEmail = "email";
  static const columnItemName = "itemName";
  static const columnItemQuantity = "itemQuantity";
  static const columnItemPrice = "itemPrice";

  static final DatabaseHelper instance = DatabaseHelper();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    db.execute('''

CREATE TABLE $dbTable(
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnName TEXT NOT NULL,
  $columnEmail TEXT NOT NULL,
  $columnItemName TEXT NOT NULL,
  $columnItemQuantity INTEGER NOT NULL,
  $columnItemPrice INTEGER NOT NULL
)
''');
  }

  insertData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(dbTable, row);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    Database db = await instance.database;
    return await db.query(dbTable);
  }

  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(dbTable, row, where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> deleteRecord(int id) async {
    Database db = await instance.database;
    return await db.delete(dbTable, where: '$columnId=?', whereArgs: [id]);
  }
}
