part of 'validation_rule.dart';

class NameValidator implements ValidationRule {
  @override
  final String errorText;
  final bool? numbers;
  NameValidator({
    this.errorText = 'validation_name',
    this.numbers,
  });

  @override
  RegExp get regex =>
      (numbers ?? true) ? RegExp(r".*") : RegExp(r"[a-z][a-z\s]*$");

  @override
  bool validate(String? value) {
    if (value == null) {
      return false;
    }
    return value.isNotEmpty && regex.hasMatch(value);
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
