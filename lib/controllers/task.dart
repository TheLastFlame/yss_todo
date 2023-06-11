import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/models/task.dart';

class TaskController {
  var nameControl = TextEditingController();
  var descriptionControl = TextEditingController();

  late Observable<bool> withDueDate;
  late Observable<DateTime> dueDate;
  late UniqueKey id;
  late Priority priority;

  TaskController(TaskModel model) {
    id = model.id;
    withDueDate = Observable(model.dueDate.value != null);
    dueDate = Observable(model.dueDate.value ?? DateTime.now());
    nameControl.text = model.name.value ?? '';
    descriptionControl.text = model.description.value ?? '';
    priority = model.priority.value;
  }
}
