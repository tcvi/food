import '../utils/enums.dart';

abstract class StorageData {
  Future clearAll();

  Future<bool> remove(String key);

  Future<bool> setToken(String token);

  String get token;

  Future<bool> setThemeMode(AppThemeMode mode);

  AppThemeMode get themeMode;
}