// ignore_for_file: empty_catches
import 'package:gchat/models/contact/contact.model.dart';

import '../core/db/base_db.dart';
import '../core/db/db.core.dart';

class ContactDB extends BaseDB {
  static ContactDB get instance => DBCore().getDataBase<ContactDB>();

  List<ContactModel> getContacts() =>
      box.values.map((e) => ContactModel.fromJson(e)).toList();

  Future<void> addContacts(List<ContactModel> value) => box.putAll(
        value.asMap().map((_, value) => MapEntry(value.id, value.toJson())),
      );

  Future<void> removeContact(String id) => box.delete(id);
}
