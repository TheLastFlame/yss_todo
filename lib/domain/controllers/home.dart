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
  var appBarExpandProcent = 0.0.obs();

  var taskList = <TaskModel>[].asObservable();

  var isComplitedVisible = false.obs();

  final _db = GetIt.I<TaskListDB>();
  final _api = GetIt.I<TasksAPI>();

  final responceError = Observable(ResponseStatus.normal);
  var isLoading = true.obs();

  HomeController._init();

  static Future<HomeController> init() async {
    var controller = HomeController._init();
    controller.taskList.addAll(await controller._db.getAll());
    return controller;
  }

  List<TaskModel> _mergeLists(List<TaskModel> list1, List<TaskModel> list2,
      Map<String, DateTime> removeList) {
    final Map<String, TaskModel> map = {};

    for (final task in list1 + list2) {
      if (removeList.containsKey(task.id)) {
        if (task.changedAt!.isBefore(removeList[task.id]!)) continue;
      }

      if (map.containsKey(task.id)) {
        if (task.changedAt!.isBefore(map[task.id]!.changedAt!)) continue;
      }

      map[task.id] = task;
    }

    return map.values.toList();
  }

  void synchronization() async {
    runInAction(() => isLoading.value = true);

    Map<String, dynamic> res = await _api.getAll();

    if (res['status'] == ResponseStatus.normal) {
      if (!(await _db.getSyncStatus())) {
        res = await _api.updateAll(
          _mergeLists(
              taskList, res['tasks'].toList(), await _db.getRemoveList()),
        );
        if (res['status'] != ResponseStatus.normal) {
          responceError.value = res['status'];
          runInAction(() => isLoading.value = false);
          return;
        }
      }
      taskList.clear();
      taskList.addAll(res['tasks']);
      _db.updateAll(taskList);
      _db.setSyncStatus(true);
    } else {
      runInAction(() {
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
      _db.setSyncStatus(false);
      _db.addToRemove(id, DateTime.now());
      runInAction(() {
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
      runInAction(() => responceError.value = res);
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
