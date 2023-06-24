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
  save,
  getAll,
  remove,
}

class HomeController {
  var scrollControl = ScrollController();

  var taskList = <TaskModel>[].asObservable();

  var isComplitedVisible = false.obs();

  final _db = GetIt.I<TaskListDB>();
  final _api = GetIt.I<TasksAPI>();

  final responceError = Observable(ResponseStatus.normal);
  final lastAction = Observable(Action.getAll);
  var isLoading = true.obs();

  HomeController() {
    getTasks();
  }

  void getTasks() async {
    runInAction(() => isLoading.value = true);
    taskList.addAll(await _db.getAll());
    Map<String, dynamic> res = await _api.getAll();
    runInAction(() => isLoading.value = false);

    if (res['status'] == ResponseStatus.normal) {
      taskList.clear();
      taskList.addAll(res['tasks']);
    } else {
      runInAction(() {
        lastAction.value = Action.getAll;
        responceError.value = res['status'];
      });
    }
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
    runInAction(() => isLoading.value = false);

    if (resStatus != ResponseStatus.normal) {
      runInAction(() {
        lastAction.value = Action.remove;
        responceError.value = resStatus;
      });
    }
  }

  void saveTask(TaskModel task, {bool isCreating = false}) async {
    logger.i('Task ${task.id} data saving...');

    runInAction(() => isLoading.value = true);
    _db.save(task);

    if (isCreating) {
      Timer(animationsDuration, () => taskList.add(task));
      Timer(
          animationsDuration * 2,
          () => scrollControl.animateTo(scrollControl.position.maxScrollExtent,
              duration: animationsDuration, curve: Curves.linear));
      await _api.addTask(task);
    } else {
      await _api.editTask(task);
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
