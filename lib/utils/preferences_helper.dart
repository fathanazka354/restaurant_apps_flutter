import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  static const darkTheme = 'DARK_THEME';

  PreferencesHelper({required this.sharedPreferences});
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  static const restaurant = 'RESTAURANT';

  Future<bool> get isRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(restaurant) ?? false;
  }

  void setRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(restaurant, value);
  }
}
