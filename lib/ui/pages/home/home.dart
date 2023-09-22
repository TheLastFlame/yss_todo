import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/domain/models/resstatuses.dart';
import 'package:yss_todo/helpers.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/ui/pages/home/home_landscape.dart';
import 'package:yss_todo/ui/pages/home/widgets/syncindicator.dart';

import '../../../i18n/strings.g.dart';
import 'home_portrait.dart';

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

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Stack(
        children: [
          isTablet(context)
              ? HomePageLandscape(controller: controller)
              : HomePagePortrait(controller: controller),
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
