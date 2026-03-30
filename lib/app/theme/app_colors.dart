import 'package:flutter/material.dart';

abstract final class AppColors {
  static const seed = Color(0xFF1344CE);
  static const scaffoldBackground = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFFFFFFF);

  static ColorScheme get lightColorScheme =>
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
}
