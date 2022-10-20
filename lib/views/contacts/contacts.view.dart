import 'package:flutter/material.dart';
import 'package:gchat/components/contact_add/contact_add.sheet.dart';
import 'package:gchat/models/contact/contact.model.dart';
import 'package:gchat/utils/extensions/list.ext.dart';
import 'package:gchat/widgets/app_loader.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/app_icons_icons.dart';
import '../../styles/styles.dart';
import '../../widgets/inputs/capsute_text_input.dart';
import '../../widgets/user/user_tile.dart';
import 'contacts.controller.dart';

class ContactsView extends StatelessWidget {
  ContactsView({super.key}) : controller = Get.put(ContactsController());

  final ContactsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contacts_title'.tr),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(16),
            onPressed: () => Get.bottomSheet(
              ContactAddSheet(),
              ignoreSafeArea: false,
              isScrollControlled: true,
            ).then((value) {
              if (value is ContactModel) controller.updateContacts();
            }),
            icon: const Icon(AppIcons.user_add),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.of(context).bgGradient),
        child: Obx(
          () => SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: !controller.loading,
            enablePullUp: controller.hasMorePages,
            onRefresh: () => controller
                .updateContacts()
                .then((_) => controller.refreshController.refreshCompleted()),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller.loading) return const AppLoader();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CapsuleTextInput(
            controller: controller.textController,
            hintText: 'common_search'.tr,
            prefixIcon: AppIcons.search,
            onChange: controller.setText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            'contacts_results'
                .tr
                .replaceAll('{total}', controller.total.toString()),
            style: AppTextStyles.footnoteBold
                .withColor(AppColors.of(context).grey),
          ),
        ),
        ...controller.contacts.mapSaparated(
          (ContactModel c) => UserTile(user: c.member),
          (i) => const Divider(),
        ),
      ],
    );
  }
}
