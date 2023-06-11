import 'package:flutter/material.dart';
import 'package:yss_todo/pages/task/taskinfo.dart';
import 'constants.dart';
import 'i18n/strings.g.dart';

double lerp(start, end, procent) => start + (end - start) * procent / 100;

Future<bool> confirm(context) async {
  bool result = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.commonwords.confirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.commonwords.cancel),
        ),
        TextButton(
          onPressed: () => result = true,
          child: Text(t.commonwords.confirm),
        ),
      ],
    ),
  );
  return result;
}

void taskCreatingDialog(context, scrollControl) {
  scrollControl
      .animateTo(scrollControl.position.maxScrollExtent,
          curve: Curves.easeIn, duration: animationsDuration)
      .then(
        (value) => showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: appPadding * 2,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16))),
                  ),
                  const TaskPage(),
                  SizedBox(
                    height: MediaQuery.viewInsetsOf(context).bottom,
                  ),
                ],
              ),
            );
          },
        ),
      );
}
