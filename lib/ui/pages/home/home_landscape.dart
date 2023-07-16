import 'package:flutter/material.dart';
import 'package:yss_todo/constants.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/ui/pages/home/home_portrait.dart';

import 'widgets/landscape_appbar.dart';

class HomePageLandscape extends StatelessWidget {
  const HomePageLandscape({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: appPadding),
                  child: LandscapeHomeAppBar(),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(appPadding * 2),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: HomePagePortrait(
              controller: controller,
              isTablet: true,
            ),
          ),
        ],
      ),
    );
  }
}
