import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:revn/app/theme/app_theme.dart';
import 'package:revn/core/config/app_config.dart';

import 'src/preview/preview_shell.dart';
import 'widgetbook.directories.g.dart';

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({
    super.key,
    required this.sharedPreferences,
    required this.talker,
    required this.appConfig,
  });

  final SharedPreferences sharedPreferences;
  final Talker talker;
  final AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [WidgetbookTheme(name: 'Light', data: RevnTheme.light)],
        ),
        ViewportAddon([
          IosViewports.iPhoneSE,
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
        ]),
        TextScaleAddon(min: 0.9, max: 1.6, divisions: 7, initialScale: 1.0),
      ],
      appBuilder: (context, child) {
        return WidgetbookPreviewShell(
          sharedPreferences: sharedPreferences,
          talker: talker,
          appConfig: appConfig,
          theme: Theme.of(context),
          child: child,
        );
      },
    );
  }
}
