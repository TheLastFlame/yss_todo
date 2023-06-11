import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/pages/home/widgets/task.dart';

import '../../../constants.dart';
import '../../../controllers/home.dart';
import '../../../helpers.dart';
import '../../../i18n/strings.g.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.scrollControl});

  final ScrollController scrollControl;

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
              var list = Computed(() => controller.taskList
                  .where((el) =>
                      controller.isComplitedVisible.value ||
                      !el.isCompleted.value)
                  .toList());
              return Column(
                children: [
                  AnimatedSize(
                    alignment: Alignment.topCenter,
                    duration: animationsDuration,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.value.length,
                      itemBuilder: (context, index) => Task(
                        list.value[index],
                        first: index == 0,
                        last: index == list.value.length-1,
                      ),
                    ),
                  ),
                  if (list.value.isNotEmpty)
                    const Divider(
                      height: 0,
                    ),
                  InkWell(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            controller.taskList.isEmpty ? 13 : 0),
                        bottom: const Radius.circular(13)),
                    onTap: () => taskCreatingDialog(context, scrollControl),
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
