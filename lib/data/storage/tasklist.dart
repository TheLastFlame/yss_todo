import '../../domain/models/task.dart';

abstract interface class TaskListDB {
  Future<void> save (TaskModel task);
  Future<void> remove (String taskID);
}

// class TaskListDB_GS implements TaskListDB {
  
// }