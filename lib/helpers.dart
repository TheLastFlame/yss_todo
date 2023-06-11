import 'package:flutter/material.dart';
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
