import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/dashboard/presentation/routes/dashboard_routes.dart';

String? resolveAppRedirect({
  required AuthState authState,
  required String location,
}) {
  final isSplash = location == AuthRoute.splash.path;
  final isAuthPage =
      location == AuthRoute.signIn.path ||
      location == AuthRoute.signUp.path ||
      location == AuthRoute.agreement.path;
  final isDashboardRoute = DashboardRoute.values.any(
    (route) => location == route.path,
  );

  return authState.when(
    initial: () => isSplash ? null : AuthRoute.splash.path,
    loading: () => isSplash ? null : AuthRoute.splash.path,
    restoreFailed: (_) => isSplash ? null : AuthRoute.splash.path,
    authenticated: (_) {
      if (isAuthPage || isSplash) {
        return DashboardRoute.dashboard.path;
      }

      return null;
    },
    unauthenticated: (_) {
      if (isDashboardRoute || isSplash) {
        return AuthRoute.signIn.path;
      }

      return null;
    },
  );
}
