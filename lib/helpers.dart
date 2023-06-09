import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/ui/pages/task/taskinfo.dart';
import 'constants.dart';
import 'i18n/strings.g.dart';

double lerp(start, end, procent) => start + (end - start) * procent / 100;

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
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.commonwords.cancel),
        ),
        FilledButton  (
          onPressed: () {
            result = true;
            Navigator.of(context).pop();
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
                  child: TaskPage(),
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
