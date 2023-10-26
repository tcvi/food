import 'dart:convert';

import 'package:config_env/domain/configs/logger.dart';
import 'package:dio/dio.dart';

import '../../../di/service_di.dart';
import '../../../domain/repository/storage_data.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final localDataManager = serviceDI.get<StorageData>();
    final token = localDataManager.token;
    if (token?.isNotEmpty == true) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}

class LoggingInterceptor extends Interceptor {
  final ILogger logger;
  final JsonEncoder _encoder = const JsonEncoder.withIndent('  ');
  LoggingInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      '=== REQUEST ===\n'
      'URL: ${options.baseUrl}${options.path}\n'
      'Method: ${options.method}\n'
      'Headers: ${options.headers}\n'
      'Data: ${_encoder.convert(options.data)}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response information after receiving the network response
    logger.i('=== RESPONSE ===\n'
        'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}\n'
        'Status Code: ${response.statusCode}\n'
        'Headers: ${response.headers}\n'
        'Data: ${_encoder.convert(response.data)}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.i('=== ERROR ===\n'
        'URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}\n'
        'Status Code: ${err.response?.statusCode}\n'
        'Error: ${err.message}');
    super.onError(err, handler);
  }
}