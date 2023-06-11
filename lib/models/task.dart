import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class TaskModel {
  late UniqueKey id;
  late Observable <String?> name;
  late Observable <String?> description;
  late Observable <DateTime?>  dueDate;
  late Observable <Priority> priority;
  late Observable<bool> isCompleted;

  TaskModel(
      {id,
      name,
      description,
      dueDate,
      priority = Priority.regular,
      isCompleted = false}) {
    this.id = id ?? UniqueKey();
    this.name = Observable(name);
    this.description = Observable(description);
    this.dueDate = Observable(dueDate);
    this.priority = Observable(priority);
    this.isCompleted = Observable(isCompleted);
  }
}

enum Priority { low, regular, high, critical }
