import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum DebugRoute {
  logs('/logs');

  const DebugRoute(this.path);

  final String path;
}

abstract final class DebugRoutes {
  static List<RouteBase> buildDebugRoutes(
    Talker talker, {
    bool enabled = kDebugMode,
  }) {
    if (!enabled) {
      return const [];
    }

    return [
      GoRoute(
        name: DebugRoute.logs.name,
        path: DebugRoute.logs.path,
        builder: (context, state) =>
            TalkerScreen(talker: talker, appBarTitle: 'Revn Logs'),
      ),
    ];
  }
}
