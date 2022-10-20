import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/config/config.core.dart';
import '../core/locale/app.translations.dart';
import '../core/locale/locale.core.dart';
import '../router/app.router.dart';
import '../styles/styles.dart';
import '../views/main/main.view.dart';
import '../views/login/login.view.dart';
import 'app.controller.dart';

class App extends StatelessWidget {
  final _localeCore = LocaleCore();
  final _config = ConfigCore().config;
  final _appController = AppController.instance;
  App({Key? key}) : super(key: key);

  String getInitialRoute() {
    if (_appController.authorized) return MainView.name;
    return LoginView.name;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: getInitialRoute(),
      onGenerateRoute: AppRouter.generate,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: _config.debug,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _appController.themeMode,
      locale: _appController.locale,
      supportedLocales: _localeCore.supportedLocales,
      translations: AppTranslations(),
      fallbackLocale: _localeCore.supportedLocales.first,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
