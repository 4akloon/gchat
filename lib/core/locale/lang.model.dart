// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app.translations.dart';

class LangModel {
  final Locale locale;
  final Map<String, String> keys;

  MapEntry<String, Map<String, String>> get map =>
      MapEntry(locale.toString(), keys);

  LangModel({
    required this.locale,
    required this.keys,
  });

  LangModel copyWith({
    Locale? locale,
    Map<String, String>? keys,
  }) {
    return LangModel(
      locale: locale ?? this.locale,
      keys: keys ?? this.keys,
    );
  }
}
