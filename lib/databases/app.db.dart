// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:gchat/models/user/user.model.dart';

import '../core/db/base_db.dart';
import '../core/db/db.core.dart';

class AppDB extends BaseDB {
  static AppDB get instance => DBCore().getDataBase<AppDB>();

  ThemeMode? get themeMode {
    final data = box.get('themeMode');
    if (data is int) return ThemeMode.values[data];
    return null;
  }

  void setThemeMode(ThemeMode mode) => box.put('themeMode', mode.index);

  Locale? get locale {
    final data = box.get('locale');
    if (data is String) {
      return Locale(data.split('_').first, data.split('_').last);
    }
    return null;
  }

  void setLocale(Locale locale) => box.put('locale', locale.toString());

  UserModel? get user {
    final data = box.get('user');
    if (data != null) {
      try {
        return UserModel.fromJson(data);
      } catch (err) {}
    }
    return null;
  }

  void setUser(UserModel? user) => box.put('user', user?.toJson());
}
