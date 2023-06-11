import 'package:flutter/material.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/pages/home/widgets/appbar.dart';
import 'package:yss_todo/pages/home/widgets/tasklist.dart';

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
          TaskList(scrollControl: scrollControl),
          //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
          const SliverToBoxAdapter(
            child: SizedBox(height: 102),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => taskCreatingDialog(context, scrollControl),
        child: const Icon(Icons.add),
      ),
    );
  }
}
