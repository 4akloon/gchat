// ignore_for_file: empty_catches
import 'package:gchat/models/contact/contact.model.dart';

import '../core/db/base_db.dart';
import '../core/db/db.core.dart';

class ContactDB extends BaseDB {
  static ContactDB get instance => DBCore().getDataBase<ContactDB>();

  List<ContactModel> get contacts {
    final data = box.get('contacts');
    if (data != null) {
      try {
        return List.from(data).map((e) => ContactModel.fromJson(e)).toList();
      } catch (err) {}
    }
    return [];
  }

  void setContacts(List<ContactModel> value) => box.put(
        'contacts',
        value.map((e) => e.toJson()).toList(),
      );
}
