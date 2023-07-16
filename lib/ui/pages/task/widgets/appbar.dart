import 'package:flutter/material.dart';
import 'package:yss_todo/domain/controllers/task.dart';

import '../../../../constants.dart';
import '../../../../i18n/strings.g.dart';

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({
    super.key,
    required this.controller,
  });

  final TaskController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
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
            key: const ValueKey('SaveBtn'),
              onPressed: () {
                Navigator.pop(context);
                controller.saveData();
              },
              child: Text(t.taskpage.save)),
        )
      ],
    );
  }
}
