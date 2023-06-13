import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/models/task.dart';

import '../constants.dart';

class HomeController {
  var scrollControl = ScrollController();

  var taskList = <TaskModel>[].asObservable();
  var isComplitedVisible = false.obs();

  final _taskStorage = GetStorage('TaskList');
  HomeController() {
    logger.i('Getting a list of saved tasks...');
    var values = _taskStorage.getValues().toList();

    for (var i = 0; i < values.length; i++) {
      taskList.add(TaskModel.fromJSON(values[i]));
    }
    logger.i(values);
  }

  void removeTask(id) {
    logger.i('Task${id.value} removing...');
    Timer(animationsDuration,
        () => taskList.removeWhere((element) => element.id == id));
    _taskStorage.remove(id.toString()).then(
          (value) => logger.i('Task${id.value} data is removed'),
        );
  }

  void saveTask(TaskModel task, bool isCreating) {
    logger.i('Task${task.id.value} data saving...');
    if (isCreating) Timer(animationsDuration, () => taskList.add(task));

    _taskStorage.write(task.id.toString(), task.toJSON()).then(
          (value) => logger.i('Task${task.id.value} data is saved'),
        );
  }

  void changeTaskStatus(TaskModel task) {
    logger
        .i('Change task${task.id.value} status to ${!task.isCompleted.value}');
    task.isCompleted.toggle();
    saveTask(task, false);
  }
}
