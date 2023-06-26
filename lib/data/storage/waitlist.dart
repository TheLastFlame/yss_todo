//Этот интерфейс нужен для светлого будущего, в котором бекенд позволяет обновлять таски выборочно

abstract interface class WaitListDB {
  Future<void> add(String taskID);
  Future<void> delete(String taskID);
  Future<void> deleteCancel(String taskID);
  Future<void> eraseSaved();
  Future<Map<String, List<String>>> getAll();
}

// class WaitListDBGetStorage implements WaitListDB {
//   final _Save = GetStorage('SaveList');
//   final _Delete = GetStorage('DeleteList');

//   @override
//   Future<void> add(String taskID) async {
//     await _Save.write(taskID, null);
//     logger.i('Task $taskID data is added to the offline waiting list');
//   }

//   Future<void> _remove(String taskID) async {
//     await _Save.remove(taskID);
//     logger.i('Task $taskID is removed from the offline waiting list');
//   }

//   @override
//   Future<Iterable<String>> getAll() async {
//     logger.i('Getting a list of offline waiting tasks...');
//     List values = _taskStorage.getValues().toList();
//     logger.i(values);
    
//   }

//   static Future<WaitListDBGetStorage> init() async {
//     await GetStorage.init('SaveList');
//     return WaitListDBGetStorage();
//   }
// }
