import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../providers/app_providers.dart';

enum AppRoute {
  home('/'),
  logs('/logs');

  const AppRoute(this.path);

  final String path;
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final talker = ref.watch(talkerProvider);
  final router = GoRouter(
    initialLocation: AppRoute.home.path,
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
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
