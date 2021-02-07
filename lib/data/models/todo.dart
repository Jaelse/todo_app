class Todo {
  static const TODO_TABLE = 'todo';
  static const ID = 'id';
  static const TITLE = 'title';
  static const DESCRIPTION = 'description';
  static const IS_CHECKED = 'isChecked';

  final int id;
  final String title;
  final String description;
  final bool isChecked;

  Todo({this.id, this.title, this.description, this.isChecked});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json[ID],
        title: json[TITLE],
        description: json[DESCRIPTION],
        isChecked: json[IS_CHECKED] == 1);
  }
}
