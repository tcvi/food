import 'package:dio/dio.dart';
import '../../../domain/repository/auth_service.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authRepository;

  TokenInterceptor(this._dio, this._authRepository);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    if (response != null && response.statusCode == 401) {
      // Refresh the token
      final refreshedToken = await _authRepository.refreshToken();

      // Retry the failed request with the new token
      final options = response.requestOptions;
      options.headers['Authorization'] = refreshedToken;
      final retryResponse = await _dio.fetch(options);

      // Return the successful response
      handler.resolve(retryResponse);
      return;
    }
    super.onError(err, handler);
  }
}
