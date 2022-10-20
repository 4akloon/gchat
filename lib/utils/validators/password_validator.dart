part of 'validation_rule.dart';

class PasswordValidator implements ValidationRule {
  @override
  final String errorText;

  PasswordValidator({
    this.errorText = 'validation_error_password',
  });

  @override
  RegExp get regex => RegExp(r".*");

  @override
  bool validate(String? value) {
    if (value == null) {
      return false;
    }

    return value.length >= 8;
  }

  @override
  String? validateInput(String? value) {
    if (value == null) {
      return errorText;
    }

    if (validate(value)) {
      return null;
    }

    return errorText;
  }
}
