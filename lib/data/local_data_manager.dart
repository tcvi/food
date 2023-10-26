import 'package:config_env/domain/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/repository/storage_data.dart';

class LocalDataManager extends StorageData {
  late final SharedPreferences _sharedPreferences;

  LocalDataManager({required SharedPreferences sharedPreferences}) {
    _sharedPreferences = sharedPreferences;
  }

  @override
  Future clearAll() => _sharedPreferences.clear();


  @override
  Future<bool> remove(String key) => _sharedPreferences.remove(key);

  @override
  String get token => _sharedPreferences.getString(_LocalDataManagerKey.token) ?? '';

  @override
  Future<bool> setToken(String token) => _sharedPreferences.setString(_LocalDataManagerKey.token, token);

  @override
  Future<bool> setThemeMode(AppThemeMode mode) => _sharedPreferences.setString(_LocalDataManagerKey.themeMode, mode.name);

  @override
  AppThemeMode get themeMode => AppThemeMode.from(_sharedPreferences.getString(_LocalDataManagerKey.themeMode) ?? '');

}

class _LocalDataManagerKey {
  static String token = "TOKEN-API";
  static String themeMode = "THEM";
}