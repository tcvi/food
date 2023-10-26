import '../utils/enums.dart';
import 'environment_value.dart';

abstract class BaseUrl extends EnvironmentValue<String> {
  String url(Environment env) => getData(env);
}

abstract class BaseApi {
  BaseUrl get baseUrl;
}