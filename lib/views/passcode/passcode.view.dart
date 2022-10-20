import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:gchat/views/passcode/passcode.controller.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../styles/styles.dart';
import '../../widgets/app_loader.dart';

class PasscodeArgs {
  final String phone;

  PasscodeArgs(this.phone);
}

class PasscodeView extends StatelessWidget {
  static const String name = 'PasscodeView';
  PasscodeView({
    super.key,
    required PasscodeArgs args,
  }) : controller = Get.put(PasscodeController(args.phone));

  final PasscodeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('passcode_title'.tr)),
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
                Pinput(
                  focusNode: controller.passcodeFocus,
                  length: 6,
                  controller: controller.passcodeController,
                  onChanged: controller.setPasscode,
                  onCompleted: (value) => controller.submit(),
                  defaultPinTheme: PinTheme(
                    height: 54,
                    textStyle: AppTextStyles.headlineBold,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).whiteSmoke,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: CustomTimer(
                    controller: controller.timerController,
                    begin: const Duration(seconds: 3),
                    end: const Duration(),
                    builder: (time) => Obx(
                      () {
                        if (controller.sending) return const AppLoader();
                        if (controller.timerController.state ==
                            CustomTimerState.finished) {
                          return TextButton(
                            onPressed: !controller.submiting
                                ? () => controller.sendMessage()
                                : null,
                            child: Text('passcode_send_code_again'.tr),
                          );
                        }
                        return RichText(
                          text: TextSpan(
                            style: AppTextStyles.body,
                            children: [
                              TextSpan(
                                text: '${'passcode_send_again'.tr} ',
                                style: AppTextStyles.bodyBold.withColor(
                                  AppColors.of(context).grey,
                                ),
                              ),
                              TextSpan(
                                text: '${time.minutes}:${time.seconds}',
                                style: AppTextStyles.bodyBold.withColor(
                                  AppColors.of(context).black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.valid ? () => controller.submit() : null,
                    child: controller.submiting
                        ? const AppLoader(reverseColor: true)
                        : Text('passcode_submit'.tr),
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
