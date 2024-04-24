import 'dart:developer';

class Task {
  String title;
  String description;
  bool completed;
  bool expanded;

  Task({
    required this.title,
    required this.description,
    this.completed = false,
    this.expanded = false,
  });

  // Deserialize JSON string to Task object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      completed: json['completed'] ?? false,
      expanded: json['expanded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'expanded': expanded,
    };
  }

  void toggleCompletion() {
    completed = !completed;
  }

  void toggleExpand() {
    expanded = !expanded;
    log("message");
  }
}