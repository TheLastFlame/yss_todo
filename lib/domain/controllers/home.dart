import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/data/api/api.dart';
import 'package:yss_todo/data/storage/tasklist.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/domain/models/task.dart';

import '../../constants.dart';
import '../models/resstatuses.dart';

class HomeController {
  var scrollControl = ScrollController();

  var taskList = <TaskModel>[].asObservable();

  var isComplitedVisible = false.obs();

  final _db = GetIt.I<TaskListDB>();
  final _api = GetIt.I<TasksAPI>();

 final responceError = Observable(ResponseStatus.normal);

  HomeController._init();

  static Future<HomeController> init() async {
    var controller = HomeController._init();
    controller.taskList.addAll(await controller._db.getAll());
    return controller;
  }

  void getTasks() async {
    Map<String, dynamic> res = await _api.getAll();
    if (res['status'] == ResponseStatus.normal) {
      taskList.addAll(res['tasks']);
    } else {
      
      runInAction(() => responceError.value = res['status']);
    }
  }

  void removeTask(String id) {
    logger.i('Task $id removing...');
    Timer(
      animationsDuration,
      () => taskList.removeWhere((element) => element.id == id),
    );
    _db.remove(id);
  }

  void saveTask(TaskModel task, {bool isCreating = false}) {
    logger.i('Task ${task.id} data saving...');
    if (isCreating) Timer(animationsDuration, () => taskList.add(task));
    _db.save(task);
  }

  void changeTaskStatus(TaskModel task) {
    logger.i(
      'Change task ${task.id} status to ${!task.done.value}',
    );
    task.done.toggle();
    saveTask(task);
  }
}
