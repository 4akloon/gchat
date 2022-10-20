part of 'api.core.dart';

enum _RequestMethod { get, post, put, delete, patch }

class _Request {
  final _RequestMethod type;
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParams;
  final dio.Options? options;

  _Request({
    this.type = _RequestMethod.get,
    required this.path,
    this.data,
    this.queryParams,
    this.options,
  });

  _Request copyWith({
    _RequestMethod? type,
    String? path,
    dynamic data,
    Map<String, dynamic>? queryParams,
    dio.Options? options,
  }) {
    return _Request(
      type: type ?? this.type,
      path: path ?? this.path,
      data: data ?? this.data,
      queryParams: queryParams ?? this.queryParams,
      options: options ?? this.options,
    );
  }
}

extension ResponseExt on dio.Response {
  AppResponse toAppResponse() {
    Map<String, dynamic>? newData;
    try {
      newData = data;
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
    return AppResponse<dynamic>(
      data: newData?['data'],
      success: newData?['success'] ?? statusCode == 200,
      code: newData?['code'] ?? -1,
      errors: newData?['message'] != null ? [newData?['message']] : [],
    );
  }
}
