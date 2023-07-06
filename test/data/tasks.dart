import 'package:yss_todo/domain/models/task.dart';

final now = DateTime.now();

final emptyList = <TaskModel>[];

final list1 = [
  TaskModel(id: '1', name: 'Task 1', changedAt: now),
  TaskModel(id: '2', name: 'Task 2', changedAt: now),
  TaskModel(id: '3', name: 'Task 3', changedAt: now),
  TaskModel(id: '4', name: 'Task 4', changedAt: now),
];

final list2 = [
  TaskModel(
      id: '3',
      name: 'Task 3 updated',
      changedAt: now.add(const Duration(days: 1))),
  TaskModel(id: '5', name: 'Task 5', changedAt: now),
  TaskModel(id: '6', name: 'Task 6', changedAt: now),
  TaskModel(id: '7', name: 'Task 7', changedAt: now),
];

final list3 = [
  TaskModel(id: '5', name: 'Task 5', changedAt: now),
  TaskModel(id: '6', name: 'Task 6', changedAt: now),
  TaskModel(id: '7', name: 'Task 7', changedAt: now),
  TaskModel(id: '8', name: 'Task 8', changedAt: now),
];

final list4 = [
  TaskModel(id: '1', name: 'Task 1', changedAt: now),
  TaskModel(id: '2', name: 'Task 2', changedAt: now),
  TaskModel(
      id: '3',
      name: 'Task 3 updated',
      changedAt: now.add(const Duration(days: 1))),
  TaskModel(id: '4', name: 'Task 4', changedAt: now),
  TaskModel(id: '5', name: 'Task 5', changedAt: now),
  TaskModel(id: '6', name: 'Task 6', changedAt: now),
];

final removeList1 = {
  '1': now.add(const Duration(seconds: 1)),
  '2': now.add(const Duration(seconds: 1)),
  '3': now.add(const Duration(seconds: 1)),
  '4': now.add(const Duration(seconds: 1)),
};

final removeList2 = {
  '7': now.add(const Duration(seconds: 1)),
};
