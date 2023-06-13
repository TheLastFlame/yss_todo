import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/controllers/task.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/models/task.dart';
import 'package:yss_todo/pages/task/widgets/appbar.dart';
import 'package:yss_todo/pages/task/widgets/datepicker.dart';
import 'package:yss_todo/pages/task/widgets/priorityswitcher.dart';
import 'package:yss_todo/pages/task/widgets/taskdeletebtn.dart';

import '../../controllers/home.dart';
import '../../i18n/strings.g.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key, this.id});
  final int? id;

  @override
  Widget build(BuildContext context) {
    logger.i('Opening the task page');
    final arguments = ModalRoute.of(context)?.settings.arguments;
    var id = arguments != null ? (arguments as Map)['id'] : null;
    var task = id != null
        ? GetIt.I<HomeController>()
            .taskList
            .firstWhere((element) => element.id == id)
        : TaskModel();
    logger.i(id == null ? 'Its new task' : 'Task id: $id');

    logger.i('Task controller initialization');
    var controller = TaskController(task);

    logger.i('Drawing task page widgets');
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TaskAppBar(controller: controller),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    margin: const EdgeInsets.all(appPadding * 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: appPadding * 2),
                      child: TextField(
                        controller: controller.nameControl,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: t.taskpage.name,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: appPadding * 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: appPadding * 2),
                      child: TextField(
                        controller: controller.descriptionControl,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: t.taskpage.description,
                        ),
                        minLines: 5,
                        maxLines: null,
                      ),
                    ),
                  ),
                  PrioritySwitcher(controller: controller),
                  const Divider(height: 0),
                  DueDatePicker(controller: controller),
                  if (id != null) const Divider(height: 0),
                  if (id != null) TaskDeleteButton(model: task),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
