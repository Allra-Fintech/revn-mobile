import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppComponentThemes {
  static const double cardBorderRadius = 24;

  static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    centerTitle: false,
  );

  static CardThemeData cardTheme(ColorScheme colorScheme) => CardThemeData(
    color: AppColors.cardBackground,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardBorderRadius),
      side: BorderSide(color: colorScheme.outlineVariant),
    ),
  );
}
