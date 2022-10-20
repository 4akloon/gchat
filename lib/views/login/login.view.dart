import 'package:flutter/material.dart';
import 'package:gchat/widgets/app_loader.dart';
import 'package:gchat/widgets/image/app_image.dart';
import 'package:gchat/widgets/inputs/square_text_input.dart';
import 'package:get/get.dart';

import 'login.controller.dart';

class LoginView extends StatelessWidget {
  static const String name = 'LoginView';
  LoginView({super.key}) : controller = Get.put(LoginController());

  final LoginController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                AppImage.chat.size(height: 150),
                const Spacer(),
                SquareTextInput.phone(
                  labelText: 'comon_phone'.tr,
                  controller: controller.phoneController,
                  onChange: controller.setPhone,
                ),
                const Spacer(),
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.valid ? () => controller.submit() : null,
                    child: controller.loading
                        ? const AppLoader(reverseColor: true)
                        : Text('login_submit'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
