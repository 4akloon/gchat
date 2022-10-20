import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';

import '../../utils/log/log.mixin.dart';

class ConnectionCore with Logger {
  ConnectionCore._() {
    _status.bindStream(_connectivity.onConnectivityChanged);
  }
  factory ConnectionCore() => Get.find<ConnectionCore>();

  static Future<void> initialize() async {
    final core = ConnectionCore._();
    await core.fetchStatus();
    Get.put(core, permanent: true);
  }

  Future<void> fetchStatus() async {
    _status.value = await _connectivity.checkConnectivity();
    logger('Status: ${_status.value.name}');
  }

  final Connectivity _connectivity = Connectivity();

  final Rx<ConnectivityResult> _status = ConnectivityResult.none.obs;

  bool get connected => _status.value != ConnectivityResult.none;
  Stream<ConnectivityResult> get stream => _status.stream;
}
