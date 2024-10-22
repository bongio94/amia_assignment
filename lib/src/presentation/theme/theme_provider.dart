import 'package:amia_assignment/src/presentation/theme/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class AppTheme {
  final ThemeData themeData;
  final ThemeMode themeMode;
  final bool isLight;

  const AppTheme({
    required this.themeData,
    required this.themeMode,
    required this.isLight,
  });

  AppTheme copyWith({ThemeData? themeData, ThemeMode? themeMode, bool? isLight}) {
    return AppTheme(
      themeData: themeData ?? this.themeData,
      themeMode: themeMode ?? this.themeMode,
      isLight: isLight ?? this.isLight,
    );
  }
}

class AppThemeNotifier extends StateNotifier<AppTheme> {
  AppThemeNotifier() : super(_initialTheme);

  static final _initialTheme = AppTheme(
    themeData: AppThemeData.lightTheme,
    themeMode: ThemeMode.light,
    isLight: true,
  );

  static final _lightTheme = AppTheme(
    themeData: AppThemeData.lightTheme,
    themeMode: ThemeMode.light,
    isLight: true,
  );

  static final _darkTheme = AppTheme(
    themeData: AppThemeData.darkTheme,
    themeMode: ThemeMode.dark,
    isLight: false,
  );

  void setTheme(ThemeMode mode) {
    state = mode == ThemeMode.light ? _lightTheme : _darkTheme;
  }
}

final appThemeProvider = StateNotifierProvider<AppThemeNotifier, AppTheme>((ref) {
  return AppThemeNotifier();
});
