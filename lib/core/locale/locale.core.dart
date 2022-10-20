import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../storage/storage.core.dart';
import 'base_locale.engine.dart';
import 'locale.db.dart';
import '../../utils/log/log.mixin.dart';
import 'app.translations.dart';

class LocaleCore with Logger {
  LocaleCore._(
    List<LangModel> langs, {
    BaseLocaleEngine? engine,
  })  : _langs = langs.obs,
        _engine = engine {
    _loadFromDb();
  }
  factory LocaleCore() => Get.find<LocaleCore>();
  static void initialize({
    required List<LangModel> langs,
    BaseLocaleEngine? engine,
  }) =>
      Get.put<LocaleCore>(LocaleCore._(langs, engine: engine), permanent: true);

  final LocaleDB _db = LocaleDB.instance;
  final StorageCore _storage = StorageCore();
  final BaseLocaleEngine? _engine;

  final RxList<LangModel> _langs;

  Map<String, Map<String, String>> get keys =>
      Map.fromEntries(_langs.map((e) => e.map));

  List<Locale> get supportedLocales => _langs.map((e) => e.locale).toList();

  void _loadFromDb() {
    logger('Load from database...');
    for (int i = 0; i < supportedLocales.length; i++) {
      final keys = _db.tranlations(supportedLocales[i].toString());
      if (keys != null) _langs[i] = _langs[i].copyWith(keys: keys);
    }
  }

  Future<void> validteFromRepo() async {
    logger('Fetch from repo...');
    Future.forEach(
      supportedLocales,
      (locale) async {
        final repoHash = await _engine?.validateTranslateHash(locale);
        final localHash = _getTranslatesHash(locale);
        if (repoHash != localHash) {
          _setTranslatesHash(locale, repoHash);
          final translates = await _engine?.fetchTranslatesfromRepo(locale);
          final index = supportedLocales.indexOf(locale);
          _langs[index] = _langs[index].copyWith(keys: translates);
        }
      },
    );
    for (int i = 0; i < supportedLocales.length; i++) {}
  }

  String? _getTranslatesHash(Locale locale) =>
      _storage.getString('hash_$locale');
  Future _setTranslatesHash(Locale locale, String? value) =>
      _storage.setString('hash_$locale', value);
}
