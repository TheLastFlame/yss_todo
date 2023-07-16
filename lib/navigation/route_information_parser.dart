import 'package:flutter/material.dart';

import 'navigation_state.dart';
import 'routes.dart';

class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    switch (uri.pathSegments[0].toLowerCase()) {
      case RouteNames.newTaskLw:
        return NavigationState.creating();
      case RouteNames.task:
        return NavigationState.task(uri.pathSegments[1]);
    }

    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isTaskPage) {
      return RouteInformation(
        uri: Uri.parse('/task/${configuration.selectedTaskId}'),
      );
    }

    if (configuration.isNewTaskPage) {
      return RouteInformation(uri: Uri.parse('/newTask'));
    }

    return RouteInformation(uri: Uri.parse('/'));
  }
}
