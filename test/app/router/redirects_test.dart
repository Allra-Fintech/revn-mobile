import 'package:flutter_test/flutter_test.dart';
import 'package:revn/app/router/debug_routes.dart';
import 'package:revn/app/router/redirects.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/dashboard/presentation/routes/dashboard_routes.dart';

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
          location: DashboardRoute.dashboard.path,
        ),
        AuthRoute.splash.path,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.loading(),
          location: DashboardRoute.dashboard.path,
        ),
        AuthRoute.splash.path,
      );
      expect(
        resolveAppRedirect(
          authState: const AuthState.restoreFailed(
            AuthFailure.common(CommonFailure.network()),
          ),
          location: DashboardRoute.dashboard.path,
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
        DashboardRoute.dashboard.path,
      );
      expect(
        resolveAppRedirect(
          authState: authState,
          location: AuthRoute.signIn.path,
        ),
        DashboardRoute.dashboard.path,
      );
      expect(
        resolveAppRedirect(
          authState: authState,
          location: AuthRoute.signUp.path,
        ),
        DashboardRoute.dashboard.path,
      );
    });

    test(
      'redirects unauthenticated users from splash and dashboard to sign-in',
      () {
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
          resolveAppRedirect(
            authState: authState,
            location: DashboardRoute.dashboard.path,
          ),
          AuthRoute.signIn.path,
        );
        expect(
          resolveAppRedirect(
            authState: authStateWithNotice,
            location: DashboardRoute.dashboard.path,
          ),
          AuthRoute.signIn.path,
        );
        expect(
          resolveAppRedirect(
            authState: authState,
            location: DashboardRoute.payment.path,
          ),
          AuthRoute.signIn.path,
        );
      },
    );

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
          location: DashboardRoute.dashboard.path,
        ),
        isNull,
      );
    });
  });
}
