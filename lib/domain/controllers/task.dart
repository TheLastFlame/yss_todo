import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/domain/models/task.dart';

import '../../logger.dart';
import '../models/priority.dart';
import 'home.dart';

class TaskController {
  var nameControl = TextEditingController();

  late Observable<bool> withDueDate;
  late Observable<DateTime> dueDate;
  late ValueKey id;
  late Priority priority;

  TaskController(TaskModel model) {
    id = model.id;
    withDueDate = Observable(model.dueDate.value != null);
    dueDate = Observable(model.dueDate.value ?? DateTime.now());
    nameControl.text = model.name.value ?? '';
    priority = model.priority.value;
  }

  void saveData() {
    logger.i('Save task data');
    var controller = GetIt.I<HomeController>();
    bool isCreating = false;
    //Проверка наличия элемента с таким id в списке
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
        task.priority.value = priority;
        task.dueDate.value = withDueDate.value ? dueDate.value : null;
        controller.saveTask(task, isCreating);
      },
    );
  }
}
