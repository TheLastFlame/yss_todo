class Task {
  late String name;
  String? description;
  DateTime? until;
  late Priority priority;
}

enum Priority {low, regular, high, critical}