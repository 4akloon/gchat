import '../db/base_db.dart';
import '../db/db.core.dart';

class LocaleDB extends BaseDB {
  static LocaleDB get instance => DBCore().getDataBase<LocaleDB>();

  Map<String, String>? tranlations(String locale) {
    final data = box.get('translations_$locale');
    return data;
  }

  void setTranslations(String locale, Map<String, String> map) =>
      box.put('translations_$locale', map);
}
