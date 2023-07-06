import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yss_todo/data/storage/sync.dart';

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

  group('SyncStorageGetStorage', () {
    late SyncStorageGetStorage syncStorage;

    setUpAll(() async {
      setUpMockChannels(channel);
      syncStorage = await SyncStorageGetStorage.init();
    });

    tearDown(() async {
      await syncStorage.eraseRemoveList();
    });

    test('getSyncStatus returns true by default', () async {
      final result = await syncStorage.getSyncStatus();

      expect(result, true);
    });

    test('getSyncStatus returns the stored value', () async {
      await syncStorage.setSyncStatus(false);

      final result = await syncStorage.getSyncStatus();

      expect(result, false);
    });

    test('setSyncStatus writes the given value', () async {
      await syncStorage.setSyncStatus(true);

      final result = await syncStorage.getSyncStatus();

      expect(result, true);
    });

    test('addToRemove writes the given taskId and time', () async {
      const taskId = '123';
      final time = DateTime(2021, 1, 1);

      await syncStorage.addToRemove(taskId, time);

      final result = await syncStorage.getRemoveList();

      expect(result, {taskId: time});
    });

    test('getRemoveList returns an empty map if no keys', () async {
      final result = await syncStorage.getRemoveList();

      expect(result, {});
    });

    test('getRemoveList returns a map of taskIds and times', () async {
      const taskId1 = '123';
      final time1 = DateTime(2021, 1, 1);
      const taskId2 = '456';
      final time2 = DateTime(2021, 2, 2);

      await syncStorage.addToRemove(taskId1, time1);
      await syncStorage.addToRemove(taskId2, time2);

      final result = await syncStorage.getRemoveList();

      expect(result, {taskId1: time1, taskId2: time2});
    });

    test('getRemoveList ignores SyncStatus key', () async {
      const taskId = '123';
      final time = DateTime(2021, 1, 1);

      await syncStorage.addToRemove(taskId, time);
      await syncStorage.setSyncStatus(true);

      final result = await syncStorage.getRemoveList();

      expect(result, {taskId: time});
    });

    test('eraseRemoveList erases the storage and preserves SyncStatus',
        () async {
      await syncStorage.setSyncStatus(true);

      await syncStorage.eraseRemoveList();

      final result = await syncStorage.getSyncStatus();

      expect(result, true);
    });
  });
}
