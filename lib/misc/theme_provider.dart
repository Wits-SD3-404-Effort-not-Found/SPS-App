import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final box = Hive.box('theme');

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    var savedTheme = box.get('theme_mode');

    if (savedTheme == null) {
      setThemeMode(ThemeMode.system);
    } else {
      setThemeMode(intToTheme(savedTheme));
    }
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    box.put('theme_mode', themeToInt(mode));
    notifyListeners();
  }

  int themeToInt(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 0;
    }
  }

  ThemeMode intToTheme(int themeIdx) {
    switch (themeIdx) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
