part of 'validation_rule.dart';

class AnswerValidator implements ValidationRule {
  @override
  final String errorText = '';
  final bool isValid;
  AnswerValidator({
    this.isValid = false,
  });

  @override
  RegExp get regex => RegExp(r"[a-z][a-z\s]*$");

  @override
  bool validate(String? value) => isValid;

  @override
  String? validateInput(String? value) => isValid ? null : errorText;
}
