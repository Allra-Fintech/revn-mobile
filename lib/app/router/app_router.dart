import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/app/router/debug_routes.dart';
import 'package:revn/app/router/redirects.dart';
import 'package:revn/app/router/router_refresh_notifier.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/dashboard/presentation/routes/dashboard_routes.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../providers/app_providers.dart';

final routerRefreshNotifierProvider = Provider<RouterRefreshNotifier>((ref) {
  final notifier = RouterRefreshNotifier();

  ref.listen<AuthState>(authControllerProvider, (_, _) => notifier.refresh());

  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(routerRefreshNotifierProvider);
  final talker = ref.watch(talkerProvider);
  final router = GoRouter(
    initialLocation: AuthRoute.splash.path,
    refreshListenable: refreshNotifier,
    observers: [TalkerRouteObserver(talker)],
    routes: [
      ...DashboardRoutes.buildDashboardRoutes(),
      ...DebugRoutes.buildDebugRoutes(talker),
      ...AuthRoutes.buildAuthRoutes(),
    ],
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);

      return resolveAppRedirect(
        authState: authState,
        location: state.matchedLocation,
      );
    },
  );

  ref.onDispose(router.dispose);
  return router;
});
