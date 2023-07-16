import 'package:flutter/material.dart';
import 'package:yss_todo/ui/pages/task/taskinfo_portrait.dart';

class TaskPageLandscape extends StatelessWidget {
  const TaskPageLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Center(child: Image.asset('assets/images/logo.png'))),
          const Expanded(child: TaskPagePortrait()),
        ],
      ),
    );
  }
}