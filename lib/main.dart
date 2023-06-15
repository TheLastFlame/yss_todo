import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yss_todo/controllers/home.dart';
import 'package:yss_todo/logger.dart';
import 'package:yss_todo/pages/home/home.dart';
import 'package:yss_todo/pages/task/taskinfo.dart';

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
  await GetStorage.init('TaskList');

  logger.i('Controller registration');
  GetIt.I.registerSingleton<HomeController>(HomeController());

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
