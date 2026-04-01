import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/home/presentation/routes/home_routes.dart';

String? resolveAppRedirect({
  required AuthState authState,
  required String location,
}) {
  final isSplash = location == AuthRoute.splash.path;
  final isAuthPage =
      location == AuthRoute.signIn.path ||
      location == AuthRoute.signUp.path ||
      location == AuthRoute.agreement.path;
  final isHome = location == HomeRoute.home.path;

  return authState.when(
    initial: () => isSplash ? null : AuthRoute.splash.path,
    loading: () => isSplash ? null : AuthRoute.splash.path,
    authenticated: (_) {
      if (isAuthPage || isSplash) {
        return HomeRoute.home.path;
      }

      return null;
    },
    unauthenticated: () {
      if (isHome || isSplash) {
        return AuthRoute.signIn.path;
      }

      return null;
    },
  );
}
