import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import '../core/storage/storage.core.dart';

// ignore: non_constant_identifier_names

class AppStorage {
  final StorageCore _core;
  AppStorage._({StorageCore? core}) : _core = core ?? StorageCore();
  factory AppStorage() => Get.put(AppStorage._());

  String? getAccessToken() => _core.getString('accessToken');
  Future setAccessToken(String? value) => _core.setString('accessToken', value);
  String? getRefreshToken() => _core.getString('refreshToken');
  Future setRefreshToken(String? value) =>
      _core.setString('refreshToken', value);

  String? getTranslatesHash(Locale locale) => _core.getString('hash_$locale');
  Future setTranslatesHash(Locale locale, String? value) =>
      _core.setString('hash_$locale', value);

  String? getConfig() => _core.getString('config');
  Future setConfig(String? value) => _core.setString('config', value);
}
