import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:revn/features/dashboard/application/controllers/dashboard_controller.dart';

import 'dashboard_preview_config.dart';
import 'dashboard_preview_controllers.dart';

class DashboardPreviewScope extends StatelessWidget {
  const DashboardPreviewScope({
    super.key,
    required this.config,
    required this.child,
  });

  final DashboardPreviewConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        dashboardControllerProvider.overrideWith(
          () => PreviewDashboardController(initialState: config.dashboardState),
        ),
      ],
      child: child,
    );
  }
}
