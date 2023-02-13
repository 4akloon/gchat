import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gchat/locale/langs/uk.lang.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'app/app.controller.dart';
import 'app/app.dart';
import 'configs/local.config.dart';
import 'configs/local_android.config.dart';
import 'core/config/config.core.dart';
import 'core/connection/connection.core.dart';
import 'core/db/db.core.dart';
import 'core/error/error.core.dart';
import 'core/graphql/graph.core.dart';
import 'core/info/info.core.dart';
import 'core/locale/locale.core.dart';
import 'core/locale/locale.db.dart';
import 'core/network/app_http_overrides.dart';
import 'core/storage/storage.core.dart';
import 'databases/app.db.dart';
import 'databases/contact.db.dart';
import 'locale/langs/en.lang.dart';
import 'network/refresh.engine.dart';
import 'storage/app.storage.dart';
import 'widgets/snackbars/app_snackbar.dart';

void main() async {
  HttpOverrides.global = AppHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices(localConfig);
  runApp(App());
}

Future<void> initServices(ConfigModel config) async {
  await DBCore.initialize([AppDB(), LocaleDB(), ContactDB()]);
  await StorageCore.initialize();
  ConfigCore.initialize(config, availableConfigs: [
    localConfig,
    localAndroidConfig,
  ]);
  await InfoCore.initialize();
  await ConnectionCore.initialize();
  ErrorCore.initialize(
    (message, [payload]) => Get.showSnackbar(appSnackBar(message)),
  );
  await GraphCore(
    baseUrl: config.baseUrl,
    errorHandler: ErrorCore().graphErrorHandle,
    refreshEngine: RefreshEngine(),
    getDynamicHeaders: () async {
      final token = AppStorage().getAccessToken();
      return {
        if (token != null) 'Authorization': 'Bearer $token',
      };
    },
  ).init();
  LocaleCore.initialize(langs: [enLang, ukLang]);
  Get.put(AppController(), permanent: true);
}
