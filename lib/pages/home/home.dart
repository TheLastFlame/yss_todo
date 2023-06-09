import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/controllers/home.dart';
import 'package:yss_todo/models/task.dart';
import 'package:yss_todo/pages/home/widgets/appbar.dart';
import 'package:yss_todo/pages/home/widgets/tasklist.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollControl = ScrollController();
    var controller = HomeController();
    return Scaffold(
      body: CustomScrollView(
        controller: scrollControl,
        slivers: [
          HomeAppBar(scrollControl: scrollControl),
          TaskList(controller: controller),
          //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
          const SliverToBoxAdapter(
            child: SizedBox(height: 102),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return const Placeholder();
          //   },
          // );

          runInAction(() => controller.taskList.add(
                TaskModel(
                    id: 1,
                    name: 'Test',
                    description:
                        'очень много много мяса. хе хе хе хе хе fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
                    until: DateTime.now(),
                    priority: Priority.regular),
              ));
          Timer(const Duration(milliseconds: 250), () {
            scrollControl.animateTo(
                scrollControl.position.maxScrollExtent,
                curve: Curves.bounceIn,
                duration: animationsDuration);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
