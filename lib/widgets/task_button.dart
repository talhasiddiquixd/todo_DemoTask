import "package:flutter/material.dart";
import "package:to_do_project/widgets/task_dialog.dart";

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key});

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      // margin: EdgeInsets.symmetric(horizontal: isPressed ? 20.0 : 0),
      child: IconButton(
        onPressed: () {
          showAddTaskDialog(context);
          setState(() {
            isPressed = !isPressed;
          });
        },
        icon: Icon(
          Icons.add,
          color: isPressed ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
