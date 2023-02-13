// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:graphql/src/core/_base_options.dart';
import "package:gql/src/language/printer.dart";

import '../../utils/log/log.mixin.dart';
import '../network/app_response.dart';
import '../network/base_refresh.engine.dart';

class GraphCore with Logger {
  final Function()? _onTokenRot;
  final Future<Map<String, String>> Function() _getDynamicHeaders;
  final Map<String, String>? defaultHeaders;
  final String baseUrl;
  final BaseRefreshEngine? refreshEngine;
  final Function(QueryResult<dynamic> response, bool showError) _errorHandler;
  late GraphQLClient graphClient;

  GraphCore({
    required this.baseUrl,
    Function()? onTokenRot,
    required Future<Map<String, String>> Function() getDynamicHeaders,
    this.refreshEngine,
    this.defaultHeaders,
    required Function(QueryResult<dynamic> response, bool showError)
        errorHandler,
  })  : _onTokenRot = onTokenRot,
        _getDynamicHeaders = getDynamicHeaders,
        _errorHandler = errorHandler;

  static GraphCore get instance => Get.find<GraphCore>();

  Future<void> init() async {
    await updateCore();
    Get.put(this, permanent: true);
  }

  Future<void> updateCore() async {
    logger('Update core');
    final dynamicHeaders = await _getDynamicHeaders();
    Link link = HttpLink(
      baseUrl,
      defaultHeaders: {
        ...?defaultHeaders,
        ...dynamicHeaders,
      },
    );

    graphClient = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
      defaultPolicies: DefaultPolicies(
        mutate: Policies(fetch: FetchPolicy.networkOnly),
        query: Policies(fetch: FetchPolicy.networkOnly),
        subscribe: Policies(fetch: FetchPolicy.networkOnly),
      ),
    );
  }

  Future<AppResponse<dynamic>> request(
    BaseOptions options, {
    bool force = false,
    bool secondRequest = false,
    bool showError = true,
  }) async {
    bool isUnauthorized(QueryResult response) =>
        (response.exception?.graphqlErrors.isNotEmpty ?? false) &&
        response.exception!.graphqlErrors.first.extensions?['code'] ==
            "unauthorized";

    logger("Request: ${_getRequestName(options)}");
    if (!force && (refreshEngine?.refreshing ?? false)) {
      return _addToStack(options);
    } else {
      late final QueryResult<Object?> response;
      if (options is MutationOptions) {
        response = await graphClient.mutate(options);
      } else if (options is QueryOptions) {
        response = await graphClient.query(options);
      } else {
        throw UnimplementedError();
      }
      if (!response.hasException) {
        return AppResponse(data: response.data, success: true);
      } else if (isUnauthorized(response) && !secondRequest) {
        if (refreshEngine != null) {
          refreshEngine!.refreshToken(updateCore, _onTokenRot);
          return _addToStack(options);
        } else {
          if (_onTokenRot != null) _onTokenRot!();
        }
      }
      _errorHandler(response, showError);
      return AppResponse(
        data: response.data,
        success: false,
        errors: response.exception?.graphqlErrors ??
            [const GraphQLError(message: 'Something error')],
      );
    }
  }

  Future<AppResponse<dynamic>> _addToStack(BaseOptions options) async {
    if (refreshEngine != null) {
      logger("Add to stack: ${_getRequestName(options)}");

      if (refreshEngine!.ready) return request(options);

      await for (var status in refreshEngine!.statusStream) {
        if (status == RefreshTokenStatus.rotten) break;
        if (status == RefreshTokenStatus.ready) {
          return request(options, secondRequest: true);
        }
      }
    }
    return AppResponse(
      data: null,
      success: false,
      errors: [
        const GraphQLError(message: 'Something error'),
      ],
    );
  }

  String _getRequestName(BaseOptions options) {
    final name = json
        .encode(printNode(options.document))
        .trim()
        .replaceAll('\n', '')
        .replaceAll('(', ' ')
        .split(' ')[1];

    return "{ type: ${options.type.name}, name: $name}";
  }
}
