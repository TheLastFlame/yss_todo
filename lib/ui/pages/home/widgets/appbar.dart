import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/domain/controllers/home.dart';

import '../../../../constants.dart';
import '../../../../helpers.dart';
import '../../../../i18n/strings.g.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollControl =
        GetIt.I<HomeController>().scrollControl;

    // Процент раскрытия аппбара от 0 до 100
    var appBarExpandProcent = 0.0.obs();

    // Треть экрана
    final screenThird = MediaQuery.sizeOf(context).height / 3;

    scrollControl.addListener(
      () => runInAction(() => appBarExpandProcent.value =
          scrollControl.offset > screenThird - 56
              ? 100
              : scrollControl.offset / (screenThird - 56) * 100),
      //144 это expandedHeight - 56 (высота свёрнутого аппбара)
    );

    return Observer(
      builder: (_) {
        return SliverAppBar(
          // Фикс тени аппбара
          shadowColor: Theme.of(context).colorScheme.shadow,

          pinned: true,
          expandedHeight: screenThird,

          // Убирает кноку настроек
          actions: [
            appBarExpandProcent.value == 100
                ? isDoneVisibilitySwitcher()
                : settingsButton(appBarExpandProcent)
          ],

          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: lerp(
                  appPadding * 5, appPadding * 2, appBarExpandProcent.value),
              bottom: lerp(
                  appPadding * 5, appPadding * 2, appBarExpandProcent.value),
            ),
            title: Text(
              t.homepage.mytasks,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            collapseMode: CollapseMode.pin,
            background: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: lerp(appPadding * 5, appPadding * 2,
                      appBarExpandProcent.value),
                  right: lerp(appPadding * 3, 0, appBarExpandProcent.value),
                  bottom: appPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: lerp(1, 0, appBarExpandProcent.value),
                      duration: animationsDuration,
                      child: Text(
                          '${t.homepage.done}: ${GetIt.I<HomeController>().taskList.where((e) => e.done.value).length}'),
                    ),
                    isDoneVisibilitySwitcher(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AnimatedOpacity settingsButton(Observable<double> appBarExpandProcent) {
    return AnimatedOpacity(
      opacity: lerp(1, 0, appBarExpandProcent.value),
      duration: animationsDuration,
      child: Card(
          margin: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
          elevation: 2,
          child: InkWell(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(90)),
            onTap: () {},
            child: const SizedBox(
              height: 56,
              width: 56,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: appPadding, left: appPadding * 2),
                child: Icon(Icons.settings),
              ),
            ),
          )),
    );
  }

  IconButton isDoneVisibilitySwitcher() => IconButton(
      onPressed: () => runInAction(
          () => GetIt.I<HomeController>().isComplitedVisible.toggle()),
      icon: Icon(GetIt.I<HomeController>().isComplitedVisible.value
          ? Icons.visibility_off
          : Icons.visibility));
}
