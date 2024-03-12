import 'package:flutter/material.dart';

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

  void setThemeMode(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    notifyListeners();
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
