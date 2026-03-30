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

      expect(cardTheme.color, AppColors.cardBackground);
      expect(cardTheme.elevation, 0);
      expect(
        shape.borderRadius,
        BorderRadius.circular(AppComponentThemes.cardBorderRadius),
      );
      expect(shape.side.color, colorScheme.outlineVariant);
    });
  });
}
