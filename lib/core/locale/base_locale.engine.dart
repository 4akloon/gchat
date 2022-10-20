import 'package:flutter/widgets.dart';

abstract class BaseLocaleEngine {
  Future<String?> validateTranslateHash(Locale locale);

  Future<Map<String, String>?> fetchTranslatesfromRepo(Locale locale);
}
