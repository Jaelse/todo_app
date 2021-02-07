import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/service/todo_service.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';

class TodoRepository {
  final TodoService _todoService;

  TodoRepository({TodoService todoService}) : this._todoService = todoService;

  Future<List<TodoEntity>> getTodos() async {
    List<Todo> todos = await _todoService.getTodos();

    List<TodoEntity> todoEntities = List<Todo>.from(todos)
        .map((Todo e) => TodoEntity(
            id: e.id,
            title: e.title,
            description: e.description,
            isChecked: e.isChecked))
        .toList();

    return todoEntities;
  }

  Future<int> addTodo(String title, String description) async {
    int id = await _todoService.addTodo(title, description);
    return id;
  }

  Future<List<TodoEntity>> updateTodo(
      {int id, String title, String description, bool isChecked}) async {}
}
