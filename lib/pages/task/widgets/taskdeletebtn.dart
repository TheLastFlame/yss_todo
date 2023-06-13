import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../controllers/home.dart';
import '../../../helpers.dart';
import '../../../i18n/strings.g.dart';
import '../../../models/task.dart';

class TaskDeleteButton extends StatelessWidget {
  const TaskDeleteButton({
    super.key,
    required this.model,
  });

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding, vertical: appPadding),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () => confirm(context).then(
          (value) {
            if (value) {
              GetIt.I<HomeController>().removeTask(model);
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: appPadding * 3, horizontal: appPadding*1.5),
          child: Row(
            children: [
              const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              const SizedBox(
                width: appPadding,
              ),
              Text(
                t.taskpage.delete,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
