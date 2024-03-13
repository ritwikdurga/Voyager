// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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

final List<Map<String, dynamic>> Categories = [
  {'icon': Icons.restaurant_menu, 'text': 'Restaurant'},
  {'icon': Icons.attractions_outlined, 'text': 'Attractions'},
  {'icon': Icons.coffee_maker_outlined, 'text': 'Cafes'},
  {'icon': Icons.photo_camera, 'text': 'Photo Spots'},
  {'icon': Icons.fastfood_outlined, 'text': 'Fast Foods'},
  {'icon': Icons.bakery_dining_outlined, 'text': 'Bakeries'},
  {'icon': Icons.sports_bar_outlined, 'text': 'Breweries'},
  {'icon': Icons.favorite, 'text': 'Romantic Places'},
  {'icon': Icons.shopping_bag_outlined, 'text': 'Shopping'},
  {'icon': Icons.museum_outlined, 'text': 'Museums'},
  {'icon': Icons.nightlife_rounded, 'text': 'Night Life'},
  {'icon': Icons.rocket_launch_sharp, 'text': 'Space Museuems'},
  //{'icon': Icons., 'text': 'Zoos'},
  //{'icon': Icons.access_alarm, 'text': 'Theme Parks'},
  {'icon': Icons.location_city_outlined, 'text': 'Historic Building'},
  //{'icon': Icons.access_alarm, 'text': 'Water Parks'},
  {'icon': Icons.hiking_outlined, 'text': 'Hiking'},
  //{'icon': Icons.access_alarm, 'text': 'Waterfalls'},
  {'icon': Icons.forest, 'text': 'Nature'},
  //{'icon': Icons.access_alarm, 'text': 'Vegan Restaurants'},
  //{'icon': Icons.access_alarm, 'text': 'Spas'},
  //{'icon': Icons.access_alarm, 'text': 'Street markets'},
  //{'icon': Icons.access_alarm, 'text': 'Aquarium'},
  {'icon': Icons.church, 'text': 'Churches'},
  //{'icon': Icons.access_alarm, 'text': 'Beaches'},
  {'icon': Icons.temple_hindu_outlined, 'text': 'Temples'},
  {'icon': Icons.mosque_outlined, 'text': 'Mosques'},
  {'icon': Icons.local_mall_outlined, 'text': 'Malls'},
  //{'icon': Icons.access_alarm, 'text': 'Parks'},
  //{'icon': Icons.access_alarm, 'text': 'Gardens'},
];
