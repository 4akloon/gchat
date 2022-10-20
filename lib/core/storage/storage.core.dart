// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageCore {
  late final SharedPreferences _sharedPreferences;
  // final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  StorageCore._();
  factory StorageCore() => Get.find<StorageCore>();
  static Future<void> initialize() async {
    final core = StorageCore._();
    await core._init();
    Get.put<StorageCore>(core, permanent: true);
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
    // await _secureStorage.deleteAll();
  }

  String? getString(String key) => _sharedPreferences.getString(key);
  int? getInt(String key) => _sharedPreferences.getInt(key);
  double? getDouble(String key) => _sharedPreferences.getDouble(key);
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  // Future<String?> getStringSecure(String key) => _secureStorage.read(key: key);

  Future<bool> setString(String key, String? value) {
    if (value == null) {
      return _sharedPreferences.remove(key);
    } else {
      return _sharedPreferences.setString(key, value);
    }
  }

  Future<bool> setInt(String key, int? value) {
    if (value == null) {
      return _sharedPreferences.remove(key);
    } else {
      return _sharedPreferences.setInt(key, value);
    }
  }

  Future<bool> setDouble(String key, double? value) {
    if (value == null) {
      return _sharedPreferences.remove(key);
    } else {
      return _sharedPreferences.setDouble(key, value);
    }
  }

  Future<bool> setBool(String key, bool? value) {
    if (value == null) {
      return _sharedPreferences.remove(key);
    } else {
      return _sharedPreferences.setBool(key, value);
    }
  }

  // Future<void> setStringSecure(String key, String? value) {
  //   if (value == null) {
  //     return _secureStorage.delete(key: key);
  //   } else {
  //     return _secureStorage.write(key: key, value: value);
  //   }
  // }
}
