import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/app/theme/app_colors.dart';
import 'package:revn/app/theme/app_component_themes.dart';
import 'package:revn/app/theme/app_theme.dart';

void main() {
  group('RevnTheme.light', () {
    test('builds the expected light theme', () {
      final theme = RevnTheme.light;
      final colorScheme = AppColors.lightColorScheme;

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme, colorScheme);
      expect(theme.scaffoldBackgroundColor, AppColors.scaffoldBackground);
      expect(theme.appBarTheme.backgroundColor, colorScheme.surface);
      expect(theme.appBarTheme.foregroundColor, colorScheme.onSurface);
      expect(theme.appBarTheme.centerTitle, isFalse);

      final cardTheme = theme.cardTheme;
      final shape = cardTheme.shape as RoundedRectangleBorder;
      final inputTheme = theme.inputDecorationTheme;
      final enabledBorder = inputTheme.enabledBorder as OutlineInputBorder;
      final focusedBorder = inputTheme.focusedBorder as OutlineInputBorder;
      final errorBorder = inputTheme.errorBorder as OutlineInputBorder;

      expect(cardTheme.color, AppColors.cardBackground);
      expect(cardTheme.elevation, 0);
      expect(
        shape.borderRadius,
        BorderRadius.circular(AppComponentThemes.cardBorderRadius),
      );
      expect(shape.side.color, colorScheme.outlineVariant);

      expect(inputTheme.filled, isFalse);
      expect(inputTheme.constraints, AppComponentThemes.inputConstraints);
      expect(inputTheme.contentPadding, AppComponentThemes.inputContentPadding);
      expect(
        enabledBorder.borderRadius,
        BorderRadius.circular(AppComponentThemes.inputBorderRadius),
      );
      expect(enabledBorder.borderSide.color, colorScheme.outlineVariant);
      expect(enabledBorder.borderSide.width, 1);
      expect(focusedBorder.borderSide.color, colorScheme.primary);
      expect(focusedBorder.borderSide.width, 1.5);
      expect(errorBorder.borderSide.color, colorScheme.error);
      expect(errorBorder.borderSide.width, 1.5);
      expect(
        inputTheme.suffixIconConstraints,
        AppComponentThemes.inputIconConstraints,
      );
    });
  });
}
