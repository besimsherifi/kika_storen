import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  bool isDark = false;

  ThemeMode currentTheme() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
