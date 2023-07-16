import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/logger.dart';
import 'constants.dart';
import 'domain/models/task.dart';
import 'i18n/strings.g.dart';
import 'navigation/navigation.dart';
import 'ui/pages/task/taskinfo_portrait.dart';

double lerp(start, end, procent) => start + (end - start) * procent / 100;

// мердж трёх списков
List<TaskModel> mergeLists(List<TaskModel> list1, List<TaskModel> list2,
    Map<String, DateTime> removeList) {
  final Map<String, TaskModel> map = {};

  for (final task in list1 + list2) {
    if (removeList.containsKey(task.id)) {
      if (task.changedAt!.isBefore(removeList[task.id]!)) continue;
    }

    if (map.containsKey(task.id)) {
      if (task.changedAt!.isBefore(map[task.id]!.changedAt!)) continue;
    }

    map[task.id] = task;
  }

  return map.values.toList();
}

// Вызывает диалог подтверждения
Future<bool> confirm(context) async {
  bool result = false;
  logger.i('A confirmation dialog is opened');
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.commonwords.confirmation),
      actions: [
        TextButton(
          onPressed: () => GetIt.I<Nav>().pop(context),
          child: Text(t.commonwords.cancel),
        ),
        FilledButton(
          onPressed: () {
            result = true;
            GetIt.I<Nav>().pop(context);
          },
          child: Text(t.commonwords.confirm),
        ),
      ],
    ),
  );
  logger.i('Result: $result');
  return result;
}

// Вызывает боттомщит со страницей создания таска
void taskCreatingDialog(context) {
  var scrollControl = GetIt.I<HomeController>().scrollControl;
  logger.i('Scroll down page animation');
  scrollControl
      .animateTo(scrollControl.position.maxScrollExtent,
          curve: Curves.easeIn, duration: animationsDuration)
      .then(
    (value) {
      logger.i('Task creation menu is open');
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: TaskPagePortrait(),
                ),
              ),
              SizedBox(
                height: MediaQuery.viewInsetsOf(context).bottom,
              ),
            ],
          );
        },
      );
    },
  );
}

bool isTablet(context) {
  return MediaQuery.sizeOf(context).width >= minTabletWidth &&
      MediaQuery.orientationOf(context) == Orientation.landscape;
}
