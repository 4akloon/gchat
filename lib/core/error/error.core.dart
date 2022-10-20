// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:graphql/client.dart';

import '../../utils/log/log.mixin.dart';
import '../config/config.core.dart';
import '../connection/connection.core.dart';

class ErrorCore with Logger {
  final OnHandleError? _onHandleError;
  final _config = ConfigCore().config;
  final _connection = ConnectionCore();

  ErrorCore._([OnHandleError? onHandleError]) : _onHandleError = onHandleError;
  factory ErrorCore() => Get.find<ErrorCore>();
  static void initialize(OnHandleError? onHandleError) {
    Get.put<ErrorCore>(ErrorCore._(onHandleError), permanent: true);
  }

  void handleError({String? message, dynamic payload, int? code}) {
    logger("HandleError...");
    if (_connection.connected) {
      if (_onHandleError != null && message != null) {
        _onHandleError!(message, payload);
      }
    } else {
      _onHandleError!("error_no_connection");
    }
  }

  void throwError(
    dynamic e, {
    StackTrace stackTrace = StackTrace.empty,
    bool send = true,
    String? reason,
  }) {
    logger('error is $reason');
    if (_config.recordErrors) {
      // FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: reason);
    }
  }

  void graphErrorHandle(QueryResult<dynamic> response, bool showError) {
    int code = 0;
    String message = '';

    if (response.exception?.graphqlErrors != null &&
        response.exception!.graphqlErrors.isNotEmpty &&
        response.exception?.graphqlErrors[0].extensions != null) {
      try {
        final error = response.exception!.graphqlErrors[0];

        if (error.extensions!['category'] == 'validation') {
          final messages = error.extensions!['validation'] ?? [];
          message =
              messages.isNotEmpty ? messages.first.message : error.message;
        } else {
          message = error.message;
        }
      } catch (err) {
        logger(err);
      }
    }

    throwError(response.exception, reason: "Request: Error!");
    if (showError) handleError(code: code, message: message);
  }

  void apiErrorHandle(DioError error, bool showError) {
    throwError(
      {
        'url': error.requestOptions.path,
        'code': error.response?.statusCode,
        'data': error.response?.data,
      },
      stackTrace: error.stackTrace ?? StackTrace.fromString(error.toString()),
      reason: " REQUEST ERROR",
    );

    String? message = error.response?.data['message']?.toString();
    // ignore: empty_catches
    handleError(code: null, message: message);
  }
}

const Map<int, dynamic> errors = {
  0: "error_undefined", // Не понятная ошибка
  9999: "error_no_connection",
  10: "error_cannot_create_user_by_device_id",
  11: "error_failed_guest_authorize",
  20: "error_user_not_found",
  21: "error_failed_authorization",
  22: "error_registration",
  23: "error_reset_password_failed",
  // 24: "error_social_enter_failed",
  30: "error_failed_to_send_sms",
  31: "error_sms_token_not_found",
  32: "error_sms_token_lifetime_expired",
  33: "error_sms_incorrect_code",
  34: "error_action_token_not_found",
  40: "error_locality_not_found",
  41: "error_not_found_by_coordinates",
  50: "error_cant_leave_review_didnt_buy",
  // 51: "error_card_activation_request_error",
  // 52: "error_failed_card_validation",
  // 53: "error_order_not_found",
  // 54: "error_order_already_was_paid",
  // 55: "error_payment_error",
  // 56: "error_token_invalid",
  // 57: "error_code_verification_error",
  // 60: "error_address_not_found",
  70: "error_cart_item_not_found",
  71: "error_incorrect_quantity",
  72: "error_product_not_found",
  73: "error_cost_unit_not_specified",
  // 74: "error_incorrect_cost_variant",
  80: "error_cart_is_empty",
  81: "error_user_is_guest",
  82: "error_cant_register_user",
  // 83: "error_delivery_not_found",
  // 84: "error_delivery_not_allowed",
  85: "error_payment_not_found",
  86: "error_other_exception",
  87: "error_payment_or_card_not_specified",
  // 88: "error_incorrect_quantity",
  // 89: "error_cost_variant_not_specified",
  // 90: "error_incorrect_cost_variant",
  // 100: "error_promo_code_not_found",
  // 101: "error_unable_to_apply_promo_code",
  // 110: "error_order_not_found_110",
  // 111: "error_review_already_exists",
  // 112: "error_cant_store_review",
  // 113: "error_order_not_completed",
  120: "error_favorable_not_found",
  130: "error_order_not_found",
  // 140: "error_email_already_exists",
  141: "error_user_with_this_phone_exists",
  142: "error_password_must_be_different_from_the_old",
  143: "error_password_confirmation_must_be_same_with_password",
  144: "error_old_password_incorrect",
  150: "error_tracker_already_exist",
};

typedef OnHandleError = Function(String message, [dynamic payload]);
