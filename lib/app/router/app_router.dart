import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/app/router/router_refresh_notifier.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/splash_page.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../providers/app_providers.dart';

enum AppRoute {
  home('/'),
  logs('/logs'),
  signIn('/sign-in'),
  splash('/splash');

  const AppRoute(this.path);

  final String path;
}

final routerRefreshNotifierProvider = Provider<RouterRefreshNotifier>((ref) {
  final notifier = RouterRefreshNotifier();

  ref.listen<AuthState>(authControllerProvider, (_, _) => notifier.refresh());

  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(routerRefreshNotifierProvider);
  final talker = ref.watch(talkerProvider);
  final router = GoRouter(
    initialLocation: AppRoute.splash.path,
    refreshListenable: refreshNotifier,
    observers: [TalkerRouteObserver(talker)],
    routes: [
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: AppRoute.logs.name,
        path: AppRoute.logs.path,
        builder: (context, state) =>
            TalkerScreen(talker: talker, appBarTitle: 'Revn Logs'),
      ),
      GoRoute(
        name: AppRoute.signIn.name,
        path: AppRoute.signIn.path,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: AppRoute.splash.name,
        path: AppRoute.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final location = state.matchedLocation;

      final isSplash = location == AppRoute.splash.path;
      final isSignIn = location == AppRoute.signIn.path;
      final isHome = location == AppRoute.home.path;

      return authState.when(
        initial: () => isSplash ? null : AppRoute.splash.path,
        loading: () => isSplash ? null : AppRoute.splash.path,
        authenticated: (_) {
          if (isSignIn || isSplash) {
            return AppRoute.home.path;
          }
          return null;
        },
        unauthenticated: () {
          if (isHome || isSplash) {
            return AppRoute.signIn.path;
          }
          return null;
        },
      );
    },
  );

  ref.onDispose(router.dispose);
  return router;
});
