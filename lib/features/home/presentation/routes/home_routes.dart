import 'package:go_router/go_router.dart';
import 'package:revn/features/home/presentation/pages/home_page.dart';

enum HomeRoute {
  home('/');

  const HomeRoute(this.path);

  final String path;
}

abstract final class HomeRoutes {
  static List<RouteBase> buildHomeRoutes() {
    return [
      GoRoute(
        name: HomeRoute.home.name,
        path: HomeRoute.home.path,
        builder: (context, state) => const HomePage(),
      ),
    ];
  }
}
