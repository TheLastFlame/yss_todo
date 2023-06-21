import "dart:convert";
import "package:mobx/mobx.dart";
import 'package:yss_todo/domain/models/priority.dart';
import 'package:uuid/uuid.dart';

class TaskModel {
  late String id;
  late Observable<String?> name;
  late Observable<DateTime?> dueDate;
  late Observable<Priority> priority;
  late Observable<bool> isCompleted;

  TaskModel(
      {id,
      name,
      description,
      dueDate,
      priority = Priority.regular,
      isCompleted = false}) {
    this.id = id ?? const Uuid().v4();
    this.name = Observable(name);
    this.dueDate = Observable(dueDate);
    this.priority = Observable(priority);
    this.isCompleted = Observable(isCompleted);
  }

  TaskModel.fromJSON(String json) {
    var jsonMap = jsonDecode(json);
    id = jsonMap['id'];
    name = Observable(jsonMap['name']);
    dueDate = Observable(jsonMap['dueDate'] != null ? DateTime.tryParse(jsonMap['dueDate']) : null);
    priority = Observable(Priority.values[jsonMap['priority']]);
    isCompleted = Observable(jsonMap['isCompleted']);
  }

  toJSON() {
    return jsonEncode({
      "id": id,
      "name": name.value,
      "dueDate": dueDate.value.toString(),
      "priority": priority.value.index,
      "isCompleted": isCompleted.value
    });
  }
}

