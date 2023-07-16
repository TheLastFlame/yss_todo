import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:yss_todo/data/api/api.dart';
import 'package:yss_todo/data/storage/sync.dart';
import 'package:yss_todo/data/storage/tasklist.dart';
import 'package:yss_todo/domain/controllers/home.dart';
import 'package:yss_todo/domain/controllers/main.dart';
import 'package:yss_todo/logger.dart';

import 'i18n/strings.g.dart';
import 'navigation/route_information_parser.dart';
import 'navigation/router_delegate.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  logger.i(
    'initialize the binding between the Flutter framework and the host platform',
  );

  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  logger.i('Getting the system locale');
  LocaleSettings.useDeviceLocale();

  settingUpSystemUIOverlay();

  logger.i('Storage initialization');
  // await GetStorage.init('Settings');
  GetIt.I.registerSingleton<TaskListDB>(await TaskListDBGetStorage.init());
  GetIt.I.registerSingleton<SyncStorage>(await SyncStorageGetStorage().init());

  logger.i('Controllers registration');
  GetIt.I.registerSingleton<MainController>(await MainController.init());
  GetIt.I.registerSingleton<TasksAPI>(await TasksAPI.init());
  GetIt.I.registerSingleton<HomeController>(await HomeController.init());
  GetIt.I.registerSingleton<MyRouterDelegate>(MyRouterDelegate());

  runApp(TranslationProvider(child: MainApp()));
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
  MainApp({super.key});
  final parser = MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    logger.i('The application has been started');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),

      // set up localization
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerDelegate: GetIt.I<MyRouterDelegate>(),
      routeInformationParser: parser,
    );
  }
}
