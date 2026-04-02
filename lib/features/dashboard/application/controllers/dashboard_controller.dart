import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';

import '../states/dashboard_state.dart';

final dashboardControllerProvider =
    NotifierProvider.autoDispose<DashboardController, DashboardState>(
      DashboardController.new,
    );

class DashboardController extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    final authState = ref.watch(authControllerProvider);
    final userName = authState.maybeWhen(
      authenticated: (user) => _resolveUserName(user.username),
      orElse: () => '사장님',
    );

    return DashboardState(
      userName: userName,
      availableLimitAmount: 3200000,
      limitTypeLabel: 'Type 1',
    );
  }

  String _resolveUserName(String? rawName) {
    final trimmed = rawName?.trim() ?? '';
    if (trimmed.isEmpty) {
      return '사장님';
    }

    return trimmed;
  }
}
