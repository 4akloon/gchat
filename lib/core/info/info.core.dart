import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/instance_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/log/log.mixin.dart';

class InfoCore with Logger {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  late final PackageInfo _packageInfo;
  BaseDeviceInfo? _info;

  InfoCore._();
  factory InfoCore() => Get.find<InfoCore>();
  static Future<void> initialize() async {
    final core = InfoCore._();
    await core._init();
    Get.put<InfoCore>(core, permanent: true);
  }

  Future<void> _init() async {
    await Future.wait([loadDeviceInfo(), loadPackageInfo()]);
    logger('''App name: ${packageInfo.appName}
Version: $appVersion
Device id: $deviceId''');
  }

  BaseDeviceInfo? get info => _info;
  PackageInfo get packageInfo => _packageInfo;
  String get appVersion => packageInfo.version;

  String? get deviceId {
    if (_info is IosDeviceInfo) {
      return (_info as IosDeviceInfo).identifierForVendor;
    } else if (_info is AndroidDeviceInfo) {
      return (_info as AndroidDeviceInfo).id;
    }
    return null;
  }

  Future<void> loadDeviceInfo() async {
    if (Platform.isIOS) {
      _info = await _deviceInfoPlugin.iosInfo;
    } else if (Platform.isAndroid) {
      _info = await _deviceInfoPlugin.androidInfo;
    } else if (Platform.isMacOS) {
      _info = await _deviceInfoPlugin.macOsInfo;
    }
  }

  Future<void> loadPackageInfo() async =>
      _packageInfo = await PackageInfo.fromPlatform();
}
