import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppComponentThemes {
  static const double cardBorderRadius = 24;
  static const double inputBorderRadius = 16;
  static const double buttonBorderRadius = 16;
  static const double inputMinHeight = 56;
  static const double buttonMinHeight = 56;
  static const double inputIconMinSize = 48;
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );
  static const EdgeInsets buttonContentPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 16,
  );
  static const BoxConstraints inputConstraints = BoxConstraints(
    minHeight: inputMinHeight,
  );
  static const BoxConstraints buttonConstraints = BoxConstraints(
    minHeight: buttonMinHeight,
  );
  static const BoxConstraints inputIconConstraints = BoxConstraints(
    minWidth: inputIconMinSize,
    minHeight: inputIconMinSize,
  );

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

  static InputDecorationThemeData inputDecorationTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) => InputDecorationThemeData(
    filled: false,
    constraints: inputConstraints,
    contentPadding: inputContentPadding,
    labelStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),
    floatingLabelStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.primary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),
    hintStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
      letterSpacing: 0.1,
    ),
    helperStyle: textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
      height: 1.4,
    ),
    errorStyle: textTheme.bodySmall?.copyWith(
      color: colorScheme.error,
      height: 1.4,
    ),
    prefixIconColor: colorScheme.onSurfaceVariant,
    suffixIconColor: colorScheme.onSurfaceVariant,
    prefixIconConstraints: inputIconConstraints,
    suffixIconConstraints: inputIconConstraints,
    border: _inputBorder(colorScheme.outlineVariant),
    enabledBorder: _inputBorder(colorScheme.outlineVariant),
    disabledBorder: _inputBorder(
      colorScheme.outlineVariant.withValues(alpha: 0.65),
    ),
    focusedBorder: _inputBorder(colorScheme.primary, width: 1.5),
    errorBorder: _inputBorder(colorScheme.error, width: 1.5),
    focusedErrorBorder: _inputBorder(colorScheme.error, width: 2),
  );

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        borderSide: BorderSide(color: color, width: width),
      );

  static FilledButtonThemeData filledButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(buttonMinHeight),
      padding: buttonContentPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(buttonMinHeight),
      padding: buttonContentPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      side: BorderSide(color: colorScheme.outline),
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  static TextButtonThemeData textButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) => TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size.fromHeight(buttonMinHeight),
      padding: buttonContentPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );
}
