import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool? isDark;

  ThemeMode get getThemeMode => _themeMode;

  ThemeProvider() {
    _fetchSavedTheme();
  }

  void _isDarkStatusUpdate(ThemeMode mode) {
    if (mode == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }
  }

  Future<void> _fetchSavedTheme() async {
    ThemeMode tm = await _savedThemeMode();
    _themeMode = tm;
    _isDarkStatusUpdate(_themeMode);
    notifyListeners();
  }

  void changeThemeMode(ThemeMode newThemeMode) {
    if (_themeMode != newThemeMode) {
      _themeMode = newThemeMode;
      _saveThemeMode(newThemeMode);
      _isDarkStatusUpdate(newThemeMode);
      notifyListeners();
    }
  }

  Future<void> _saveThemeMode(ThemeMode tm) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('themeMode', tm.name);
  }

  Future<ThemeMode> _savedThemeMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String mode = preferences.getString("themeMode") ?? 'light';
    switch (mode) {
      case ('light'):
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
