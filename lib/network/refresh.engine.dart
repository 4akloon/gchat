import 'package:gchat/repositories/auth/auth.repository.dart';
import 'package:gchat/storage/app.storage.dart';

import '../core/network/base_refresh.engine.dart';

class RefreshEngine extends BaseRefreshEngine {
  final _repository = AuthRepository();
  final _storage = AppStorage();

  @override
  Future<bool> sendRefresh() async {
    final token = _storage.getRefreshToken();
    if (token == null) return false;
    final response = await _repository.refreshToken(token);
    if (response.success) {
      _storage.setAccessToken(response.data?.accessToken);
      _storage.setRefreshToken(response.data?.refreshToken);
    }
    return response.success;
  }
}
