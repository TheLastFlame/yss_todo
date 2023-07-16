import 'package:flutter/material.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/ui/pages/task/taskinfo_landscape.dart';
import 'package:yss_todo/ui/pages/task/taskinfo_portrait.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key, this.taskId});

  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return isTablet(context)
        ? const TaskPageLandscape()
        : TaskPagePortrait(taskId: taskId);
  }
}
