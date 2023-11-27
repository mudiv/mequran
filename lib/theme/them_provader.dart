import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  final SharedPreferences sharedPreferences;

  ThemProvider(this.sharedPreferences)
      : _themeData = sharedPreferences.getBool('isDarkMode') == true
            ? darkTheme
            : lightTheme;

  ThemeData get themeData => _themeData;
  void toggleTheme() {
    if (_themeData == lightTheme) {
      _themeData = darkTheme;
      sharedPreferences.setBool('isDarkMode', true);
    } else {
      _themeData = lightTheme;
      sharedPreferences.setBool('isDarkMode', false);
    }
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      primary: Color(0xffEEEEEE),
      secondary: Color(0xff424242),
      outline: Colors.white,
      onPrimary: Color(0xFFD1C5E8),
      background: Color(0xFFEDE7F5),
      onBackground: Color(0xFFB59ED6)),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      primary: Color(0xff424242),
      secondary: Color(0xffEEEEEE),
      outline: Color(0xFF606060),
      onPrimary: Color(0xFF6B627A),
      background: Color.fromARGB(255, 80, 78, 83),
      onBackground: Color.fromARGB(255, 72, 63, 84)),
);
