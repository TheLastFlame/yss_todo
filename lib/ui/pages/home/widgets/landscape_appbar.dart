import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/constants.dart';

import '../../../../domain/controllers/home.dart';
import '../../../../i18n/strings.g.dart';

class LandscapeHomeAppBar extends StatelessWidget {
  const LandscapeHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 72,
        width: double.infinity,
        child: Observer(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.homepage.mytasks,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Card(
                  // elevation: 0,
                  child: Row(
                    children: [
                      const SizedBox(width: appPadding*2),
                      Text(
                        '${t.homepage.done}: ${GetIt.I<HomeController>().taskList.where((e) => e.done.value).length}',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(appPadding),
                        child: isDoneVisibilitySwitcher(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  IconButton isDoneVisibilitySwitcher() => IconButton(
      onPressed: () => runInAction(
          () => GetIt.I<HomeController>().isComplitedVisible.toggle()),
      icon: Icon(GetIt.I<HomeController>().isComplitedVisible.value
          ? Icons.visibility_off
          : Icons.visibility));
}
