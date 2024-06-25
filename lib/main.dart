import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'di/service_di.dart';
import 'domain/repository/notify_service.dart';
import 'domain/repository/storage_data.dart';
import 'domain/utils/enums.dart';
import 'feature/food_app/food_app_widget.dart';

late final Environment currentEnvironment;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI(currentEnvironment);
  final mode = serviceDI.get<StorageData>().themeMode;

  await Firebase.initializeApp();

  await GetIt.I.get<NotifyService>().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(FoodAppWidget(themeMode: mode));
}
