import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/domain/models/resstatuses.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/ui/pages/home/widgets/appbar.dart';
import 'package:yss_todo/ui/pages/home/widgets/syncindicator.dart';
import 'package:yss_todo/ui/pages/home/widgets/tasklist.dart';

import '../../../i18n/strings.g.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final ReactionDisposer errorHandler;
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = GetIt.I<HomeController>();
    controller.synchronization();
    logger.i('Init errors checker');
    errorHandler = autorun(
      (p0) {
        if (controller.responceError.value != ResponseStatus.normal) {
          logger.e(controller.responceError.value.toString());
          String text;
          switch (controller.responceError.value) {
            case ResponseStatus.noInternet:
              text = t.errors.no_internet;
              break;
            case ResponseStatus.iternalProblem:
              text = t.errors.iternal;
              break;
            default:
              text = t.errors.unknown;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(text),
              action: SnackBarAction(
                label: t.commonwords.retry,
                onPressed: () {
                  controller.synchronization();
                },
              ),
            ),
          );

          //По неизвестной мне причине SnackBar перестал закрываться самостоятельно. Пофиксить не удалось. Костыль:
          Timer(const Duration(seconds: 5), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          });

          controller.responceError.value = ResponseStatus.normal;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    logger.i('Disposing');
    errorHandler();
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Home page opening');

    final screenThird = MediaQuery.sizeOf(context).height / 3;

    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollMetricsNotification>(
            onNotification: (notification) {
              runInAction(() => controller.appBarExpandProcent.value = min(
                  controller.scrollControl.offset / (screenThird - 56) * 100,
                  100));
              // 56 - высота свёрнутого аппбара
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async => controller.synchronization(),
              child: CustomScrollView(
                controller: controller.scrollControl,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const HomeAppBar(),
                  const TaskList(),

                  //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
                  // 48 - высота FAB + 16 - высота отступа снизу + 16 - сверху + bottom navigation
                  SliverToBoxAdapter(
                    child: SizedBox(
                        height: 70 +
                            MediaQuery.systemGestureInsetsOf(context).bottom),
                  )
                ],
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SyncIndicator(),
              SyncIndicator(),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('FAB'),
        onPressed: () => taskCreatingDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
