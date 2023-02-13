import 'package:get/get_rx/get_rx.dart';

import '../../utils/log/log.mixin.dart';

enum RefreshTokenStatus { refreshing, ready, rotten }

abstract class BaseRefreshEngine with Logger {
  final Rx<RefreshTokenStatus> _status = RefreshTokenStatus.ready.obs;

  bool get refreshing => _status.value == RefreshTokenStatus.refreshing;
  bool get ready => _status.value == RefreshTokenStatus.ready;
  bool get rotten => _status.value == RefreshTokenStatus.rotten;

  Stream get statusStream => _status.stream;

  void _setReady() => _status(RefreshTokenStatus.ready);
  void _setRefreshing() => _status(RefreshTokenStatus.refreshing);

  Future<void> refreshToken(
      Future Function() update, Function? onTokenRot) async {
    if (refreshing) return;
    logger("Refresh token...");
    _setRefreshing();

    final success = await sendRefresh();
    logger("Refresh token: - success: $success");
    await update();
    _status(success ? RefreshTokenStatus.ready : RefreshTokenStatus.rotten);
    if (!success && onTokenRot != null) onTokenRot();
    _setReady();
  }

  Future<bool> sendRefresh();
}
