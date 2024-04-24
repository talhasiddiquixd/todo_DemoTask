import "dart:developer";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:to_do_project/controllers/task_controller.dart";

void showAddTaskDialog(BuildContext context,
    {String? initialTitle, String? initialDescription, int? index}) {
  final TaskController taskController =
      Provider.of<TaskController>(context, listen: false);

  final TextEditingController titleController =
      TextEditingController(text: initialTitle ?? '');
  final TextEditingController descriptionController =
      TextEditingController(text: initialDescription ?? '');
  log(index.toString());

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Center(
              child: Text(
                initialTitle != null ? "Update A Task" : 'Add New Task',
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontFamily: 'Reboot',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Task Description',
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orangeAccent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.orangeAccent
                          .withOpacity(0.5); // Disable color
                    }
                    return Colors.orangeAccent;
                  }),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  log("${index != null && titleController.text != "" && descriptionController.text != ""}");
                  if (index != null &&
                      titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    taskController.editTask(index, titleController.text,
                        descriptionController.text);
                  } else if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    taskController.addTask(
                        titleController.text, descriptionController.text);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  initialTitle != "" ? "Update" : "Add",
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
