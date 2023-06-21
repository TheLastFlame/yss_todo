import "dart:convert";
import "package:flutter/material.dart";
import "package:mobx/mobx.dart";
import "package:yss_todo/models/priority.dart";

class TaskModel {
  late ValueKey id;
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
    this.id = id ?? ValueKey(UniqueKey().toString());
    this.name = Observable(name);
    this.dueDate = Observable(dueDate);
    this.priority = Observable(priority);
    this.isCompleted = Observable(isCompleted);
  }

  TaskModel.fromJSON(String json) {
    var jsonMap = jsonDecode(json);
    id = ValueKey(jsonMap['id']);
    name = Observable(jsonMap['name']);
    dueDate = Observable(jsonMap['dueDate'] != null ? DateTime.tryParse(jsonMap['dueDate']) : null);
    priority = Observable(Priority.values[jsonMap['priority']]);
    isCompleted = Observable(jsonMap['isCompleted']);
  }

  toJSON() {
    return jsonEncode({
      "id": id.value,
      "name": name.value,
      "dueDate": dueDate.value.toString(),
      "priority": priority.value.index,
      "isCompleted": isCompleted.value
    });
  }
}

