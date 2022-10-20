import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'locale.core.dart';

part 'lang.model.dart';

class AppTranslations implements Translations {
  final LocaleCore _service;

  AppTranslations({LocaleCore? service}) : _service = service ?? LocaleCore();

  @override
  Map<String, Map<String, String>> get keys => _service.keys;
}
