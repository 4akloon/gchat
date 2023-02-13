import 'package:flutter/material.dart';
import 'package:gchat/app/app.controller.dart';
import 'package:gchat/core/graphql/graph.core.dart';
import 'package:gchat/models/auth/login.model.dart';
import 'package:gchat/storage/app.storage.dart';
import 'package:gchat/views/main/main.view.dart';
import 'package:gchat/views/passcode/passcode.view.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AppStorage _storage;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  final _phone = ''.obs;
  final _loading = false.obs;

  LoginController({AppStorage? storage}) : _storage = storage ?? AppStorage();

  bool get valid => _phone.value.length == 13;
  bool get loading => _loading.value;

  void setPhone(String value) => _phone(value);

  Future<void> submit() async {
    if (!formKey.currentState!.validate() || loading) return;
    final response = await Get.toNamed(
      PasscodeView.name,
      arguments: PasscodeArgs(_phone.value),
    );
    if (response is LoginModel) {
      _storage.setAccessToken(response.accessToken);
      _storage.setRefreshToken(response.refreshToken);
      await AppController.instance.login(response.user);
      await GraphCore.instance.updateCore();
      Get.offAllNamed(MainView.name);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
