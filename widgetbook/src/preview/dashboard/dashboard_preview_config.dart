import 'package:revn/features/dashboard/application/states/dashboard_state.dart';

const dashboardPreviewState = DashboardState(
  userName: '레븐',
  availableLimitAmount: 3200000,
  limitTypeLabel: 'Type 1',
);

class DashboardPreviewConfig {
  const DashboardPreviewConfig({this.dashboardState = dashboardPreviewState});

  final DashboardState dashboardState;
}
