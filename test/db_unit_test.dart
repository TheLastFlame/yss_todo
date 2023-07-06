import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/data/storage/tasklist.dart';
import 'package:yss_todo/domain/controllers/main.dart';

import 'data/tasks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/path_provider');
  void setUpMockChannels(MethodChannel channel) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall? methodCall) async {
        if (methodCall?.method == 'getApplicationDocumentsDirectory') {
          return '.';
        } else if (methodCall?.method == 'getDeviceInfo') {
          return 'null';
        }
        return null;
      },
    );
  }

  group('TaskListDB', () {
    setUpAll(() async {
      setUpMockChannels(channel);
      GetIt.I.registerSingleton<MainController>(
          await MainController.init(isTest: true));
      GetIt.I.registerSingleton<TaskListDB>(await TaskListDBGetStorage.init());
    });
    test('Add task to database check', () async {
      final db = GetIt.I<TaskListDB>();
      final check = await db.save(list1.first);
      expect(check, true);
    });

    test('Update all tasks in database check', () async {
      final db = GetIt.I<TaskListDB>();
      final check = await db.updateAll(list1);
      expect(check, true);
    });

    test('Get task list from database check', () async {
      final db = GetIt.I<TaskListDB>();
      final tasklist = (await db.getAll()).toList();
      for (int i = 0; i < list1.length; i++) {
        expect(tasklist[i].id, list1[i].id);
      }
    });

    test('Remove task from database check', () async {
      final db = GetIt.I<TaskListDB>();
      var check = await db.remove(list1.first.id);
      expect(check, true);
    });
  });
}
