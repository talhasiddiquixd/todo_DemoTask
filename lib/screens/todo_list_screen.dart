import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/controllers/task_controller.dart';
import 'package:to_do_project/models/task_model.dart';
import 'package:to_do_project/widgets/task_button.dart';
import 'package:to_do_project/widgets/task_dialog.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen>
    with SingleTickerProviderStateMixin {
  int expandedIndex = -1;
  late AnimationController controller;
  late Animation<double> animation;
  List<int> expandedIndices = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        vsync: this);
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleExpand(int index) {
    setState(() {
      if (expandedIndices.contains(index)) {
        expandedIndices.remove(index);
        expandedIndex = -1;
        controller.reverse();
      } else {
        if (expandedIndex != -1) {
          expandedIndices.remove(expandedIndex);
          controller.reverse();
        }
        expandedIndices.add(index);
        expandedIndex = index;
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            fontFamily: 'Reboot',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        actions: const [
          AddTaskButton(),
        ],
      ),
      body: Consumer<TaskController>(
        builder: (context, taskController, _) {
          return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              log(index.toString());
              final Task task = taskController.tasks.reversed.toList()[index];
              return Column(
                children: [
                  ListTile(
                    title: GestureDetector(
                      onTap: () => toggleExpand(index),
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: task.completed
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.check_circle_outline,
                            color: Colors.grey,
                          ),
                  ),
                  SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1,
                    child: expandedIndex == index
                        ? Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    decoration: task.completed
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2.0,
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showAddTaskDialog(context,
                                            initialTitle: task.title,
                                            initialDescription:
                                                task.description,
                                            index: index);
                                      },
                                      icon: const Icon(Icons.edit),
                                      color: Colors.blue,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        taskController.deleteTask(index);
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        taskController
                                            .toggleTaskCompletion(index);
                                      },
                                      icon: const Icon(Icons.done),
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
