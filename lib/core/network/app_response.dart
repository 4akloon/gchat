// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class AppResponse<S> {
  final bool success;
  final int code;
  final S data;
  final List<dynamic> errors;

  AppResponse({
    this.success = false,
    this.code = -1,
    required this.data,
    this.errors = const [],
  });

  AppResponse<S> copyWith({
    bool? success,
    int? code,
    S? data,
    List<dynamic>? errors,
  }) {
    return AppResponse<S>(
      success: success ?? this.success,
      code: code ?? this.code,
      data: data ?? this.data,
      errors: errors ?? this.errors,
    );
  }

  // ignore: avoid_shadowing_type_parameters
  AppResponse<S?> newGeneric<S>({
    bool? success,
    int? code,
    S? data,
    List<dynamic>? errors,
  }) {
    return AppResponse<S?>(
      success: success ?? this.success,
      code: code ?? this.code,
      data: data,
      errors: errors ?? this.errors,
    );
  }

  @override
  String toString() {
    return 'AppResponse(success: $success, code: $code, data: $data, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppResponse<S> &&
        other.success == success &&
        other.code == code &&
        other.data == data &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return success.hashCode ^ code.hashCode ^ data.hashCode ^ errors.hashCode;
  }
}
