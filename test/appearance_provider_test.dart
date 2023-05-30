import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sps_app/misc/theme_provider.dart';

void main() {
  test("Test theme conversion Int to Mode", () {
    expect(ThemeNotifier.themeToInt(ThemeMode.system), 0);
    expect(ThemeNotifier.themeToInt(ThemeMode.light), 1);
    expect(ThemeNotifier.themeToInt(ThemeMode.dark), 2);
  });

  test("Test theme conversion Mode to Int", () {
    expect(ThemeNotifier.intToTheme(0), ThemeMode.system);
    expect(ThemeNotifier.intToTheme(1), ThemeMode.light);
    expect(ThemeNotifier.intToTheme(2), ThemeMode.dark);
  });
}
