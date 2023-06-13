import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/models/task.dart';

import '../logger.dart';
import 'home.dart';

class TaskController {
  var nameControl = TextEditingController();
  var descriptionControl = TextEditingController();

  late Observable<bool> withDueDate;
  late Observable<DateTime> dueDate;
  late ValueKey id;
  late Priority priority;

  TaskController(TaskModel model) {
    id = model.id;
    withDueDate = Observable(model.dueDate.value != null);
    dueDate = Observable(model.dueDate.value ?? DateTime.now());
    nameControl.text = model.name.value ?? '';
    descriptionControl.text = model.description.value ?? '';
    priority = model.priority.value;
  }

  void saveData() {
    logger.i('Save task data');
    var controller = GetIt.I<HomeController>();
    bool isCreating = false;
    var task = controller.taskList.firstWhere(
      (e) => e.id == id,
      orElse: () {
        isCreating = true;
        return TaskModel();
      },
    );
    runInAction(
      () {
        task.id = id;
        task.name.value = nameControl.text;
        task.description.value =
            descriptionControl.text != '' ? descriptionControl.text : null;
        task.priority.value = priority;
        task.dueDate.value = withDueDate.value ? dueDate.value : null;
        controller.saveTask(task, isCreating);
      },
    );
  }
}
