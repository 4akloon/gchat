// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gchat/core/graphql/graph.core.dart';
import 'package:gchat/core/storage/storage.core.dart';
import 'package:gchat/models/user/user.model.dart';
import 'package:gchat/repositories/auth/auth.repository.dart';
import 'package:gchat/repositories/user/user.repository.dart';
import 'package:gchat/storage/app.storage.dart';
import 'package:get/get.dart';

import '../core/db/db.core.dart';
import '../databases/app.db.dart';
import '../locale/langs/en.lang.dart';
import '../utils/log/log.mixin.dart';

class AppController extends GetxController with Logger {
  static AppController get instance => Get.find<AppController>();
  AppController({
    AppDB? appDB,
    AuthRepository? authRepository,
    UserRepository? userRepository,
    AppStorage? storage,
  })  : _appDB = appDB ?? AppDB.instance,
        _authRepository = authRepository ?? AuthRepository(),
        _userRepository = userRepository ?? UserRepository(),
        _storage = storage ?? AppStorage() {
    _locale = Rx<Locale>(_appDB.locale ?? enLang.locale);
    _themeMode = Rx<ThemeMode>(_appDB.themeMode ?? ThemeMode.system);
    _user = Rx<UserModel?>(_appDB.user);
  }
  final AppDB _appDB;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AppStorage _storage;

  late final Rx<Locale> _locale;
  late final Rx<ThemeMode> _themeMode;
  late final Rx<UserModel?> _user;

  Locale get locale => _locale.value;
  ThemeMode get themeMode => _themeMode.value;
  UserModel? get user => _user.value;
  bool get authorized => _storage.getAccessToken() != null;

  @override
  void onInit() {
    ever(_locale, (Locale l) => _appDB.setLocale(l));
    ever(_themeMode, (ThemeMode t) => _appDB.setThemeMode(t));
    ever(_user, (UserModel? u) => _appDB.setUser(u));
    updateUser();
    super.onInit();
  }

  void updateLocale(Locale locale) {
    logger('Update locale: $locale');
    _locale.value = locale;
    Get.updateLocale(locale);
  }

  void changeThemeMode(ThemeMode mode) {
    logger('Change theme mode: $mode');
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  Future<void> updateUser([UserModel? user]) async {
    logger('Update user');
    if (user != null) {
      _user(user);
      return;
    } else {
      final response = await _userRepository.currentUser();
      if (response.success) {
        _user(response.data);
      }
    }
  }

  Future<void> login(UserModel user) async {
    logger("login...");
    await updateUser(user);
  }

  Future<void> logout({bool force = false}) async {
    logger("logout...");
    if (force) {
      // Get.offAll(() => const AuthorizationView());
    } else {
      await _authRepository.logout();
    }
    await StorageCore().clear();
    await DBCore().clear();
    await GraphCore.instance.updateCore();
  }
}
