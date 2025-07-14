import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'space_dark_theme.dart';
import 'space_light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _compactMode = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isCompactMode => _compactMode;

  ThemeData get currentTheme =>
      _themeMode == ThemeMode.dark ? spaceDarkTheme : spaceLightTheme;

  ThemeProvider() {
    _loadPrefs();
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _savePrefs();
    notifyListeners();
  }

  void toggleCompactMode(bool value) {
    _compactMode = value;
    _savePrefs();
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = prefs.getBool('isDarkMode') ?? true
        ? ThemeMode.dark
        : ThemeMode.light;
    _compactMode = prefs.getBool('isCompactMode') ?? false;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.setBool('isCompactMode', _compactMode);
  }
}
