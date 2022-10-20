import 'package:flutter/material.dart';
import 'package:gchat/widgets/user/user_tile.dart';
import 'package:get/get.dart';

import '../../styles/styles.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/inputs/square_text_input.dart';
import 'contact_add.controller.dart';

class ContactAddSheet extends StatelessWidget {
  ContactAddSheet({super.key}) : controller = ContactAddController();

  final ContactAddController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.of(context).white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'contact_add_title'.tr,
                  style: AppTextStyles.headlineBold
                      .withColor(AppColors.of(context).black),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: controller.formKey,
                  child: SquareTextInput.phone(
                    labelText: 'comon_phone'.tr,
                    controller: controller.phoneController,
                    onChange: controller.setPhone,
                    suffixWidget: controller.loading
                        ? const AppLoader(center: false)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (controller.result != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: UserTile(user: controller.result!),
                ),
                const SizedBox(height: 16)
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: controller.result != null
                      ? () => controller.addContact()
                      : null,
                  child: controller.loading
                      ? const AppLoader(reverseColor: true)
                      : Text('contact_add_submit'.tr),
                ),
              ),
              const SafeArea(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
