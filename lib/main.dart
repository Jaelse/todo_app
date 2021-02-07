import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';
import 'package:todo_app/todo_screen/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Data data = Data.instance;
  await data.initDatabase();

  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider(
      create: (BuildContext context) =>
          TodoRepository(todoService: data.todoService()),
    )
  ], child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoScreen(title: 'My TODO List'),
    );
  }
}
