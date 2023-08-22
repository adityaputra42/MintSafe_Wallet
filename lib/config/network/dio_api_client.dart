
import 'package:dio/dio.dart';

import 'logging_interceptor.dart';


class DioApiClient {
  static Dio? _instance;
  Dio dio = Dio();

  static Dio? getInstance() {
    if (_instance == null) {
      var options = BaseOptions(
          baseUrl: '',
          receiveDataWhenStatusError: true,
          validateStatus: (statusCode) => statusCode! < 500,
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
        
          );

      _instance = Dio(options);
      _instance!.interceptors.add(LoggingInterceptor());
    }
    return _instance;
  }
}
