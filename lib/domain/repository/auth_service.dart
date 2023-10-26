abstract class AuthService {
  Future<bool> login();
  Future<String> refreshToken();
}