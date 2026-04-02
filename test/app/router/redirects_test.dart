import 'package:flutter_test/flutter_test.dart';
import 'package:revn/app/router/debug_routes.dart';
import 'package:revn/app/router/redirects.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/home/presentation/routes/home_routes.dart';

void main() {
  const user = CurrentUser(
    id: '1',
    businessNumber: '1234567890',
    username: 'Mock Owner',
  );

  group('resolveAppRedirect', () {
    test('routes initial, loading, and restoreFailed states to splash', () {
      expect(
        resolveAppRedirect(
          authState: const AuthState.initial(),
          location: HomeRoute.home.path,
        ),
        AuthRoute.splash.path,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.loading(),
          location: HomeRoute.home.path,
        ),
        AuthRoute.splash.path,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.restoreFailed(
            AuthFailure.common(CommonFailure.network()),
          ),
          location: HomeRoute.home.path,
        ),
        AuthRoute.splash.path,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.initial(),
          location: AuthRoute.splash.path,
        ),
        isNull,
      );
    });

    test('redirects authenticated users away from splash and auth pages', () {
      const authState = AuthState.authenticated(user);

      expect(
        resolveAppRedirect(
          authState: authState,
          location: AuthRoute.splash.path,
        ),
        HomeRoute.home.path,
      );
      expect(
        resolveAppRedirect(
          authState: authState,
          location: AuthRoute.signIn.path,
        ),
        HomeRoute.home.path,
      );
      expect(
        resolveAppRedirect(
          authState: authState,
          location: AuthRoute.signUp.path,
        ),
        HomeRoute.home.path,
      );
    });

    test('redirects unauthenticated users from splash and home to sign-in', () {
      const authState = AuthState.unauthenticated();
      const authStateWithNotice = AuthState.unauthenticated(
        notice: AuthFailure.common(CommonFailure.storage()),
      );

      expect(
        resolveAppRedirect(
          authState: authState,
          location: AuthRoute.splash.path,
        ),
        AuthRoute.signIn.path,
      );
      expect(
        resolveAppRedirect(authState: authState, location: HomeRoute.home.path),
        AuthRoute.signIn.path,
      );
      expect(
        resolveAppRedirect(
          authState: authStateWithNotice,
          location: HomeRoute.home.path,
        ),
        AuthRoute.signIn.path,
      );
    });

    test('returns null for routes outside the guarded locations', () {
      expect(
        resolveAppRedirect(
          authState: const AuthState.unauthenticated(),
          location: DebugRoute.logs.path,
        ),
        isNull,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.authenticated(user),
          location: DebugRoute.logs.path,
        ),
        isNull,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.authenticated(user),
          location: HomeRoute.home.path,
        ),
        isNull,
      );
    });
  });
}
