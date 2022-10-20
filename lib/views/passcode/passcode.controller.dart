import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:gchat/repositories/auth/auth.repository.dart';
import 'package:get/get.dart';

class PasscodeController extends GetxController {
  final AuthRepository _authRepository;
  final formKey = GlobalKey<FormState>();
  final passcodeController = TextEditingController();
  final passcodeFocus = FocusNode();
  final timerController = CustomTimerController();
  final String phone;

  PasscodeController(
    this.phone, {
    AuthRepository? authRepository,
  }) : _authRepository = authRepository ?? AuthRepository();

  final _passcode = ''.obs;
  final _submiting = false.obs;
  final _sending = false.obs;
  final _failedSending = false.obs;
  String? _token;

  bool get valid => _passcode.value.length == 6 && !sending;
  bool get submiting => _submiting.value;
  bool get sending => _sending.value;
  bool get failedSending => _failedSending.value;

  void setPasscode(String value) => _passcode(value);

  @override
  void onInit() {
    passcodeFocus.requestFocus();
    sendMessage();
    super.onInit();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate() || submiting || _token == null) {
      return;
    }
    _submiting(true);

    final response = await _authRepository.confirmPasscode(
        code: _passcode.value, token: _token!);
    _submiting(false);

    if (response.success) {
      Get.back(result: response.data);
    }
  }

  Future<void> sendMessage() async {
    timerController.reset();
    _sending(true);

    final response = await _authRepository.sendSms(phone);
    _sending(false);
    _failedSending(false);
    if (response.success) {
      _token = response.data;
      timerController.start();
    } else {
      _failedSending(true);
    }
  }

  @override
  void onClose() {
    passcodeController.dispose();
    passcodeFocus.dispose();
    timerController.dispose();
    super.onClose();
  }
}
