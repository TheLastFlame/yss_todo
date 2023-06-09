import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/helpers.dart';

import '../../constants.dart';
import '../../i18n/strings.g.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollControl = ScrollController();
    var appBarExpandProcent = 0.0.obs();

    scrollControl.addListener(
      () => runInAction(() => appBarExpandProcent.value =
          scrollControl.offset >= 190 ? 100 : scrollControl.offset / 190 * 100),
    );
    return Scaffold(
      body: CustomScrollView(
        controller: scrollControl,
        slivers: [
          Observer(builder: (_) {
            return SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              actions: appBarExpandProcent.value == 100
                  ? [isDoneVisibilitySwitcher()]
                  : [],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(
                  left: lerp(appPadding * 6, appPadding * 2,
                      appBarExpandProcent.value),
                  bottom: lerp(appPadding * 5, appPadding * 2,
                      appBarExpandProcent.value),
                ),
                title: Container(
                    color: appBarExpandProcent.value == 100
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.background,
                    child: Text('SliverAppBar')),
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: lerp(appPadding * 6, appPadding * 2,
                              appBarExpandProcent.value),
                          right: lerp(
                              appPadding * 4, 0, appBarExpandProcent.value),
                          bottom: appPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.homepage.done),
                          isDoneVisibilitySwitcher(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Card(
                  elevation: 2,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 2,
                    width: MediaQuery.of(context).size.width,
                  )),
            ),
          )
        ],
      ),
    );
  }

  IconButton isDoneVisibilitySwitcher() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.visibility));
  }
}
