import 'package:flutter/widgets.dart';
import 'package:gchat/models/user/user.model.dart';
import 'package:gchat/repositories/contact/contact.repository.dart';
import 'package:gchat/repositories/user/user.repository.dart';
import 'package:get/get.dart';

class ContactAddController extends GetxController {
  final UserRepository _userRepository;
  final ContactRepository _contactRepository;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  ContactAddController({
    UserRepository? userRepository,
    ContactRepository? contactRepository,
  })  : _userRepository = userRepository ?? UserRepository(),
        _contactRepository = contactRepository ?? ContactRepository() {
    ever(_phone, (v) {
      if (v.length == 13) {
        findUser();
      } else {
        _result.value == null;
      }
    });
  }

  final _phone = ''.obs;
  final _loading = false.obs;
  final _adding = false.obs;
  final Rx<UserModel?> _result = Rx<UserModel?>(null);

  bool get loading => _loading.value;
  bool get adding => _adding.value;
  UserModel? get result => _result.value;

  void setPhone(String value) => _phone(value);

  Future<void> findUser() async {
    if (!formKey.currentState!.validate()) return;
    _loading(true);
    final response = await _userRepository.findUserByPhone(_phone.value);
    if (response.success) _result.value = response.data;
    _loading(false);
  }

  Future<void> addContact() async {
    if (result == null) return;
    _adding(true);
    final response = await _contactRepository.addContact(result!.id);
    if (response.success) Get.back(result: response.data);
    _adding(false);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
