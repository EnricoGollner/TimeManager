
import 'package:flutter/material.dart';
import 'package:working_time_manager/core/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  
  void toggleTheme() {
    themeData = _themeData == lightMode ? darkMode : lightMode;  // using setter of theme data that notifies listenners
  }
}