import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Colors
const kBackgroundColor = Color(0xFFFFFFFF);
const kPrimaryColor = Color(0xFF0D47A1);
const kSecondaryColor = Color(0xFFFFFFFF);
const kGreenColor = Color(0xFF1ED760);
const kRedColor = Color(0xFFD32F2F);
const kBlackColor = Color(0xFF18181B);

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  // SharedPreferences key for storing the theme preference
  static const String _themePreferenceKey = 'theme_preference';

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool(_themePreferenceKey) ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode newThemeMode) async {
    _themeMode = newThemeMode;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, newThemeMode == ThemeMode.dark);
  }
}

class MyIndexProvider with ChangeNotifier {
  int _myIndex = 0;

  int get myIndex => _myIndex;

  void setMyIndex(int newIndex) {
    _myIndex = newIndex;
    notifyListeners();
  }
}
