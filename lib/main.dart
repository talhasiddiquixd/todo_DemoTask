import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/controllers/task_controller.dart';
import 'package:to_do_project/screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskController(),
      child: MaterialApp(
        title: "To-Do List",
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        home: const ToDoListScreen(),
      ),
    );
  }
}
