import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todom";
final String Column_id = "id";
final String Column_name = "phoneNumber";
final String Password = "password";

class AuthHelper {
  Database db;

  AuthHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_name STRING, $Password STRING)");
    }, version: 1);
  }

  Future<void> insertTask(userData) async {
    print("this is data to insert  $userData");
    try {
      db.insert(tableName, userData, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print("this is error $_");
    }
  }

  Future<List<dynamic>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);
    debugPrint('this is tasks $tasks');
    return tasks;
  }

  Future<void> delete() async {
    
    await db.rawDelete('DELETE FROM $tableName');
    
}
}
