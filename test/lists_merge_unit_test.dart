import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/domain/controllers/main.dart';
import 'package:yss_todo/helpers.dart';

import 'data/tasks.dart';

void main() {
  group('Merge lists test', () {
    setUpAll(() async {
      GetIt.I.registerSingleton<MainController>(
          await MainController.init(isTest: true));
    });
    test('void lists', () {
      var list = mergeLists(emptyList, emptyList, {});
      expect(list, []);
    });
    test('one void lists', () {
      var list = mergeLists(list1, emptyList, {});
      for (int i = 0; i < list.length; i++) {
        expect(list[i].changedAt, list1[i].changedAt);
      }
    });
    test('full list in remove', () {
      var list = mergeLists(list1, list3, removeList1);
      for (int i = 0; i < list.length; i++) {
        expect(list[i].changedAt, list3[i].changedAt);
      }
    });

    test('standart merge test', () {
      var list = mergeLists(list1, list2, removeList2);
      for (int i = 0; i < list.length; i++) {
        expect(list[i].changedAt, list4[i].changedAt);
      }
    });
  });
}
