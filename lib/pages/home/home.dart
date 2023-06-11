import 'package:flutter/material.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/pages/home/widgets/appbar.dart';
import 'package:yss_todo/pages/home/widgets/tasklist.dart';
import '../task/taskinfo.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollControl = ScrollController();
    return Scaffold(
      body: CustomScrollView(
        controller: scrollControl,
        slivers: [
          HomeAppBar(scrollControl: scrollControl),
          const TaskList(),
          //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
          const SliverToBoxAdapter(
            child: SizedBox(height: 102),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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

          // runInAction(() => GetIt.I<HomeController>().taskList.add(
          //       TaskModel(
          //           name: 'Test',
          //           description: 'очень много много мяса',
          //           // until: DateTime.now(),
          //           priority: Priority.regular),
          //     ));
          // Timer(const Duration(milliseconds: 250), () {
          //   scrollControl.animateTo(scrollControl.position.maxScrollExtent,
          //       curve: Curves.easeIn, duration: animationsDuration);
          // });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
