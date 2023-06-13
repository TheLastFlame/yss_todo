import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/models/task.dart';

import '../constants.dart';

class HomeController {
  var taskList = <TaskModel>[].asObservable();
  var isComplitedVisible = false.obs();

  final _taskStorage = GetStorage('TaskList');
  HomeController() {
    var values = _taskStorage.getValues().toList();
    for (var i = 0; i <  values.length; i++) {
      TaskModel.fromJSON(values[i]);
      taskList.add(TaskModel.fromJSON(values[i]));
    }
  }

  void removeTask(id) {
    runInAction(() => taskList.removeWhere((element) => element.id == id));
    _taskStorage.remove(id.toString());
  }

  void saveTask(TaskModel task, bool isCreating) {
    if (isCreating) Timer(animationsDuration, () => taskList.add(task));
    _taskStorage.write(task.id.toString(), task.toJSON());
  }

  void changeTaskStatus (TaskModel task) {
    task.isCompleted.toggle();
    saveTask(task, false);
  }
}
