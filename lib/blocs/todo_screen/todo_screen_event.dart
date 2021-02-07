abstract class TodoScreenEvent {}

class TodoScreenGetTodosEvent extends TodoScreenEvent {}

class TodoScreenAddTodoEvent extends TodoScreenEvent {
  final String title;
  final String description;

  TodoScreenAddTodoEvent({this.title, this.description});
}

class TodoScreenOnNewTodoTitleChangedEvent extends TodoScreenEvent {
  final String title;

  TodoScreenOnNewTodoTitleChangedEvent(this.title);
}

class TodoScreenOnNewTodoDescriptionChangedEvent extends TodoScreenEvent {
  final String description;

  TodoScreenOnNewTodoDescriptionChangedEvent(this.description);
}

class TodoScreenOnAddNewTodoRequestedEvent extends TodoScreenEvent{

}


class TodoScreenOnCheckTodoRequestedEvent extends TodoScreenEvent{

}