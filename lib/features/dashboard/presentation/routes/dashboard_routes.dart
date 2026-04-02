import 'package:go_router/go_router.dart';

import '../pages/dashboard_action_placeholder_page.dart';
import '../pages/dashboard_page.dart';

enum DashboardRoute {
  dashboard('/'),
  reAuth('/re-auth'),
  advanceRequest('/advance-request'),
  payment('/payment');

  const DashboardRoute(this.path);

  final String path;
}

abstract final class DashboardRoutes {
  static List<RouteBase> buildDashboardRoutes() {
    return [
      GoRoute(
        name: DashboardRoute.dashboard.name,
        path: DashboardRoute.dashboard.path,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        name: DashboardRoute.reAuth.name,
        path: DashboardRoute.reAuth.path,
        builder: (context, state) => const DashboardActionPlaceholderPage(
          title: '간편인증 재진행',
          description: '임시 목적지입니다. 이후 인증 플로우 화면으로 교체됩니다.',
        ),
      ),
      GoRoute(
        name: DashboardRoute.advanceRequest.name,
        path: DashboardRoute.advanceRequest.path,
        builder: (context, state) => const DashboardActionPlaceholderPage(
          title: '선지급 신청',
          description: '임시 목적지입니다. 이후 신청 플로우 화면으로 교체됩니다.',
        ),
      ),
      GoRoute(
        name: DashboardRoute.payment.name,
        path: DashboardRoute.payment.path,
        builder: (context, state) => const DashboardActionPlaceholderPage(
          title: '납부하기',
          description: '임시 목적지입니다. 이후 납부 플로우 화면으로 교체됩니다.',
        ),
      ),
    ];
  }
}
