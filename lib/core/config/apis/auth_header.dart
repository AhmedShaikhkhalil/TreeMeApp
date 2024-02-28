import 'dart:developer';

import 'package:dio/dio.dart';

class AuthHeader {
  static final Map<String, String> headers = <String, String>{
    'content-type': 'application/json',
    "Accept": "application/json"
  };

  static Options getBaseOption({
    String? jwtToken,
  }) {
    log('jwtToken$jwtToken');
    if ((jwtToken ?? '').isNotEmpty) {
      headers.putIfAbsent(
        'Authorization',
        () => 'Bearer $jwtToken',
      );
    }
    return Options(
      receiveTimeout: Duration(seconds: 3),
      headers: headers,
      // followRedirects: false,
      // validateStatus: (status) {
      //   return (status ?? 0) < 500;
      // },
    );
  }

  static Options getFirbaseBaseOption({
    String? jwtToken,
  }) {
    log('jwtToken$jwtToken');
    if ((jwtToken ?? '').isNotEmpty) {
      headers.putIfAbsent(
        'Authorization',
        () => 'key=$jwtToken',
      );
    }
    return Options(
      receiveTimeout: Duration(seconds: 3),
      headers: headers,
      // followRedirects: false,
      // validateStatus: (status) {
      //   return (status ?? 0) < 500;
      // },
    );
  }

  static Map<String, String> headerStrip = {
    'Authorization': 'Bearer ',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static Options getBaseOptionStrip() {
    return Options(
      receiveTimeout: Duration(seconds: 3),
      headers: headerStrip,
    );
  }
}
