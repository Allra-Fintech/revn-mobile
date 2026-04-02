import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/app/router/debug_routes.dart';
import 'package:revn/core/logging/app_talker.dart';

void main() {
  test('debug routes are omitted when disabled', () {
    final routes = DebugRoutes.buildDebugRoutes(createTalker(), enabled: false);

    expect(routes, isEmpty);
  });

  test('debug routes include logs route when enabled', () {
    final routes = DebugRoutes.buildDebugRoutes(createTalker(), enabled: true);

    expect(routes, hasLength(1));

    final route = routes.single as GoRoute;
    expect(route.name, DebugRoute.logs.name);
    expect(route.path, DebugRoute.logs.path);
  });
}
