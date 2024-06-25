import 'package:config_env/data/notification/notify_service.dart';
import 'package:config_env/domain/configs/logger.dart';
import 'package:config_env/domain/repository/notify_service.dart';
import 'package:config_env/domain/repository/storage_data.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_logger.dart';
import '../data/local_data_manager.dart';
import '../data/network/http_error.dart';
import '../data/network/interceptor/setting_interceptor.dart';
import '../data/network/interceptor/token_interceptor.dart';
import '../data/repository_impl/auth_service_impl.dart';
import '../domain/configs/base_url.dart';
import '../domain/repository/auth_service.dart';
import '../domain/utils/enums.dart';

final GetIt serviceDI = GetIt.I;

Future<void> setupDI(Environment env) async {
  _registerLogger();

  _registerHttpError();

  _registerStorageData();

  _registerAuthService();

  _registerDio(env);

  registerNotifyService();

  await serviceDI.allReady();
}

void registerNotifyService() {
  serviceDI.registerLazySingleton<NotifyService>(() => NotifyServiceImp());
}

void _registerDio(Environment env) {
  serviceDI.registerFactoryParam<Dio, BaseUrl, void>((baseUrl, _) {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      baseUrl: baseUrl.url(env),
    );

    final logger = serviceDI.get<ILogger>();
    Dio dio = Dio(options);
    dio.interceptors.addAll([
      AuthInterceptor(),
      if (env == Environment.dev) LoggingInterceptor(logger),
      TokenInterceptor(dio, serviceDI.get<AuthService>()),
    ]);
    return dio;
  });
}

void _registerAuthService() {
  serviceDI.registerSingleton<AuthService>(AuthServiceImpl());
}

void _registerStorageData() {
  serviceDI.registerSingletonAsync<StorageData>(() async {
    final a = await SharedPreferences.getInstance();
    return LocalDataManager(sharedPreferences: a);
  });
}

void _registerHttpError() {
  serviceDI.registerFactory<HttpError>(() => HttpError());
}

void _registerLogger() {
  serviceDI.registerSingleton<ILogger>(AppLogger(
    filter: null,
    printer: PrettyPrinter(colors: false),
    output: null,
  ));
}