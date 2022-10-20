import 'package:flutter/material.dart';
import 'package:gchat/databases/contact.db.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/contact/contact.model.dart';
import '../../repositories/contact/contact.repository.dart';

class ContactsController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final RefreshController refreshController = RefreshController();
  final ContactRepository _contactRepository;
  final ContactDB _contactDB;
  ContactsController({
    ContactRepository? contactRepository,
    ContactDB? contactDB,
  })  : _contactRepository = contactRepository ?? ContactRepository(),
        _contactDB = contactDB ?? ContactDB() {
    _contacts = _contactDB.contacts.obs;
  }

  late final RxList<ContactModel> _contacts;
  final _loading = false.obs;
  final _page = 1.obs;
  final _hasMorePages = false.obs;
  final _total = 0.obs;
  final _text = ''.obs;

  List<ContactModel> get contacts => _contacts;
  bool get hasMorePages => _hasMorePages.value;
  bool get loading => _loading.value;
  int get total => _total.value;

  void setText(String value) => _text(value);

  @override
  void onInit() {
    updateContacts();
    debounce(
      _text,
      (v) => updateContacts(),
      time: const Duration(milliseconds: 300),
    );
    ever(_contacts, (v) {
      if (_text.isEmpty) _contactDB.setContacts(v);
    });
    super.onInit();
  }

  Future<void> updateContacts() async {
    _loading(_contacts.isEmpty && !refreshController.isRefresh);
    _page(1);
    final response = await _contactRepository.contacts(
      page: _page.value,
      text: _text.isEmpty ? '' : _text.value,
    );
    _loading(false);
    if (response.success) {
      _contacts(response.data!.data);
      _hasMorePages(response.data!.hasMorePages);
      _total(response.data!.total);
    }
  }

  Future<void> loadContacts() async {
    _page(_page.value + 1);
    final response = await _contactRepository.contacts(
      page: _page.value,
      text: _text.isEmpty ? '' : _text.value,
    );
    if (response.success) {
      _contacts.addAll(response.data!.data);
      _hasMorePages(response.data!.hasMorePages);
    }
  }

  @override
  void onClose() {
    textController.dispose();
    refreshController.dispose();
    super.onClose();
  }
}
