import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../constants.dart';
import '../../../../domain/controllers/home.dart';

class SyncIndicator extends StatelessWidget {
  const SyncIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AnimatedContainer(
          duration: animationsDuration,
          height: GetIt.I<HomeController>().isLoading.value ? 1 : 0,
          child: const LinearProgressIndicator(),
        );
      },
    );
  }
}
