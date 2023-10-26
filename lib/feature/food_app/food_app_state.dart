part of 'food_app_bloc.dart';

@immutable
class FoodAppState {
  final AppThemeMode mode;

  const FoodAppState({required this.mode});


  ThemeMode get themMode {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
