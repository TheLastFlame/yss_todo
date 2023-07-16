import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/controllers/home.dart';
import 'widgets/appbar.dart';
import 'widgets/tasklist.dart';

class HomePagePortrait extends StatelessWidget {
  const HomePagePortrait({
    super.key,
    required this.controller,
    this.isTablet = false,
  });

  final HomeController controller;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final screenThird = MediaQuery.sizeOf(context).height / 3;

    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        runInAction(() => controller.appBarExpandProcent.value = min(
            controller.scrollControl.offset / (screenThird - 56) * 100, 100));
        // 56 - высота свёрнутого аппбара
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async => controller.synchronization(),
        child: CustomScrollView(
          controller: controller.scrollControl,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            if (!isTablet) const HomeAppBar(),
            const TaskList(),

            //Свободное место под размер FAB, чтобы он не перекрывал нижние элементы
            // 48 - высота FAB + 16 - высота отступа снизу + 16 - сверху + bottom navigation
            SliverToBoxAdapter(
              child: SizedBox(
                  height:
                      70 + MediaQuery.systemGestureInsetsOf(context).bottom),
            )
          ],
        ),
      ),
    );
  }
}
