import 'package:get_storage/get_storage.dart';

import '../../logger.dart';

abstract interface class SyncStorage {
  Future<bool> getSyncStatus();
  Future<void> setSyncStatus(bool status);
  Future<void> addToRemove(String taskId, DateTime time);
  Future<Map<String, DateTime>> getRemoveList();
  Future<void> eraseRemoveList();
}

class SyncStorageGetStorage implements SyncStorage {
  final _syncStorage = GetStorage('SyncStorage');

  @override
  Future<bool> getSyncStatus() async {
    return _syncStorage.read('SyncStatus') ?? true;
  }

  @override
  Future<void> setSyncStatus(bool status) async {
    _syncStorage.write('SyncStatus', status);
  }

  @override
  Future<void> addToRemove(String taskId, DateTime time) async {
    _syncStorage.write(taskId, time.toString());
  }

  @override
  Future<Map<String, DateTime>> getRemoveList() async {
    List keys = _syncStorage.getKeys().toList();
    Map<String, DateTime> values = {
      for (var key in keys)
        key: DateTime.tryParse(_syncStorage.read(key).toString()) ??
            DateTime.now()
    };
    values.remove('SyncStatus');
    if (values.isEmpty) return {};
    logger.i(values);
    return values;
  }

  @override
  Future<void> eraseRemoveList() async {
    var status = await getSyncStatus();
    _syncStorage.erase();
    setSyncStatus(status);
  }

    static Future<SyncStorageGetStorage> init() async {
    await GetStorage.init('SyncStorage');
    return SyncStorageGetStorage();
  }
}
