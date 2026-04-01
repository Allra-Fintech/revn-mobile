import 'package:go_router/go_router.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_up_page.dart';
import 'package:revn/features/auth/presentation/pages/splash_page.dart';

enum AuthRoute {
  signIn('/sign-in'),
  signUp('/sign-up'),
  splash('/splash');

  const AuthRoute(this.path);

  final String path;
}

abstract final class AuthRoutes {
  static const signInBusinessNumberQueryParameter = 'businessNumber';

  static List<RouteBase> buildAuthRoutes() {
    return [
      GoRoute(
        name: AuthRoute.signIn.name,
        path: AuthRoute.signIn.path,
        builder: (context, state) => SignInPage(
          initialBusinessNumber:
              state.uri.queryParameters[signInBusinessNumberQueryParameter],
        ),
      ),
      GoRoute(
        name: AuthRoute.splash.name,
        path: AuthRoute.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: AuthRoute.signUp.name,
        path: AuthRoute.signUp.path,
        builder: (context, state) => const SignUpPage(),
      ),
    ];
  }
}
