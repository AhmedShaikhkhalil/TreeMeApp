import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:treeme/core/utils/image_picker/i_image_file.dart';
import 'package:treeme/core/utils/services/storage.dart';

import '../../modules/chat/presentation/pages/generate_token_new.dart';
import '../config/apis/auth_header.dart';
import '../config/apis/config_api.dart';
import '../helpers/page_loading_dialog/page_loading_dialog.dart';

class WebServiceConnections {
  WebServiceConnections(
    this._dioInstance,
    this._storage,
    this._pageLoading,
  );

  final dio.Dio _dioInstance;
  final Storage _storage;
  final IPageLoadingDialog _pageLoading;

  Future<dio.Response> getRequest({
    String? path,
    bool showLoader = false,
    bool useMyPath = false,
  }) async {
    PageLoadingDialogStatus? loader;
    if (showLoader) {
      loader = _pageLoading.showLoadingDialog();
    }
    if (kDebugMode) {
      _dioInstance.interceptors.add(CurlLoggerDioInterceptor(
        printOnSuccess: true,
      ));
    }
    dio.Response response;
    try {
      response = await _dioInstance.get(
        useMyPath ? path! : '${API.baseUrl}$path',
        options: AuthHeader.getBaseOption(
          jwtToken: _storage.jwtToken,
        ),
      );
      //
      if (showLoader) {
        loader?.hide();
      }
      log('${response.data}');
      return response;
    } on dio.DioException catch (e) {
      if (showLoader) {
        loader?.hide();
      }
      debugPrint(e.response?.data.toString());
      rethrow;
    }
  }

