import 'package:flutter/material.dart';

class AppThemeData {
  static const primary = Color(0xFF334053);

  static final lightScheme = ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light);
  static final darkScheme = ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark);

  static ThemeData lightTheme = ThemeData(
    colorScheme: lightScheme,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: lightScheme.primary,
      centerTitle: false,
    ),

  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: darkScheme,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: darkScheme.primary,
      centerTitle: false,
    ),
  );
}
