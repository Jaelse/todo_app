class TodoEntity {
  final int _id;
  final String _title;
  final String _description;
  final bool _isChecked;

  TodoEntity({int id, String title, String description, bool isChecked})
      : _id = id,
        _title = title,
        _description = description,
        _isChecked = isChecked;

  int get id => _id;

  String get title => _title;

  String get description => _description;

  bool get isChecked => _isChecked;
}
