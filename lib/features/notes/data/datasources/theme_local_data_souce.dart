import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDataSource {
  static const String _themeKey = "is_dark_theme";

  final SharedPreferences prefs;

  ThemeLocalDataSource(this.prefs);
  Future<void> saveTheme(bool isDark) async {
    await prefs.setBool(_themeKey, isDark);
  }

  bool loadTheme() {
    return prefs.getBool(_themeKey) ?? false; 
  }
}