  Future<dio.Response> postRequest({
    String? path,
    Map<String, dynamic>? data,
    bool showLoader = false,
    bool useMyPath = false,
    IImageFile? file,
  }) async {
    print('heeelo');
    PageLoadingDialogStatus? loader;
    if (showLoader) {
      loader = _pageLoading.showLoadingDialog();
    }
    if (kDebugMode) {
      _dioInstance.interceptors.add(CurlLoggerDioInterceptor(
          // printOnSuccess: false,
          ));
    }
    dio.Response response;
    try {
      if (file != null) {
        dio.FormData formData = dio.FormData.fromMap({
          "avatar": await dio.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          ),
        });
        data?.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
        response = await _dioInstance.post(
          '${API.baseUrl}$path',
          options: AuthHeader.getBaseOption(jwtToken: _storage.jwtToken),
          data: formData,
        );
      } else {
        response = await _dioInstance.post(
          useMyPath ? path! : '${API.baseUrl}$path',
          options: AuthHeader.getBaseOption(jwtToken: _storage.jwtToken),
          data: data,
        );
        print('${response.statusMessage}');
      }
      log("log:path:$path:${response.data}");
      if (showLoader) {
        loader?.hide();
      }
      return response;
    } on dio.DioException catch (e) {
      if (showLoader) {
        loader?.hide();
      }
      debugPrint(e.response?.data.toString());
      rethrow;
    }
  }

  Future<dio.Response> postFirebaseRequest({
    String? path,
    Map<String, dynamic>? data,
    bool showLoader = false,
    bool useMyPath = false,
    IImageFile? file,
  }) async {
    print('heeelo');
    PageLoadingDialogStatus? loader;
    if (showLoader) {
      loader = _pageLoading.showLoadingDialog();
    }
    if (kDebugMode) {
      _dioInstance.interceptors.add(CurlLoggerDioInterceptor(
          // printOnSuccess: false,
          ));
    }
    dio.Response response;
    try {
      if (file != null) {
        print('sendinggg1');
        dio.FormData formData = dio.FormData.fromMap({
          "avatar": await dio.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          ),
        });
        data?.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
        response = await _dioInstance.post(
          '${API.baseUrl}$path',
          options: AuthHeader.getBaseOption(jwtToken: _storage.jwtToken),
          data: formData,
        );
      } else {
        /**have to edit token
         *
         */
        print('sendinggg2');

        final oauth2Token = await FirebaseAccessToken().getToken();


        response = await _dioInstance.post(
          useMyPath ? path! : '${API.baseUrl}$path',
          options: dio.Options(headers: {
            'Authorization': 'Bearer $oauth2Token',
            // 'Authorization': 'Bearer ya29.c.c0ASRK0GYZcOc0ovAIQ67tVV9qAqkDuZttpu5FVnGqTjsgVuUtryOmqaeA2LQGX0cqqAQOHWe14e0TDJ2nlBZxlNgrUrJlQzzOV3DEjC_AZJfQucTdp6c-XfYNB4yZqgw7jyt2MOvF1ZxNLz3UfMYWxoRqAVtx0EghrxLEYRWMKTmRdlIKZZmSjXtB7CycehGgpo2-9ODbiJRo3TjXY5roePrvAvqjLd8R9lKxhVpBYLpMxEdfmftX3ppUFP_6Xp18wR4yxZnL9wa__vEccsP8WT8EcxJ3hp2HryhYlIHHVthEJ6iySO6xqIThkbCbkMTgneXN2_d8_ttQBfFYGrws_25oT311TzocBpDCWNrSByKQvHnjE2EfEKgN384PY5F5jow2h6qR1ypSXVhX1FpOWkhxBRxxUqarvykQIxjSOWIrUiSuSytfv2znWYcWb4t-cJSxuZtM_z3RMzgfxB_puMQF2Q5yqhaoUstq9Jjp7B1YdS8-FWtfdxVqmi05OJke7u9qsUI3smV5Ifm1pjhuxqxoUtt_-4QUSZJeZXmIY0sn2n08WJ948OS8Ia0Jxurwfn78QWvBanYX_Xa9-nrY_SU0uo-w50v7MpO9YiVXje1Y0l2-lbscv-M14md60bxWs0eJo_7VzaUFjtYW2bJn0905_iOUyMBp2BFhpc1_SpVkWsnws98OXk0FtZkoUBlBnXm7-_9pt_z_pxd-a9iucqBkqklnbYlaUqUoykZlORWY-aBR3vtWoO_bSJ0FWqJ3tyfk2qmakz83IlaOzwoeI4v8s9zzIzVsjiJYyVzxIhFaOdWO9Ma3jv8d0y5Infa3lWsahnZ5qV7zSVxcxb2eVapfqtYe_MMwUMVfBfF6S2e1okQa_3OBaFteuOew57uFS29FedqrhtRFmfwV0b1I008i5zBaSZi--mjtl7BmFrRQ1s9citR1Wi4JYB3tXFdqd2jmks7zBl2craa-8UkoocWrtyq6dWOQ9wdoM4ejbza-aYXms933M_6',
            'content-type' : 'application/json',
          }),
          data: data,
        );
        

        print('${response.statusMessage}');
      }
      log("log:path:$path:${response.data}");
      if (showLoader) {
        loader?.hide();
      }
      return response;
    } on dio.DioException catch (e) {
      if (showLoader) {
        loader?.hide();
      }
      debugPrint(e.response?.data.toString());
      rethrow;
    }
  }
  // Future<dio.Response> postPaymentRequest({
  //   String? path,
  //   Map<String, dynamic>? data,
  //   bool showLoader = false,
  // }) async {
  //   PageLoadingDialogStatus? loader;
  //   if (showLoader) {
  //     loader = _pageLoading.showLoadingDialog();
  //   }
  //   if (!kReleaseMode) {
  //     _dioInstance.interceptors.add(CurlLoggerDioInterceptor(
  //       printOnSuccess: false,
  //     ));
  //   }
  //   dio.Response response;
  //   try {
  //     response = await _dioInstance.post(
  //       '${API.baseUrlStrip}$path',
  //       options: AuthHeader.getBaseOptionStrip(),
  //       data: data,
  //     );
  //     log("log:path:$path:${response.data}");
  //     if (showLoader) {
  //       loader?.hide();
  //     }
  //     return response;
  //   } on dio.DioError catch (e) {
  //     if (showLoader) {
  //       loader?.hide();
  //     }
  //     debugPrint(e.response?.data.toString());
  //     rethrow;
  //   }
  // }
}
