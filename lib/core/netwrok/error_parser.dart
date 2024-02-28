import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../errors/error_response_model.dart';

class ErrorParser {
  // void _sendToCrashlytics(dynamic ex, StackTrace trace, AppError error) {
  //   if (error is Unknown || error is UnknownThrownError) {
  //     FirebaseCrashlytics.instance.log('unhandled exception');
  //     FirebaseCrashlytics.instance.recordError('$ex unhandled', trace);
  //   } else {
  //     FirebaseCrashlytics.instance.log('$error was handled');
  //     FirebaseCrashlytics.instance.recordError('$ex was handled', trace);
  //   }
  // }

  // void _sendToSentry(dynamic ex, StackTrace trace, AppError error) {
  //   if (error is Unknown || error is UnknownThrownError) {
  //     Sentry.captureException(ex, stackTrace: trace, hint: 'unhandled');
  //   } else {
  //     Sentry.captureException(ex,
  //         stackTrace: trace, hint: 'was handled as $error');
  //   }
  // }

  // void _logException(dynamic ex, StackTrace trace, AppError error) {
  //   _sendToCrashlytics(ex, trace, error);
  //   _sendToSentry(ex, trace, error);
  // }

  String parseError(dynamic ex) {
    String error = '';
    if (ex is DioError) {
      final errorResponseModel = ErrorResponseModel.fromJson(ex.response?.data);
      error = errorResponseModel.message ?? '';
    } else {
      error = ex.toString();
    }

    // _logException(ex, trace, error);
    debugPrint(error);
    return error;
  }
}
