import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/domain/models/priority.dart';
import 'package:yss_todo/domain/models/task.dart';
import 'package:yss_todo/navigation/navigation.dart';

import '../../../../i18n/strings.g.dart';

import 'package:intl/intl.dart';

class Task extends StatelessWidget {
  const Task(this.task, {super.key, this.first = false});
  final TaskModel task;
  final bool first;
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
      child: Observer(builder: (_) {
        return Dismissible(
          background: task.done.value
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
            //Шикарное точечное позиционирование иконки в пространстве
            //Вариант как на макете есть в коммитах, но, имхо, он хуже
            runInAction(
              () => iconBoxSize.value = lerp(
                      0,
                      MediaQuery.sizeOf(context).width,
                      details.progress * 100) -
                  2,
            );
          },
          key: ValueKey(task.id),
          dismissThresholds: const {
            DismissDirection.endToStart: 0.3,
            DismissDirection.startToEnd: 0.3
          },
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              Timer(
                  animationsDuration, () => controller.changeTaskStatus(task));
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
          child: TaskTile(first: first, task: task, controller: controller),
        );
      }),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.first,
    required this.task,
    required this.controller,
  });

  final bool first; // является ли тайл первым в списке
  final TaskModel task; // объект модели задачи
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
          shape: first
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(13)))
              : null,
          onTap: () => GetIt.I<Nav>().showTaskPage(task.id),

          // Изменение афигеннейших, просто лучших отступов, которые ска разные на разных платформах (гении, лять)
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),

          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(appPadding / 2),
                child: Checkbox(
                  // activeColor: Colors.green, хз, оно стрёмное
                  side: task.importance.value.index > 1
                      ? const BorderSide(color: Colors.red, width: 2)
                      : null,
                  onChanged: (val) =>
                      runInAction(() => controller.changeTaskStatus(task)),
                  value: task.done.value,
                ),
              ),
              // Иконка важности
              AnimatedSize(
                duration: animationsDuration,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: !task.done.value
                      ? Icon(
                          task.importance.value.icon,
                          color: task.importance.value.color,
                        )
                      : null,
                ),
              )
            ],
          ),
          contentPadding: const EdgeInsets.all(appPadding),

          title: Text(
            task.text.value ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: task.done.value ? TextDecoration.lineThrough : null,
              color: task.done.value
                  ? Theme.of(context).colorScheme.onBackground.withOpacity(0.6)
                  : null,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.titleHeight,
          // Иконка информации
          trailing: IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => GetIt.I<Nav>().showTaskPage(task.id),
          ),
          subtitle: task.deadline.value != null
              ? Text(
                  '${t.taskpage.until_short}: ${DateFormat.yMMMMd().format(task.deadline.value!)}',
                  style: TextStyle(
                    color: task.done.value
                        ? Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6)
                        : null,
                  ),
                )
              : null,
        );
      },
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
        child: ConstrainedBox(
          // 48 - размеры чекбокса
          constraints: const BoxConstraints(
            maxWidth: appPadding * 3 + 48,
          ),
          child: Observer(
            builder: (_) {
              return SizedBox(
                width: max(iconBoxSize.value, 24),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
