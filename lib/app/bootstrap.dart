import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import '../core/config/app_config.dart';
import '../core/logging/app_talker.dart';
import '../core/storage/storage_keys.dart';
import 'app.dart';
import 'providers/app_providers.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appConfig = AppConfig.fromEnvironment();
  final talker = createTalker();
  final sharedPreferences = await SharedPreferences.getInstance();
  final launchCount =
      (sharedPreferences.getInt(StorageKeys.launchCount) ?? 0) + 1;

  await sharedPreferences.setInt(StorageKeys.launchCount, launchCount);
  talker.info(
    'Bootstrap completed. env=${appConfig.environment.value}, '
    'baseUrl=${appConfig.baseUrl}, launch=$launchCount',
  );

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      overrides: [
        appConfigProvider.overrideWithValue(appConfig),
        talkerProvider.overrideWith((ref) => talker),
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
      ],
      child: const RevnApp(),
    ),
  );
}
