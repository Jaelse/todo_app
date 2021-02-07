import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_screen/todo_screen_bloc.dart';
import 'package:todo_app/blocs/todo_screen/todo_screen_event.dart';
import 'package:todo_app/blocs/todo_screen/todo_screen_state.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoScreenBloc(
          todoRepository: RepositoryProvider.of<TodoRepository>(context))
        ..add(TodoScreenGetTodosEvent()),
      child: BlocBuilder<TodoScreenBloc, TodoScreenState>(
        builder: (BuildContext context, TodoScreenState state) {
          if (state is TodoScreenInitialState ||
              state is TodoScreenProgressState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is TodoScreenSuccessState) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(title, style: TextStyle(color: Colors.white)),
                  bottom: TabBar(tabs: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Checked",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text("Unchecked", style: TextStyle(color: Colors.white)),
                  ]),
                ),
                body: todoListWidget(
                    context, state.notCheckedTodos, state.checkedTodos),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await addTodoDialog(
                        context, context.read<TodoScreenBloc>());
                  },
                  tooltip: 'Add Todo',
                  child: Icon(Icons.add),
                ), // This trailing comma makes auto-formatting nicer for build methods.
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Center(child: Text("Something went wrong")),
            );
          }
        },
      ),
    );
  }

  Widget todoListWidget(context, List<TodoEntity> incompleteTodos,
      List<TodoEntity> completeTodos) {
    return TabBarView(
      children: [
        incompleteTodoList(context, incompleteTodos),
        completeTodoList(context, completeTodos),
      ],
    );
  }

  Widget incompleteTodoList(BuildContext context, List<TodoEntity> todos) {
    if (todos == null) {
      return Center(
        child: Text("You have no todo here. Please add todo..."),
      );
    } else if (todos.length == 0) {
      return Center(
        child: Text("You have no todo here. Please add todo..."),
      );
    }

    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2,
            child: ClipPath(
              child: Container(
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      print("asd");
                    },
                    child: todos[index].isChecked
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          )
                        : Icon(
                            Icons.check_circle,
                            size: 30,
                          ),
                  ),
                  title: Text(todos[index].title),
                  subtitle: Text(
                    todos[index].description,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                height: 60,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.green, width: 5))),
              ),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
            ),
          );
        });
  }

  Widget completeTodoList(BuildContext context, List<TodoEntity> todos) {
    if (todos == null) {
      return Center(
        child: Text("You have no todo here. Please add todo..."),
      );
    } else if (todos.length == 0) {
      return Center(
        child: Text("You have no todo here."),
      );
    }

    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2,
            child: ClipPath(
              child: Container(
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      print("asd");
                    },
                    child: todos[index].isChecked
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          )
                        : Icon(
                            Icons.check_circle,
                            size: 30,
                          ),
                  ),
                  title: Text(todos[index].title),
                  subtitle: Text(
                    todos[index].description,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                height: 60,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.green, width: 5))),
              ),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
            ),
          );
        });
  }

  void addTodoDialog(BuildContext context, TodoScreenBloc bloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        //this right here
        child: Container(
          height: 400.0,
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Add Todo',
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Title..."),
                  onChanged: (String title) {
                    bloc.add(TodoScreenOnNewTodoTitleChangedEvent(title));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Description..."),
                  onChanged: (String description) {
                    bloc.add(TodoScreenOnNewTodoDescriptionChangedEvent(
                        description));
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50.0)),
              FlatButton(
                  onPressed: () {
                    bloc.add(TodoScreenOnAddNewTodoRequestedEvent());
                    return Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.purple, fontSize: 18.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
