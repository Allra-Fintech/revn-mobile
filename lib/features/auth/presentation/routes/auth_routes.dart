import 'package:go_router/go_router.dart';
import 'package:revn/features/auth/presentation/models/agreement_document.dart';
import 'package:revn/features/auth/presentation/pages/agreement_webview_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_up_page.dart';
import 'package:revn/features/auth/presentation/pages/splash_page.dart';

enum AuthRoute {
  agreement('/sign-up/agreement'),
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
        name: AuthRoute.agreement.name,
        path: AuthRoute.agreement.path,
        builder: (context, state) {
          final document = state.extra;
          if (document is! AgreementDocument) {
            throw ArgumentError.value(
              document,
              'state.extra',
              'Agreement route requires an AgreementDocument extra.',
            );
          }

          return AgreementWebViewPage(document: document);
        },
      ),
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
