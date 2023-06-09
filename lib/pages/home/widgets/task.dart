import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/models/task.dart';

class Task extends StatelessWidget {
  const Task(this.task, {super.key});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    var iconBoxSize = 0.0.obs();
    return ClipRRect(
      child: Dismissible(
        background: DismisBackground(
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
            () => iconBoxSize.value = lerp(0, MediaQuery.sizeOf(context).width,
                    details.progress * 100) -
                2,
          );
        },
        key: ValueKey<int>(task.id),
        onDismissed: (DismissDirection direction) {},
        dismissThresholds: const {
          DismissDirection.endToStart: 0.3,
          DismissDirection.startToEnd: 0.3
        },
        confirmDismiss: (direction) async {
          // return direction != DismissDirection.startToEnd;
          return false;
        },
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(appPadding / 2),
            child: Checkbox(
              onChanged: (val) {},
              value: true,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: appPadding),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
          title: Text(
            task.name,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: task.description != null || task.until != null,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description != null)
                Text(
                  task.description!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis
                ),
              if (task.until != null) Text(task.until.toString())
            ],
          ),
        ),
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
