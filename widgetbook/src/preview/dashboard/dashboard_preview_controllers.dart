import 'package:revn/features/dashboard/application/controllers/dashboard_controller.dart';
import 'package:revn/features/dashboard/application/states/dashboard_state.dart';

class PreviewDashboardController extends DashboardController {
  PreviewDashboardController({required this.initialState});

  final DashboardState initialState;

  @override
  DashboardState build() => initialState;
}
