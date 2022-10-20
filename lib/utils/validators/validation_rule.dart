import 'package:gchat/utils/formatters/phone_formatter.dart';

part 'email_validator.dart';
part 'name_validator.dart';
part 'password_validator.dart';
part 'phone_validator.dart';
part 'answer_validator.dart';

abstract class ValidationRule {
  final RegExp regex;
  final String errorText;

  ValidationRule({
    required this.regex,
    required this.errorText,
  });

  bool validate(String? value);

  String? validateInput(String? value);

  factory ValidationRule.email() {
    return EmailValidator();
  }

  factory ValidationRule.name() {
    return NameValidator();
  }
}
