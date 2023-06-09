import 'package:flutter/material.dart';
import 'package:yss_todo/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/strings.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      locale: TranslationProvider.of(context).flutterLocale, // use provider
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(t.homepage.mytasks),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Card(
                    elevation: 2,
                    child: SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
