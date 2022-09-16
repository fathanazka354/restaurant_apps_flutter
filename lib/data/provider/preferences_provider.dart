import 'package:flutter/material.dart';
import 'package:restoran_app/component/style.dart';
import 'package:restoran_app/utils/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getRestaurantPreferences();
  }
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isRestaurantActive = false;
  bool get isRestaurantActive => _isRestaurantActive;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getRestaurantPreferences() async {
    _isRestaurantActive = await preferencesHelper.isRestaurantActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableRestaurant(bool value) {
    preferencesHelper.setRestaurant(value);
    _getRestaurantPreferences();
  }
}
