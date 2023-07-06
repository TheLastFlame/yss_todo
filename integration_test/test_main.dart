import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/data/api/api.dart';
import 'package:yss_todo/data/storage/sync.dart';
import 'package:yss_todo/data/storage/tasklist.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/domain/controllers/main.dart';
import 'package:yss_todo/i18n/strings.g.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/main.dart';
import 'package:yss_todo/navigation/router_delegate.dart';

Future main() async {
  logger.i(
    'initialize the binding between the Flutter framework and the host platform',
  );

  logger.i('Getting the system locale');
  LocaleSettings.useDeviceLocale();

  logger.i('Storage initialization');
  // await GetStorage.init('Settings');
  GetIt.I.registerSingleton<TaskListDB>(await TaskListDBGetStorage.init());
  GetIt.I.registerSingleton<SyncStorage>(await SyncStorageGetStorage.init());

  logger.i('Controllers registration');
  GetIt.I.registerSingleton<MainController>(await MainController.init());
  GetIt.I.registerSingleton<TasksAPI>(await TasksAPI.init());
  GetIt.I.registerSingleton<HomeController>(await HomeController.init());
  GetIt.I.registerSingleton<MyRouterDelegate>(MyRouterDelegate());

   runApp(TranslationProvider(child: MainApp()));
}
