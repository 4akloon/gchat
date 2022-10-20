part of 'auth.repository.dart';

class _Playground {
  final sendSms = '''mutation sendSms(\$phone: String!) {
  sendSms(phone: \$phone)
}''';

  final confirmPasscode =
      '''mutation confirmPasscode(\$token: String!, \$code: String!) {
  confirmPasscode(token: \$token, code: \$code) {
    accessToken
    refreshToken
    user { ${UserModel.graph} }
  }
}
''';
  final refreshToken = '''mutation refreshToken(\$token: String!) {
  refreshToken(token: \$token) {
    accessToken
    refreshToken
    user { ${UserModel.graph} }
  }
}
''';
  final logout = 'mutation logout { logout }';
}
