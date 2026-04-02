import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:revn/core/config/app_config.dart';
import 'package:revn/core/logging/app_talker.dart';

import 'widgetbook.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues(const {});

  final sharedPreferences = await SharedPreferences.getInstance();
  final talker = createTalker();

  runApp(
    WidgetbookApp(
      sharedPreferences: sharedPreferences,
      talker: talker,
      appConfig: const AppConfig(
        environment: AppEnvironment.dev,
        baseUrl: '',
        apiMode: AppApiMode.mock,
      ),
    ),
  );
}
