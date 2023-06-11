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
  const Task(this.task, {super.key, required this.index});
  final TaskModel task;
  final int index;
  @override
  Widget build(BuildContext context) {
    var iconBoxSize = 0.0.obs();
    return ClipRRect(
      borderRadius: index == 0
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
              //Шикарное точечное позиционирование иконки в пространстве
              runInAction(
                () => iconBoxSize.value = lerp(
                        0,
                        MediaQuery.sizeOf(context).width,
                        details.progress * 100) -
                    2,
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
                    () => runInAction(() => task.isCompleted.toggle()));
                return GetIt.I<HomeController>().isComplitedVisible.value;
              }
              return true;
              // return false;
            },
            onDismissed: (DismissDirection direction) {
              runInAction(() => GetIt.I<HomeController>()
                  .taskList
                  .removeWhere((element) => element.id == task.id));
            },
            child: ListTile(
              shape: index == 0
                  ? const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(13)))
                  : null,
              onTap: () => Navigator.of(context)
                  .pushNamed('/task', arguments: {'id': task.id}),
              visualDensity: const VisualDensity(horizontal: -4),
              leading: Padding(
                padding: const EdgeInsets.all(appPadding / 2),
                child: Observer(builder: (_) {
                  return Checkbox(
                    onChanged: (val) =>
                        runInAction(() => task.isCompleted.toggle()),
                    value: task.isCompleted.value,
                  );
                }),
              ),
              contentPadding: EdgeInsets.only(
                  left: appPadding,
                  right: appPadding,
                  bottom: index == GetIt.I<HomeController>().taskList.length - 1
                      ? appPadding
                      : 0),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: appPadding),
                child: Text(
                  task.name.value ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          );
        },
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
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxHeight,
              ),
              child: Observer(builder: (_) {
                return SizedBox(
                    width: max(iconBoxSize.value, 0), child: Icon(icon));
              }),
            );
          })),
    );
  }
}
