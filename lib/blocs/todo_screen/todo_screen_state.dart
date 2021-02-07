import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';

abstract class TodoScreenState extends Equatable {}

class TodoScreenInitialState extends TodoScreenState {
  @override
  List<Object> get props => [];
}

class TodoScreenProgressState extends TodoScreenState {
  @override
  List<Object> get props => [];
}

class TodoScreenFailureState extends TodoScreenState {
  @override
  List<Object> get props => [];
}

class TodoScreenSuccessState extends TodoScreenState {
  final List<TodoEntity> notCheckedTodos;
  final List<TodoEntity> checkedTodos;
  final String newTodoTitle;
  final String newTodoDescription;

  TodoScreenSuccessState({
    this.notCheckedTodos,
    this.checkedTodos,
    this.newTodoTitle,
    this.newTodoDescription,
  });

  TodoScreenSuccessState copyWith({
    List<TodoEntity> notCheckedTodos,
    List<TodoEntity> checkedTodos,
    String newTodoTitle,
    String newTodoDescription,
  }) {
    return TodoScreenSuccessState(
      notCheckedTodos: notCheckedTodos ?? this.notCheckedTodos,
      checkedTodos: checkedTodos ?? this.checkedTodos,
      newTodoTitle: newTodoTitle ?? this.newTodoTitle,
      newTodoDescription: newTodoDescription ?? this.newTodoDescription,
    );
  }

  @override
  List<Object> get props => [notCheckedTodos, newTodoTitle, newTodoDescription];
}
