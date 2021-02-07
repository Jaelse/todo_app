import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_screen/todo_screen_event.dart';
import 'package:todo_app/blocs/todo_screen/todo_screen_state.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

class TodoScreenBloc extends Bloc<TodoScreenEvent, TodoScreenState> {
  TodoScreenBloc({TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(TodoScreenInitialState());

  final TodoRepository _todoRepository;

  @override
  Stream<TodoScreenState> mapEventToState(TodoScreenEvent event) async* {
    if (event is TodoScreenGetTodosEvent) {
      yield* _mapTodoScreenGetTodosEventToState(event, state);
    } else if (event is TodoScreenOnNewTodoTitleChangedEvent) {
      yield* _mapTodoScreenOnNewTodoTitleChangedEventToState(event, state);
    } else if (event is TodoScreenOnNewTodoDescriptionChangedEvent) {
      yield* _mapTodoScreenOnNewTodoDescriptionChangedEventToState(
          event, state);
    } else if (event is TodoScreenOnAddNewTodoRequestedEvent) {
      yield* _mapTodoScreenOnAddNewTodoRequestedEventToState(event, state);
    }
  }

  Stream<TodoScreenState> _mapTodoScreenGetTodosEventToState(
      TodoScreenGetTodosEvent event, TodoScreenState state) async* {
    if (state is TodoScreenInitialState) {
      List<TodoEntity> todos = await _todoRepository.getTodos();

      List<TodoEntity> checkedTodos = List<TodoEntity>.from(todos)
          .where((element) => element.isChecked)
          .toList();

      List<TodoEntity> notCheckedTodos = List<TodoEntity>.from(todos)
          .where((element) => !element.isChecked)
          .toList();

      yield TodoScreenSuccessState(
          notCheckedTodos: notCheckedTodos, checkedTodos: checkedTodos);
    }
  }

  Stream<TodoScreenState> _mapTodoScreenOnNewTodoTitleChangedEventToState(
      TodoScreenOnNewTodoTitleChangedEvent event,
      TodoScreenState state) async* {
    if (state is TodoScreenSuccessState) {
      yield state.copyWith(newTodoTitle: event.title);
    }
  }

  Stream<TodoScreenState> _mapTodoScreenOnNewTodoDescriptionChangedEventToState(
      TodoScreenOnNewTodoDescriptionChangedEvent event,
      TodoScreenState state) async* {
    if (state is TodoScreenSuccessState) {
      yield state.copyWith(newTodoDescription: event.description);
    }
  }

  Stream<TodoScreenState> _mapTodoScreenOnAddNewTodoRequestedEventToState(
      TodoScreenOnAddNewTodoRequestedEvent event,
      TodoScreenState state) async* {
    if (state is TodoScreenSuccessState) {
      yield TodoScreenProgressState();

      if (state.newTodoTitle != null) {
        String description = "";
        if (state.newTodoDescription != null) {
          description = state.newTodoDescription;
        }
        int id = await _todoRepository.addTodo(state.newTodoTitle, description);
        if (id != null) {
          List<TodoEntity> todos = await _todoRepository.getTodos();

          List<TodoEntity> checkedTodos = List<TodoEntity>.from(todos)
              .where((element) => element.isChecked)
              .toList();

          List<TodoEntity> notCheckedTodos = List<TodoEntity>.from(todos)
              .where((element) => !element.isChecked)
              .toList();


          yield TodoScreenSuccessState(notCheckedTodos: notCheckedTodos, checkedTodos: checkedTodos);
        } else {
          yield TodoScreenFailureState();
        }
      }
    }
  }
}
