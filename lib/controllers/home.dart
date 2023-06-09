

import 'package:mobx/mobx.dart';
import 'package:yss_todo/models/task.dart';

class HomeController {
  var taskList = <TaskModel>[].asObservable();
  var isComplitedVisible = false.obs();
}