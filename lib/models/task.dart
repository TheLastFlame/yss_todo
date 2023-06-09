class TaskModel {
  int id;
  String name;
  String? description;
  DateTime? until;
  Priority priority;
  bool isCompleted;

  TaskModel(
      {required this.id,
      required this.name,
      this.description,
      this.until,
      this.priority = Priority.regular,
      this.isCompleted = false});
}

enum Priority { low, regular, high, critical }
