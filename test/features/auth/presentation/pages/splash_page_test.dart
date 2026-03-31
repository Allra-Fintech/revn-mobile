import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/presentation/pages/splash_page.dart';

import '../../helpers/test_auth_controller.dart';

void main() {
  Widget buildTestApp(TestAuthController authController) {
    return ProviderScope(
      overrides: [authControllerProvider.overrideWith(() => authController)],
      child: const MaterialApp(home: SplashPage()),
    );
  }

  testWidgets('첫 렌더에서 restoreSession을 한 번만 요청한다', (tester) async {
    final authController = TestAuthController(const AuthState.initial());

    await tester.pumpWidget(buildTestApp(authController));

    expect(authController.restoreSessionCallCount, 1);

    await tester.pumpWidget(buildTestApp(authController));
    await tester.pump();

    expect(authController.restoreSessionCallCount, 1);
  });
}
