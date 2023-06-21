import 'package:flutter/material.dart';
import 'package:yss_todo/domain/controllers/task.dart';

import '../../../../constants.dart';
import '../../../../i18n/strings.g.dart';
import '../../../../domain/models/priority.dart';

class PrioritySwitcher extends StatelessWidget {
  const PrioritySwitcher({
    super.key,
    required this.controller,
  });

  final TaskController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: appPadding * 3,
        vertical: appPadding * 3,
      ),
      title: Text(t.taskpage.priority),
      trailing: DropdownMenu<int>(
          initialSelection: controller.priority.index,
          dropdownMenuEntries: Priority.values
              .map(
                (value) => DropdownMenuEntry<int>(
                  value: value.index,
                  leadingIcon: Icon(value.icon),
                  label: value.name,
                ),
              )
              .toList(),
          onSelected: (int? value) {
            controller.priority = Priority.values[value!];
          }),
    );
  }
}
