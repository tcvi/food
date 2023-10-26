import 'package:config_env/domain/configs/logger.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpError implements Exception {
  final ILogger logger = GetIt.instance.get();
  static const int CODE_NO_INTERNET = 10001;
  final int? code;

  final String message;
  final Map? body;

  HttpError({
    this.code,
    this.message = '',
    this.body,
  });

  factory HttpError.error(
      Exception e, {
        defaultError = 'Server error, please try again!',
      }) {
    String message = defaultError;
    if (e is DioException) {
      Map? data = e.response?.data ;

      if (data is Map &&
          data.containsKey('errors') &&
          data['errors'] is String) {
        message = data['errors'];
      }
      return HttpError(
          code: e.response?.statusCode, body: data, message: message);
    }
    return HttpError(message: message);
  }

  void handleError(error) {
    String message = 'Server error, please try again!';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Connect timeout, cannot connect to server!';
          break;
        case DioExceptionType.unknown:
          if (error.error != null) {
            message = error.error.toString();
          }
          break;
        default:
          break;
      }
      final data = error.response?.data;
      if (data != null && data is Map) {
        if (data.containsKey('message') && data['message'] is String) {
          message = data['message'];
        } else if (data.containsKey('error') && data['error'] is String) {
          message = data['error'];
        } else if (data.containsKey('errors')) {
          if (data['errors'] is String) message = data['errors'];
          if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
            message = (data['errors'] as List)[0];
          }
        }
      }
      final statusCode = error.response?.statusCode;
      // Check type error

      throw NetworkException(message: message, code: statusCode);
    } else {
      logger.i(message);
    }
  }

  void withOutInternet({noInternetError = 'No Internet!'}) {
    throw HttpError(code: CODE_NO_INTERNET, message: noInternetError);
  }

  @override
  String toString() {
    return message.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HttpError &&
              runtimeType == other.runtimeType &&
              code == other.code &&
              message == other.message &&
              body == other.body;

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ body.hashCode;
}

class NetworkException implements Exception {
  final String? message;

  final int? code;

  const NetworkException({this.message, this.code});

  @override
  String toString() {
    return message ?? runtimeType.toString();
  }

}
