import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/app/providers/app_providers.dart';
import 'package:revn/app/router/app_router.dart';
import 'package:revn/core/logging/app_talker.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/splash_page.dart';
import 'package:revn/features/home/presentation/pages/home_page.dart';

import '../../features/auth/helpers/test_auth_controller.dart';

class _RouterTestApp extends ConsumerWidget {
  const _RouterTestApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(routerConfig: router);
  }
}

void main() {
  const user = CurrentUser(
    id: '1',
    businessNumber: '1234567890',
    username: 'Mock Owner',
  );

  ProviderContainer containerOf(WidgetTester tester) {
    return ProviderScope.containerOf(
      tester.element(find.byType(_RouterTestApp)),
    );
  }

  GoRouter routerOf(WidgetTester tester) {
    return containerOf(tester).read(appRouterProvider);
  }

  Future<void> pumpRouterApp(
    WidgetTester tester,
    TestAuthController authController,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(() => authController),
          talkerProvider.overrideWith((ref) => createTalker()),
        ],
        child: const _RouterTestApp(),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets('initial state routes to splash', (tester) async {
    await pumpRouterApp(tester, TestAuthController(const AuthState.initial()));

    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets('loading state routes to splash', (tester) async {
    await pumpRouterApp(tester, TestAuthController(const AuthState.loading()));

    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets('authenticated state redirects splash to home', (tester) async {
    await pumpRouterApp(
      tester,
      TestAuthController(const AuthState.authenticated(user)),
    );

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('authenticated state redirects sign-in to home', (tester) async {
    await pumpRouterApp(
      tester,
      TestAuthController(const AuthState.authenticated(user)),
    );

    routerOf(tester).go(AppRoute.signIn.path);
    await tester.pump();
    await tester.pump();

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('unauthenticated state redirects splash and home to sign-in', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      TestAuthController(const AuthState.unauthenticated()),
    );

    expect(find.byType(SignInPage), findsOneWidget);

    routerOf(tester).go(AppRoute.home.path);
    await tester.pump();
    await tester.pump();

    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('router refreshes when auth state changes', (tester) async {
    final authController = TestAuthController(const AuthState.initial());

    await pumpRouterApp(tester, authController);

    expect(find.byType(SplashPage), findsOneWidget);

    authController.setStateForTest(const AuthState.unauthenticated());
    await tester.pump();
    await tester.pump();

    expect(find.byType(SignInPage), findsOneWidget);

    authController.setStateForTest(const AuthState.authenticated(user));
    await tester.pump();
    await tester.pump();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
