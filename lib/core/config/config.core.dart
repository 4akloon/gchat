import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../utils/log/log.mixin.dart';
import '../storage/storage.core.dart';

part 'config.model.dart';
part 'widgets/change_config.view.dart';

class ConfigCore with Logger {
  final StorageCore _storage;
  final ConfigModel defaultConfig;
  late ConfigModel config;
  final List<ConfigModel> availableConfigs;

  ConfigCore._(
    this.defaultConfig, {
    required this.availableConfigs,
    StorageCore? storage,
  }) : _storage = storage ?? StorageCore() {
    assert(availableConfigs.contains(defaultConfig));

    config = fetchConfig() ?? defaultConfig;
    logger('Current config: ${config.name}');
    Get.put(this, permanent: true);
  }
  factory ConfigCore() => Get.find<ConfigCore>();
  static void initialize(
    ConfigModel defaultConfig, {
    required List<ConfigModel> availableConfigs,
  }) =>
      Get.put<ConfigCore>(
        ConfigCore._(defaultConfig, availableConfigs: availableConfigs),
        permanent: true,
      );

  Future setConfig(ConfigModel? config) async {
    await _storage.setString('config', config?.name);
  }

  ConfigModel? fetchConfig() {
    final name = _storage.getString('config');
    if (name == null) return null;
    final index = availableConfigs.indexWhere((e) => e.name == name);
    if (index != -1) return availableConfigs[index];
    return null;
  }

  void showConfigChanger() => Get.to(() => _ChangeConfigView());
}
