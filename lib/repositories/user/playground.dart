part of 'user.repository.dart';

class _Playground {
  final currentUser = '''query currentUser {
  currentUser { ${UserModel.graph} }
}
''';
  final findUserByPhone = '''query findUserByPhone(\$phone: String!) {
  findUserByPhone(phone: \$phone) { ${UserModel.graph} }
}
''';
}
