import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/home/presentation/pages/home_page.dart';

import '../../../auth/helpers/test_auth_controller.dart';

void main() {
  Widget buildTestApp(TestAuthController authController) {
    return ProviderScope(
      overrides: [authControllerProvider.overrideWith(() => authController)],
      child: const MaterialApp(home: HomePage()),
    );
  }

  testWidgets('로그아웃 버튼 탭이 signOut 호출로 이어진다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'Mock Owner',
    );
    final authController = TestAuthController(
      const AuthState.authenticated(user),
    );

    await tester.pumpWidget(buildTestApp(authController));
    await tester.tap(find.text('로그아웃'));
    await tester.pumpAndSettle();

    expect(authController.signOutCallCount, 1);
    expect(authController.state, const AuthState.unauthenticated());
  });
}
