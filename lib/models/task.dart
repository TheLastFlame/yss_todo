class TaskModel {
  int id;
  String name;
  String? description;
  DateTime? until;
  Priority priority;

  TaskModel({required this.id, required this.name, this.description, this.until, required this.priority});
}

enum Priority {low, regular, high, critical}