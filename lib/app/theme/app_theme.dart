import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_component_themes.dart';

abstract final class RevnTheme {
  static final ThemeData light = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    final colorScheme = AppColors.lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      appBarTheme: AppComponentThemes.appBarTheme(colorScheme),
      cardTheme: AppComponentThemes.cardTheme(colorScheme),
    );
  }
}
