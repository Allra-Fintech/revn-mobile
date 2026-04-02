import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
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

  testWidgets('복구 실패 시 오류 문구와 재시도 버튼을 보여준다', (tester) async {
    final authController = TestAuthController(
      const AuthState.restoreFailed(
        AuthFailure.common(CommonFailure.network()),
      ),
    );

    await tester.pumpWidget(buildTestApp(authController));
    await tester.pump();

    expect(find.text('세션을 복구하지 못했습니다.'), findsOneWidget);
    expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '다시 시도'), findsOneWidget);
  });

  testWidgets('재시도 버튼 탭 시 restoreSession을 다시 호출한다', (tester) async {
    final authController = TestAuthController(
      const AuthState.restoreFailed(
        AuthFailure.common(CommonFailure.network()),
      ),
    );

    await tester.pumpWidget(buildTestApp(authController));
    await tester.pump();

    expect(authController.restoreSessionCallCount, 1);

    await tester.tap(find.widgetWithText(FilledButton, '다시 시도'));
    await tester.pump();

    expect(authController.restoreSessionCallCount, 2);
  });
}
