part of 'config.core.dart';

class ConfigModel {
  final String name;
  final String baseUrl;
  final bool debug;
  final bool recordErrors;

  ConfigModel({
    required this.name,
    required this.baseUrl,
    this.debug = true,
    this.recordErrors = false,
  });

  @override
  String toString() {
    return 'ConfigModel(name: $name, baseUrl: $baseUrl, debug: $debug, recordErrors: $recordErrors)';
  }

  @override
  bool operator ==(covariant ConfigModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.baseUrl == baseUrl &&
        other.debug == debug &&
        other.recordErrors == recordErrors;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        baseUrl.hashCode ^
        debug.hashCode ^
        recordErrors.hashCode;
  }

  ConfigModel copyWith({
    String? name,
    String? baseUrl,
    bool? debug,
    bool? recordErrors,
  }) {
    return ConfigModel(
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      debug: debug ?? this.debug,
      recordErrors: recordErrors ?? this.recordErrors,
    );
  }
}
