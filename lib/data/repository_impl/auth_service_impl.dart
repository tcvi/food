import 'package:config_env/domain/repository/auth_service.dart';
import '../../domain/configs/base_url.dart';
import '../network/network.dart';

class AuthServiceImpl extends HttpAPI implements AuthService {
  @override
  BaseUrl get baseUrl => AuthUrl();

  @override
  Future<bool> login() async {
    await sendApiRequest(GET("/users"));
    return true;
  }

  @override
  Future<String> refreshToken() async {
    return "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjMxNTczMzMyODk2MDgsInVzZXJfaWQiOjM0fQ.aqHU8Oh-jZASVDs6IwA4rY14a6tR4sf1MlxkjzNpV2s";
  }
}


class AuthUrl extends BaseUrl {
  @override
  String get dev => "http://api.ow.teqn.asia/eazy-process/v1";

  @override
  String get prod => "https://auth";
}