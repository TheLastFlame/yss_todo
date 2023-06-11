import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/pages/home/widgets/task.dart';

import '../../../constants.dart';
import '../../../controllers/home.dart';
import '../../../i18n/strings.g.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = GetIt.I<HomeController>();
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
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        return Task(controller.taskList[index], index: index);
                      },
                    ),
                  ),
                  if (controller.taskList.isNotEmpty)
                    const Divider(
                      height: 0,
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
                          padding: EdgeInsets.all(appPadding * 2),
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
