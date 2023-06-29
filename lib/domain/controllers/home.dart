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

enum Action {
  add,
  edit,
  getAll,
  remove,
}

class HomeController {
  var scrollControl = ScrollController();
  var appBarExpandProcent = 0.0.obs();

  var taskList = <TaskModel>[].asObservable();

  var isComplitedVisible = false.obs();

  final _db = GetIt.I<TaskListDB>();
  final _api = GetIt.I<TasksAPI>();

  final responceError = Observable(ResponseStatus.normal);
  final lastAction = Observable(Action.getAll);
  var isLoading = true.obs();

  HomeController._init();

  static Future<HomeController> init() async {
    var controller = HomeController._init();
    controller.taskList.addAll(await controller._db.getAll());
    return controller;
  }

  void synchronization() async {
    runInAction(() => isLoading.value = true);

    Map<String, dynamic> res = await (await _db.getSyncStatus()
        ? _api.getAll()
        : _api.updateAll(taskList));

    if (res['status'] == ResponseStatus.normal) {
      taskList.clear();
      taskList.addAll(res['tasks']);
      _db.updateAll(taskList);
      _db.setSyncStatus(true);
    } else {
      runInAction(() {
        lastAction.value = Action.getAll;
        responceError.value = res['status'];
      });
    }

    runInAction(() => isLoading.value = false);
  }

  void removeTask(String id) async {
    logger.i('Task $id removing...');
    Timer(
      animationsDuration,
      () => taskList.removeWhere((element) => element.id == id),
    );

    runInAction(() => isLoading.value = true);

    await _db.remove(id);
    var resStatus = await _api.deleteTask(id);

    if (resStatus != ResponseStatus.normal) {
      runInAction(() {
        _db.setSyncStatus(false);
        lastAction.value = Action.remove;
        responceError.value = resStatus;
      });
    }

    runInAction(() => isLoading.value = false);
  }

  void saveTask(TaskModel task, {bool isCreating = false}) async {
    logger.i('Task ${task.id} data saving...');

    runInAction(() => isLoading.value = true);
    _db.save(task);

    ResponseStatus res;

    if (isCreating) {
      Timer(animationsDuration, () => taskList.add(task));
      Timer(
          animationsDuration * 2,
          () => scrollControl.animateTo(scrollControl.position.maxScrollExtent,
              duration: animationsDuration, curve: Curves.linear));
      res = await _api.addTask(task);
    } else {
      res = await _api.editTask(task);
    }
    if (res != ResponseStatus.normal) {
      _db.setSyncStatus(false);
    }
    runInAction(() => isLoading.value = false);
  }

  void changeTaskStatus(TaskModel task) {
    logger.i(
      'Change task ${task.id} status to ${!task.done.value}',
    );
    task.done.toggle();
    saveTask(task);
  }
}
