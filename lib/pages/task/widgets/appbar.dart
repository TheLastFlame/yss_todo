import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/controllers/task.dart';
import 'package:yss_todo/models/task.dart';

import '../../../constants.dart';
import '../../../controllers/home.dart';
import '../../../i18n/strings.g.dart';

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({
    super.key,
    required this.controller,
  });

  final TaskController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close)),
      title: Text(t.taskpage.task),
      leadingWidth: 56 + appPadding * 3,
      titleSpacing: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: appPadding * 3),
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                var tasks = GetIt.I<HomeController>().taskList;
                bool isCreating = false;
                var task = tasks.firstWhere(
                  (e) => e.id == controller.id,
                  orElse: () {
                    isCreating = true;
                    return TaskModel();
                  },
                );
                Timer(
                  animationsDuration,
                  () => runInAction(
                    () {
                      task.id = controller.id;
                      task.name.value = controller.nameControl.text;
                      task.description.value =
                          controller.descriptionControl.text != ''
                              ? controller.descriptionControl.text
                              : null;
                      task.priority.value = controller.priority;
                      task.dueDate.value = controller.withDueDate.value
                          ? controller.dueDate.value
                          : null;

                      if (isCreating) {
                        tasks.add(task);
                      }
                    },
                  ),
                );
              },
              child: Text(t.taskpage.save)),
        )
      ],
    );
  }
}
