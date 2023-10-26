enum Environment { dev, prod }

enum AppThemeMode {
  dark('dark'), light('light'), system('system');

  final String name;

  const AppThemeMode(this.name);

  factory AppThemeMode.from(String name) {
    switch (name.toLowerCase()) {
      case "dark":
        return AppThemeMode.dark;
      case "light":
        return AppThemeMode.light;
      case "system":
        return AppThemeMode.system;
      default:
        return AppThemeMode.system;
    }
  }
}