import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/models/task_model.dart';

class TaskController extends ChangeNotifier {
  final List<Task> to_do = [];
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  TaskController() {
    loadTasks();
  }

  List<Task> get tasks => to_do;

  Future<void> loadTasks() async {
    final SharedPreferences pref = await prefs;
    List<String>? taskStrings = pref.getStringList('tasks');
    if (taskStrings != null) {
      tasks.clear();
      tasks.addAll(taskStrings
          .map((taskString) => Task.fromJson(jsonDecode(taskString))));
      notifyListeners();
    }
  }

  void addTask(String title, String description) {
    Task newTask = Task(title: title, description: description);
    tasks.add(newTask);
    saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final SharedPreferences pref = await prefs;
    List<String> taskStrings =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    await pref.setStringList('tasks', taskStrings);
  }

  void deleteTask(int index) {
    log(index.toString());
    tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    tasks.reversed.toList()[index].toggleCompletion();
    saveTasks();
    notifyListeners();
  }

  void toggleExpand(int index) {
    log("Expand $index");
    tasks.reversed.toList()[index].toggleExpand();
    notifyListeners();
  }

  void editTask(int index, String newTitle, String newDescription) {
    log("Edit $index");
    if (index >= 0 && index < tasks.length) {
      tasks.reversed.toList()[index].title = newTitle;
      tasks.reversed.toList()[index].description = newDescription;
      saveTasks();
      notifyListeners();
    } else {
      log('Invalid index: $index');
    }
  }
}
