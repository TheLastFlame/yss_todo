import 'package:get_storage/get_storage.dart';
import 'package:yss_todo/logger.dart';

import '../../domain/models/task.dart';

abstract interface class TaskListDB {
  Future<void> save(TaskModel task);
  Future<void> remove(String taskID);
  Future<Iterable<TaskModel>> getAll();
}

class TaskListDBGetStorage implements TaskListDB {
  final _taskStorage = GetStorage('TaskList');

  @override
  Future<void> save(TaskModel task) async {
    await _taskStorage.write(task.id.toString(), task.toJson());
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
    logger.i(values);
    return values.map(
      (e) => TaskModel.fromJson(e),
    );
  }

  static Future<TaskListDBGetStorage> init() async {
    await GetStorage.init('TaskList');
    return TaskListDBGetStorage();
  }
}
