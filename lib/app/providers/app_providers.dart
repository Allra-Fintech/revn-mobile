import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../core/config/app_config.dart';

final talkerProvider = Provider<Talker>((ref) {
  throw UnimplementedError(
    'talkerProvider must be overridden during bootstrap.',
  );
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden during bootstrap.',
  );
});

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError(
    'appConfigProvider must be overridden during bootstrap.',
  );
});
