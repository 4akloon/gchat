// ignore_for_file: avoid_print

import 'package:get/instance_manager.dart';
import 'package:graphql/client.dart';

import '../../core/graphql/graph.core.dart';
import '../../core/network/app_response.dart';
import '../../models/user/user.model.dart';
part 'playground.dart';

class UserRepository {
  UserRepository._();
  factory UserRepository() => Get.put(UserRepository._());
  final _playground = _Playground();

  GraphCore get _core => GraphCore.instance;

  Future<AppResponse<UserModel?>> currentUser() async {
    final options = QueryOptions(document: gql(_playground.currentUser));

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(
          data: UserModel.fromNetwork(response.data['currentUser']),
          success: true,
        );
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }

  Future<AppResponse<UserModel?>> findUserByPhone(String phone) async {
    final options = QueryOptions(
      document: gql(_playground.findUserByPhone),
      variables: {'phone': phone},
    );

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(
          data: UserModel.fromNetwork(response.data['findUserByPhone']),
          success: true,
        );
      } catch (err) {
        return response.newGeneric(data: null);
      }
    }
    return response.newGeneric(data: null, success: false);
  }
}
