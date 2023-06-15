import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/controllers/task.dart';

import '../../../constants.dart';
import '../../../i18n/strings.g.dart';

class DueDatePicker extends StatelessWidget {
  const DueDatePicker({
    super.key,
    required this.controller,
  });

  final TaskController controller;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AnimatedSize(
          duration: animationsDuration,
          alignment: Alignment.topCenter,
          child: ListTile(
            title: Text(t.taskpage.until),
            onTap: () {
              if (!controller.withDueDate.value) {
                controller.withDueDate.toggle();
              }
              showDatePicker(
                      context: context,
                      initialDate: controller.dueDate.value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100))
                  .then(
                (value) {
                  if (value != null) {
                    runInAction(() => controller.dueDate.value = value);
                  }
                },
              );
            },
            subtitle: controller.withDueDate.value
                ? Text(
                    DateFormat.yMMMMd().format(controller.dueDate.value),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : null,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: appPadding * 3,
              vertical: appPadding * 3,
            ),
            trailing: Switch(
              value: controller.withDueDate.value,
              onChanged: (val) {
                controller.withDueDate.toggle();
              },
            ),
          ),
        );
      },
    );
  }
}
