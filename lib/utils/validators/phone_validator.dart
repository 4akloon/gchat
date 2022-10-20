part of 'validation_rule.dart';

class PhoneValidator implements ValidationRule {
  @override
  final String errorText;

  PhoneValidator({
    this.errorText = 'validation_phone',
  });

  @override
  RegExp get regex => RegExp(r"^(?:\+38)?(0\d{9})$");

  @override
  bool validate(String? value) {
    if (value == null) return false;
    final text = PhoneFormatter.cleanPhone(value)!;
    return regex.hasMatch(text);
  }

  @override
  String? validateInput(String? value) {
    if (value == null || value.length < 13) return errorText;
    if (!validate(value)) return errorText;
    return null;
  }
}
