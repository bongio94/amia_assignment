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
  AppThemeNotifier()
      : super(
          AppTheme(
            themeData: AppThemeData.lightTheme,
            themeMode: ThemeMode.light,
            isLight: true,
          ),
        );

  void setTheme(ThemeMode mode) {
    state = state.copyWith(
      themeMode: mode,
      themeData: mode == ThemeMode.light ? AppThemeData.lightTheme : AppThemeData.darkTheme,
      isLight: mode == ThemeMode.light,
    );
  }
}

final appThemeProvider = StateNotifierProvider<AppThemeNotifier, AppTheme>((ref) {
  return AppThemeNotifier();
});
