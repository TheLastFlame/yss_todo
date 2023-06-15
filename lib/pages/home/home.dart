import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/controllers/home.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/pages/home/widgets/appbar.dart';
import 'package:yss_todo/pages/home/widgets/tasklist.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    logger.i('Home page opening');
    return Scaffold(

      body: CustomScrollView(
        controller: GetIt.I<HomeController>().scrollControl,
      
        slivers: const [
          
          HomeAppBar(),
          TaskList(),

          //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
          // 102 - высота FAB
          SliverToBoxAdapter(
            child: SizedBox(height: 102),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => taskCreatingDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
