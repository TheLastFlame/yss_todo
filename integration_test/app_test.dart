import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:yss_todo/logger.dart';

import 'test_main.dart' as test_app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const text = 'Automatic test task';

  const fabKey = ValueKey('FAB');
  const nameFormKey = ValueKey('NameForm');
  const saveBtnKey = ValueKey('SaveBtn');

  testWidgets('Add new task test', (tester) async {
    test_app.main();
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    logger.i('Searching a fab');
    expect(find.byKey(fabKey), findsWidgets);
    await tester.tap(find.byKey(fabKey));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));
    logger.i('Entering data');
    expect(find.byKey(nameFormKey), findsOneWidget);
    await tester.enterText(find.byKey(nameFormKey), text);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));
    logger.i('Pressing save');
    expect(find.byKey(saveBtnKey), findsOneWidget);
    await tester.tap(find.byKey(saveBtnKey));
    await tester.pumpAndSettle();

    await Future<void>.delayed(const Duration(seconds: 2));
    logger.i('Searching for a task in a list');
    expect(find.text(text, findRichText: true), findsWidgets);
  });
}
