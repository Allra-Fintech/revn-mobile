import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'package:revn/app/app.dart';
import 'package:revn/app/providers/app_providers.dart';
import 'package:revn/core/config/app_config.dart';
import 'package:revn/core/logging/app_talker.dart';
import 'package:revn/core/storage/storage_keys.dart';

void main() {
  testWidgets('home screen renders centered home text', (tester) async {
    SharedPreferences.setMockInitialValues({StorageKeys.launchCount: 3});

    final sharedPreferences = await SharedPreferences.getInstance();
    final talker = createTalker();

    await tester.pumpWidget(
      ProviderScope(
        observers: [TalkerRiverpodObserver(talker: talker)],
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              environment: AppEnvironment.dev,
              baseUrl: 'https://example.test',
            ),
          ),
          talkerProvider.overrideWith((ref) => talker),
          sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
        ],
        child: const RevnApp(),
      ),
    );

    await tester.pumpAndSettle();

    await tester.pumpAndSettle();

    expect(find.byType(Center), findsOneWidget);
    expect(find.text('home'), findsOneWidget);
  });
}
