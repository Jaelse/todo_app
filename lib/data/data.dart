import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/service/todo_service.dart';
import 'package:path/path.dart';

class Data {
  Database _db;

  TodoService _todoService;

  Data._privateConstructor();
  static final Data instance = Data._privateConstructor();

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult]) {
    print(functionName);
    print(sql);
    if(selectQueryResult != null){
      print(selectQueryResult);
    }else if(insertAndUpdateQueryResult != null){
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createTodoTable(Database db) async {
    final todoSql = '''CREATE TABLE ${Todo.TODO_TABLE}
    (
      ${Todo.ID} INTEGER PRIMARY KEY,
      ${Todo.TITLE} TEXT,
      ${Todo.DESCRIPTION} TEXT,
      ${Todo.IS_CHECKED} BIT NOT NULL
    )''';

    await db.execute(todoSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = join(dir.path, dbName);

    return path;
  }

  Future<void> initDatabase() async {
    if(this._db == null){
      final path = await getDatabasePath('todo_db.db');
      this._db = await openDatabase(path, version: 1, onCreate: onCreate);
    }
  }

  Future<void> onCreate(Database db, int version) async{
    await createTodoTable(db);
  }

  TodoService todoService() {

    if(this._todoService == null){
      this._todoService = TodoService(db: this._db);
    }

    return this._todoService;
  }
}
