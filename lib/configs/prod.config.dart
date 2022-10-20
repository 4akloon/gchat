import '../core/config/config.core.dart';

final prodConfig = ConfigModel(
  name: 'prod',
  baseUrl: 'https://api.cooperandhunter.us/graphql',
  debug: false,
  recordErrors: true,
);
