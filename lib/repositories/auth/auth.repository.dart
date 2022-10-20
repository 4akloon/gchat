// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:graphql/client.dart';

import '../../core/graphql/graph.core.dart';
import '../../core/network/app_response.dart';
import '../../models/auth/login.model.dart';
import '../../models/user/user.model.dart';

part 'playground.dart';

class AuthRepository {
  AuthRepository._();
  factory AuthRepository() => Get.put(AuthRepository._());
  final _playground = _Playground();
  GraphCore get _core => GraphCore.instance;

  Future<AppResponse<String?>> sendSms(String phone) async {
    final options = MutationOptions(
      document: gql(_playground.sendSms),
      variables: {'phone': phone},
    );

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(data: response.data['sendSms'], success: true);
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }

  Future<AppResponse<LoginModel?>> confirmPasscode({
    required String token,
    required String code,
  }) async {
    final options = MutationOptions(
      document: gql(_playground.confirmPasscode),
      variables: {'token': token, 'code': code},
    );

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(
          data: LoginModel.fromNetwork(response.data['confirmPasscode']),
          success: true,
        );
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }

  Future<AppResponse<LoginModel?>> refreshToken(String token) async {
    final options = MutationOptions(
      document: gql(_playground.refreshToken),
      variables: {'token': token},
    );

    final response =
        await _core.request(options, force: true, secondRequest: true);
    if (response.success) {
      try {
        return AppResponse(
          data: LoginModel.fromNetwork(response.data['refreshToken']),
          success: true,
        );
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }

  Future<AppResponse<bool?>> logout() async {
    final options = MutationOptions(document: gql(_playground.logout));

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(data: response.data['logout'], success: true);
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }
}
