import 'package:flutter/material.dart';
import 'package:yss_todo/navigation/fade_transition_page.dart';
import 'package:yss_todo/ui/pages/home/home.dart';
import 'package:yss_todo/ui/pages/task/taskinfo.dart';

import 'navigation_state.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  NavigationState get currentConfiguration {
    return state ?? NavigationState.root();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(child: Homepage()),
        if (state?.isTaskPage == true)
          FadePage(
            child: TaskPage(taskId: state?.selectedTaskId),
          ),
        if (state?.isNewTaskPage == true) const MaterialPage(child: TaskPage()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        state = NavigationState.root();

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void showTaskPage(String taskId) {
    state = NavigationState.task(taskId);
    notifyListeners();
  }
}
