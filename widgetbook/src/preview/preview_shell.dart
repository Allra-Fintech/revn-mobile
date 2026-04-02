import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:revn/app/providers/app_providers.dart';
import 'package:revn/core/config/app_config.dart';
import 'package:revn/features/auth/presentation/models/agreement_document.dart';
import 'package:revn/features/auth/presentation/pages/agreement_webview_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_up_page.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';

import 'auth/auth_preview_config.dart';
import 'auth/auth_preview_scope.dart';

class WidgetbookPreviewShell extends StatefulWidget {
  const WidgetbookPreviewShell({
    super.key,
    required this.sharedPreferences,
    required this.talker,
    required this.appConfig,
    required this.theme,
    required this.child,
  });

  final SharedPreferences sharedPreferences;
  final Talker talker;
  final AppConfig appConfig;
  final ThemeData theme;
  final Widget child;

  @override
  State<WidgetbookPreviewShell> createState() => _WidgetbookPreviewShellState();
}

class _WidgetbookPreviewShellState extends State<WidgetbookPreviewShell> {
  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    observers: [TalkerRouteObserver(widget.talker)],
    routes: [
      GoRoute(path: '/', builder: (context, state) => widget.child),
      GoRoute(
        name: AuthRoute.signIn.name,
        path: AuthRoute.signIn.path,
        builder: (context, state) => const AuthPreviewScope(
          config: AuthPreviewConfig(),
          child: SignInPage(),
        ),
      ),
      GoRoute(
        name: AuthRoute.signUp.name,
        path: AuthRoute.signUp.path,
        builder: (context, state) => const AuthPreviewScope(
          config: AuthPreviewConfig(),
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        name: AuthRoute.agreement.name,
        path: AuthRoute.agreement.path,
        builder: (context, state) {
          final document = state.extra is AgreementDocument
              ? state.extra! as AgreementDocument
              : AgreementDocument.serviceTerms;

          return AgreementWebViewPage(document: document);
        },
      ),
    ],
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [TalkerRiverpodObserver(talker: widget.talker)],
      overrides: [
        appConfigProvider.overrideWithValue(widget.appConfig),
        talkerProvider.overrideWith((ref) => widget.talker),
        sharedPreferencesProvider.overrideWith(
          (ref) => widget.sharedPreferences,
        ),
      ],
      child: MaterialApp.router(
        title: 'Revn Widgetbook',
        debugShowCheckedModeBanner: false,
        theme: widget.theme,
        routerConfig: _router,
      ),
    );
  }
}
