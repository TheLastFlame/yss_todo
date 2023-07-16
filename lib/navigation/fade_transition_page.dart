import 'package:flutter/material.dart';
import 'package:yss_todo/constants.dart';

class FadePage<T> extends Page<T> {
  final Widget child;

  const FadePage(
      {required this.child,
      LocalKey? key,
      String? name,
      Object? arguments,
      String? restorationId})
      : super(
            key: key,
            name: name,
            arguments: arguments,
            restorationId: restorationId);

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: animationsDuration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
