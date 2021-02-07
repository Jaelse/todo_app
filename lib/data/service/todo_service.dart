import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/models/todo.dart';

class TodoService {
  final Database db;

  TodoService({this.db});

  Future<Todo> getTodo(String id) async {
    List<Map> cursor = await db.rawQuery(
        "select * from " + Todo.TODO_TABLE + " where " + Todo.ID + "=?'" + "'",
        [id]);

    Todo todo = Todo.fromJson(cursor[0]);

    return todo;
  }

  Future<List<Todo>> getTodos() async {
    List<Map> rawData = await db.query(Todo.TODO_TABLE);

    List<Todo> todos =
        List<Map>.from(rawData).map((Map e) => Todo.fromJson(e)).toList();

    return todos;
  }

  Future<int> addTodo(String title, String description) async {
    Map<String, dynamic> row = {
      Todo.TITLE: title,
      Todo.DESCRIPTION: description,
      Todo.IS_CHECKED: 0
    };

    return await db.insert(Todo.TODO_TABLE, row);
  }

  Future<Todo> updateIsCheckedTodo(String id, bool isChecked) async {}
}
