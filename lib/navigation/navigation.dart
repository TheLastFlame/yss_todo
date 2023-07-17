import 'package:flutter/material.dart';

abstract class Nav {
  void showTaskPage(String taskId);
  void pop(BuildContext context);
}
