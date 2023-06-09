import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:yss_todo/pages/home/widgets/task.dart';

import '../../../constants.dart';
import '../../../controllers/home.dart';
import '../../../i18n/strings.g.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: controller.taskList.isNotEmpty
                ? const EdgeInsets.symmetric(vertical: appPadding)
                : EdgeInsets.zero,
            child: Observer(builder: (_) {
              return Column(
                children: [
                  AnimatedSize(
                    alignment: Alignment.topCenter,
                    duration: animationsDuration,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: controller.taskList
                          .map(
                            (element) => Task(element),
                          )
                          .toList(),
                    ),
                  ),
                  if (controller.taskList.isNotEmpty)
                    const Divider(
                      height: appPadding,
                    ),
                  InkWell(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            controller.taskList.isEmpty ? 13 : 0),
                        bottom: const Radius.circular(13)),
                    onTap: () {},
                    child: ListTile(
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: appPadding),
                        leading: const Padding(
                          padding: EdgeInsets.all(appPadding*1.5),
                          child: Icon(Icons.add),
                        ),
                        title: Text(t.homepage.newtask)),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
