import 'package:flutter/material.dart';
import 'package:yss_todo/models/task.dart';
import 'package:yss_todo/pages/home/widgets/appbar.dart';
import 'package:yss_todo/pages/home/widgets/task.dart';
import '../../constants.dart';

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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: appPadding),
                  child: Column(
                    children: List.generate(
                      10,
                      (index) => Task(
                        TaskModel(
                            id: 1, name: 'Test', description: 'очень много много мяса. хе хе хе хе хе fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd', until: DateTime.now(), priority: Priority.regular),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
          const SliverToBoxAdapter(child: SizedBox(height: 80),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const Placeholder();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
