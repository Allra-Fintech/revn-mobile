import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_component_themes.dart';

abstract final class RevnTheme {
  static const String _fontFamily = 'Pretendard';
  static final ThemeData light = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    final colorScheme = AppColors.lightColorScheme;
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      fontFamily: _fontFamily,
    );
    final textTheme = baseTheme.textTheme.apply(fontFamily: _fontFamily);
    final primaryTextTheme = baseTheme.primaryTextTheme.apply(
      fontFamily: _fontFamily,
    );

    return baseTheme.copyWith(
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      appBarTheme: AppComponentThemes.appBarTheme(colorScheme),
      cardTheme: AppComponentThemes.cardTheme(colorScheme),
      inputDecorationTheme: AppComponentThemes.inputDecorationTheme(
        colorScheme,
        textTheme,
      ),
      filledButtonTheme: AppComponentThemes.filledButtonTheme(
        colorScheme,
        textTheme,
      ),
      outlinedButtonTheme: AppComponentThemes.outlinedButtonTheme(
        colorScheme,
        textTheme,
      ),
      textButtonTheme: AppComponentThemes.textButtonTheme(
        colorScheme,
        textTheme,
      ),
    );
  }
}
