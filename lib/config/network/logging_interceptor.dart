import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("<===========================On Error===========================>");
    log('');
    log("Error Type := ${err.type}");
    log('');
    log("Error Message := ${err.message}");
    log('');
    if (err.response != null) {
      log("Error Status Code := ${err.response?.statusCode}");
      log('');
      log("Error Response Data := ${err.response?.data}");
      log('');
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("<===========================On Request===========================>");
    log('');
    log("Request Method := ${options.method}");
    log('');
    log("Request Url := ${options.baseUrl}${options.path}");
    log('');
    log("Request Header := ${options.headers}");
    log('');
    log("Request Query Parameter := ${options.queryParameters}");
    log('');
    log("Request Data := ${options.data}");
    log('');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("<===========================On Response===========================>");
    log('');
    log("Response Header := ${response.headers}");
    log('');
    log("Response Status Code := ${response.statusCode}");
    log('');
    log("Response Data := ${response.data}");
    log('');
  }
}
