import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../utils/log/log.mixin.dart';
import '../network/app_response.dart';
import '../network/base_refresh.engine.dart';

part 'request.dart';

class ApiCore with Logger {
  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(contentType: 'application/json'),
  );

  final Function()? _onTokenRot;
  final Future<Map<String, String>> Function() _getDynamicHeaders;
  final BaseRefreshEngine? refreshEngine;
  final Map<String, String>? defaultHeaders;
  final Function(dio.DioError error, bool showError) _errorHandler;

  ApiCore({
    required String baseUrl,
    Function()? onTokenRot,
    required Future<Map<String, String>> Function() getDynamicHeaders,
    this.refreshEngine,
    this.defaultHeaders,
    required Function(dio.DioError error, bool showError) errorHandler,
  })  : _onTokenRot = onTokenRot,
        _getDynamicHeaders = getDynamicHeaders,
        _errorHandler = errorHandler {
    _dio.options.baseUrl = baseUrl;
  }
  Future init() async {
    await updateCore();
    Get.put(this, permanent: true);
  }

  static ApiCore get instance => Get.find<ApiCore>();

  Future<void> updateCore() async {
    final dynamicHeaders = await _getDynamicHeaders();
    _dio.options.headers = {
      ...?defaultHeaders,
      ...dynamicHeaders,
    };
  }

  Future<dio.Response> _request(
    _Request request, {
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    logger('Request: ${request.options?.method} ${request.path}');
    if (!force && (refreshEngine?.refreshing ?? false)) {
      return _addToStack(request);
    }
    late dio.Response response;
    try {
      response = await _dio.request(
        request.path,
        options: (request.options ?? dio.Options()).copyWith(
          method: request.type.name.toUpperCase(),
        ),
        queryParameters: request.queryParams,
      );
    } on dio.DioError catch (err) {
      logger("Request error: ${request.path}");
      logger(err.toString());
      response = err.response ??
          dio.Response(
            statusCode: 500,
            requestOptions: dio.RequestOptions(path: request.path),
          );
      if (response.statusCode == 401 &&
          refreshEngine != null &&
          !secondRequest) {
        refreshEngine!.refreshToken(updateCore, _onTokenRot);
        return _addToStack(request);
      } else {
        _errorHandler(err, showError);
      }
    }

    return response;
  }

  Future<dio.Response> _addToStack(_Request request) async {
    if (refreshEngine != null) {
      logger("Add to stack: ${request.options?.method} ${request.path}");

      if (refreshEngine!.ready) return _request(request);

      await for (var status in refreshEngine!.statusStream) {
        if (status == RefreshTokenStatus.rotten) break;
        if (status == RefreshTokenStatus.ready) {
          return _request(request, secondRequest: true);
        }
      }
    }
    return dio.Response(
      requestOptions: dio.RequestOptions(path: ''),
      statusCode: 500,
    );
  }

  Future<AppResponse<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    final response = await _request(
      _Request(
        path: path,
        queryParams: queryParameters,
        options: options,
      ),
      force: force,
      secondRequest: secondRequest,
      showError: showError,
    );
    return response.toAppResponse();
  }

  Future<AppResponse<dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    dio.Options? options,
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    final response = await _request(
      _Request(
        type: _RequestMethod.post,
        path: path,
        queryParams: queryParameters,
        options: options,
        data: data,
      ),
      force: force,
      secondRequest: secondRequest,
      showError: showError,
    );
    return response.toAppResponse();
  }

  Future<AppResponse<dynamic>> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    dio.Options? options,
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    final response = await _request(
      _Request(
        type: _RequestMethod.patch,
        path: path,
        queryParams: queryParameters,
        options: options,
        data: data,
      ),
      force: force,
      secondRequest: secondRequest,
      showError: showError,
    );
    return response.toAppResponse();
  }

  Future<AppResponse<dynamic>> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    dio.Options? options,
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    final response = await _request(
      _Request(
        type: _RequestMethod.put,
        path: path,
        queryParams: queryParameters,
        options: options,
        data: data,
      ),
      force: force,
      secondRequest: secondRequest,
      showError: showError,
    );
    return response.toAppResponse();
  }

  Future<AppResponse<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    dio.Options? options,
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    final response = await _request(
      _Request(
        type: _RequestMethod.delete,
        path: path,
        queryParams: queryParameters,
        options: options,
        data: data,
      ),
      force: force,
      secondRequest: secondRequest,
      showError: showError,
    );
    return response.toAppResponse();
  }
}
