part of 'contact.repository.dart';

class _Playground {
  final contacts = '''
query contacts(\$page: Int = 1, \$perPage: Int = 10, \$text: String) {
  contacts(page: \$page, perPage: \$perPage, text: \$text) { 
    ${PaginatorModel.graph(ContactModel.graph)}
  }
}''';

  final contact = '''query contact(\$id: String!) { 
  contact(id: \$id) { ${ContactModel.graph} }
}''';
  final addContact = '''mutation addContact(\$userId: String!) {
  addContact(userId: \$userId) { ${ContactModel.graph} }
}''';
}
