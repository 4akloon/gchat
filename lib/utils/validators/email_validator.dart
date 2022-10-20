part of 'validation_rule.dart';

class EmailValidator implements ValidationRule {
  @override 
  final String errorText;

  EmailValidator({
    this.errorText = 'validation_email',
  });

  @override
  RegExp get regex => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  bool validate(String? value) {
    if (value == null) {
      return false;
    }

    return regex.hasMatch(value);
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
