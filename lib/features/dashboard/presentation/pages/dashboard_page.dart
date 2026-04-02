import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/controllers/dashboard_controller.dart';
import '../../application/states/dashboard_state.dart';
import '../routes/dashboard_routes.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_limit_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);
    final onCardAction = _resolveCardAction(context, state);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            children: [
              DashboardHeader(
                userName: state.userName,
                onNotificationTap: () {},
              ),
              const SizedBox(height: 24),
              DashboardLimitCard(
                mode: state.cardMode,
                availableLimitAmount: state.availableLimitAmount,
                limitTypeLabel: state.limitTypeLabel,
                zeroLimitReason: state.resolvedZeroLimitReason,
                onAction: onCardAction,
              ),
            ],
          ),
        ),
      ),
    );
  }

  VoidCallback? _resolveCardAction(BuildContext context, DashboardState state) {
    return switch (state.cardMode) {
      DashboardCardMode.normal => () => _navigateTo(
        context,
        DashboardRoute.advanceRequest,
      ),
      DashboardCardMode.overdue => () => _navigateTo(
        context,
        DashboardRoute.payment,
      ),
      DashboardCardMode.expiredTaxInvoice => () => _navigateTo(
        context,
        DashboardRoute.reAuth,
      ),
      DashboardCardMode.zeroLimit => null,
    };
  }

  void _navigateTo(BuildContext context, DashboardRoute route) {
    context.push(route.path);
  }
}
