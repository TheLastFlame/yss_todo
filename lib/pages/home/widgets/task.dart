import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/controllers/home.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/models/task.dart';

import '../../../i18n/strings.g.dart';

import 'package:intl/intl.dart';

class Task extends StatelessWidget {
  const Task(this.task, {super.key, this.first = false, this.last = false});
  final TaskModel task;
  final bool first, last;
  @override
  Widget build(BuildContext context) {
    var iconBoxSize = 0.0.obs();
    var controller = GetIt.I<HomeController>();
    return ClipRRect(
      borderRadius: first
          ? const BorderRadius.vertical(
              top: Radius.circular(13),
            )
          : BorderRadius.zero,
      child: Observer(
        builder: (_) {
          return Dismissible(
            background: task.isCompleted.value
                ? DismisBackground(
                    iconBoxSize: iconBoxSize,
                    icon: Icons.close,
                    color: Colors.grey,
                    alignment: Alignment.centerLeft,
                  )
                : DismisBackground(
                    iconBoxSize: iconBoxSize,
                    icon: Icons.done,
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                  ),
            secondaryBackground: DismisBackground(
              iconBoxSize: iconBoxSize,
              icon: Icons.delete,
              color: Colors.red,
              alignment: Alignment.centerRight,
            ),
            onUpdate: (details) {
              runInAction(
                () => iconBoxSize.value = lerp(
                        0,
                        MediaQuery.sizeOf(context).width - appPadding * 4,
                        details.progress * 100) -
                    appPadding * 2,
              );
            },
            key: task.id,
            dismissThresholds: const {
              DismissDirection.endToStart: 0.3,
              DismissDirection.startToEnd: 0.3
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                Timer(animationsDuration,
                    () => controller.changeTaskStatus(task));
                return !controller.isComplitedVisible.value;
              } else {
                return confirm(context);
              }
            },
            onDismissed: (DismissDirection direction) {
              if (direction != DismissDirection.startToEnd) {
                controller.removeTask(task.id);
              }
            },
            child: TaskTile(
                first: first, task: task, controller: controller, last: last),
          );
        },
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.first,
    required this.task,
    required this.controller,
    required this.last,
  });

  final bool first;
  final TaskModel task;
  final HomeController controller;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: first
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)))
          : null,
      onTap: () =>
          Navigator.of(context).pushNamed('/task', arguments: {'id': task.id}),
      visualDensity: const VisualDensity(horizontal: -4),
      leading: Padding(
        padding: const EdgeInsets.all(appPadding / 2),
        child: Observer(builder: (_) {
          return Checkbox(
            onChanged: (val) =>
                runInAction(() => controller.changeTaskStatus(task)),
            value: task.isCompleted.value,
          );
        }),
      ),
      contentPadding: EdgeInsets.only(
          left: appPadding, right: appPadding, bottom: last ? appPadding : 0),
      trailing: IconButton(
        onPressed: () => Navigator.of(context).pushNamed(
          '/task',
          arguments: {'id': task.id},
        ),
        icon: const Icon(Icons.info_outline),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: appPadding),
        child: Text(
          task.name.value ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
                task.isCompleted.value ? TextDecoration.lineThrough : null,
            color: task.isCompleted.value
                ? Theme.of(context).colorScheme.onBackground.withOpacity(0.6)
                : null,
          ),
        ),
      ),
      isThreeLine: task.description.value != null || task.dueDate.value != null,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.description.value != null)
            Text(
              task.description.value!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7)),
            ),
          if (task.dueDate.value != null)
            Text(
              '${t.taskpage.until_short}: ${DateFormat.yMMMMd().format(task.dueDate.value!)}',
            ),
        ],
      ),
    );
  }
}

class DismisBackground extends StatelessWidget {
  const DismisBackground({
    super.key,
    required this.iconBoxSize,
    required this.color,
    required this.icon,
    required this.alignment,
  });

  final Observable<double> iconBoxSize;
  final Color color;
  final IconData icon;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Align(
          alignment: alignment,
          child: Observer(builder: (_) {
            return SizedBox(
              width: max(iconBoxSize.value, 0),
              child: Align(
                alignment: alignment * -1,
                child: Icon(icon),
              ),
            );
          })),
    );
  }
}
