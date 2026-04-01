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
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/home/presentation/pages/home_page.dart';
import 'package:revn/features/home/presentation/routes/home_routes.dart';

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

  Uri uriOf(WidgetTester tester) {
    return routerOf(tester).routeInformationProvider.value.uri;
  }

  String locationOf(WidgetTester tester) {
    return uriOf(tester).path;
  }

  String? businessNumberFieldValue(WidgetTester tester) {
    return tester
        .widget<TextFormField>(find.byType(TextFormField).first)
        .controller
        ?.text;
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

    expect(locationOf(tester), AuthRoute.splash.path);
    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets('loading state routes to splash', (tester) async {
    await pumpRouterApp(tester, TestAuthController(const AuthState.loading()));

    expect(locationOf(tester), AuthRoute.splash.path);
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

    routerOf(tester).go(AuthRoute.signIn.path);
    await tester.pump();
    await tester.pump();

    expect(locationOf(tester), HomeRoute.home.path);
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

    routerOf(tester).go(HomeRoute.home.path);
    await tester.pump();
    await tester.pump();

    expect(locationOf(tester), AuthRoute.signIn.path);
    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets(
    'unauthenticated state keeps sign-in query parameter and prefills business number',
    (tester) async {
      await pumpRouterApp(
        tester,
        TestAuthController(const AuthState.unauthenticated()),
      );

      routerOf(tester).go(
        '${AuthRoute.signIn.path}?${AuthRoutes.signInBusinessNumberQueryParameter}=1234567890',
      );
      await tester.pump();
      await tester.pump();

      expect(locationOf(tester), AuthRoute.signIn.path);
      expect(
        uriOf(
          tester,
        ).queryParameters[AuthRoutes.signInBusinessNumberQueryParameter],
        '1234567890',
      );
      expect(find.byType(SignInPage), findsOneWidget);
      expect(businessNumberFieldValue(tester), '123-45-67890');
    },
  );

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
