import 'package:get_storage/get_storage.dart';
import 'package:yss_todo/logger.dart';

import '../../domain/models/task.dart';

abstract interface class TaskListDB {
  Future<bool> getSyncStatus();
  Future<void> setSyncStatus(bool status);
  Future<void> addToRemove(String taskId, DateTime time);
  Future<Map<String, DateTime>> getRemoveList();
  Future<void> eraseRemoveList();

  Future<void> save(TaskModel task);
  Future<void> remove(String taskID);
  Future<Iterable<TaskModel>> getAll();
  Future<void> updateAll(List<TaskModel> tasks);
}

class TaskListDBGetStorage implements TaskListDB {
  final _taskStorage = GetStorage('TaskList');
  final _syncStorage = GetStorage('SyncStatus');

  @override
  Future<bool> getSyncStatus() async {
    return _syncStorage.read('SyncStatus') ?? true;
  }

  @override
  Future<void> setSyncStatus(bool status) async {
    _syncStorage.write('SyncStatus', status);
  }

  @override
  Future<void> addToRemove(String taskId, DateTime time) async {
    _syncStorage.write(taskId, time.toString());
  }

  @override
  Future<Map<String, DateTime>> getRemoveList() async {
    List keys = _syncStorage.getKeys().toList();
    Map<String, DateTime> values = {
      for (var key in keys)
        key: DateTime.tryParse(_syncStorage.read(key).toString()) ?? DateTime.now()
    };
    values.remove('SyncStatus');
    if (values.isEmpty) return {};
    logger.i(values);
    return values;
  }

  @override
  Future<void> eraseRemoveList() async {
    var status = await getSyncStatus();
    _syncStorage.erase();
    setSyncStatus(status);
  }

  @override
  Future<void> save(TaskModel task) async {
    await _taskStorage.write(task.id, task.toJson());
    logger.i('Task ${task.id} data is saved');
  }

  @override
  Future<void> remove(String taskID) async {
    await _taskStorage.remove(taskID);
    logger.i('Task $taskID data is removed');
  }

  @override
  Future<Iterable<TaskModel>> getAll() async {
    logger.i('Getting a list of saved tasks...');
    List values = _taskStorage.getValues().toList();
    if (values.isEmpty) return [];
    logger.i(values);
    return values.map(
      (e) => TaskModel.fromJson(e),
    );
  }

  @override
  Future<void> updateAll(List<TaskModel> tasks) async {
    logger.w('Database erasering');
    await _taskStorage.erase();
    for (var e in tasks) {
      save(e);
    }
  }

  static Future<TaskListDBGetStorage> init() async {
    await GetStorage.init('TaskList');
    await GetStorage.init('SyncStatus');
    return TaskListDBGetStorage();
  }
}
