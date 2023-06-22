import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/data/api/api.dart';
import 'package:yss_todo/data/storage/tasklist.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/ui/pages/home/home.dart';
import 'package:yss_todo/ui/pages/task/taskinfo.dart';

import 'i18n/strings.g.dart';

void main() async {
  logger.i(
    'initialize the binding between the Flutter framework and the host platform',
  );

  WidgetsFlutterBinding.ensureInitialized();

  logger.i('Getting the system locale');
  LocaleSettings.useDeviceLocale();

  settingUpSystemUIOverlay();

  logger.i('Storage initialization');
  // await GetStorage.init('Settings');
  GetIt.I.registerSingleton<TaskListDB>(await TaskListDBGetStorage.init());

  logger.i('Controllers registration');
  GetIt.I.registerSingleton<TasksAPI>(await TasksAPI.init());
  GetIt.I.registerSingleton<HomeController>(await HomeController.init());

  runApp(TranslationProvider(child: const MainApp()));
}

void settingUpSystemUIOverlay() {
  logger.i("Setting SysemUIOverlay to transparent");
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent));
  logger.i("Setting SystemUiMode to full screen");
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.i('The application has been started');
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),

      // set up localization
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,

      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        '/task': (context) => const TaskPage(),
      },
    );
  }
}
