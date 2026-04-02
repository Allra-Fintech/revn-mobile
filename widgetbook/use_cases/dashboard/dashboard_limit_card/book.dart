import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:revn/features/dashboard/application/states/dashboard_state.dart';
import 'package:revn/features/dashboard/presentation/widgets/dashboard_limit_card.dart';

@widgetbook.UseCase(
  name: '정상',
  type: DashboardLimitCard,
  path: '[Widgets]/Dashboard',
)
Widget dashboardLimitCardAvailableUseCase(BuildContext context) {
  return DashboardLimitCard(
    mode: DashboardCardMode.normal,
    availableLimitAmount: 3200000,
    limitTypeLabel: 'Type 1',
    onAction: () {},
  );
}

@widgetbook.UseCase(
  name: '미납',
  type: DashboardLimitCard,
  path: '[Widgets]/Dashboard',
)
Widget dashboardLimitCardOverdueUseCase(BuildContext context) {
  return DashboardLimitCard(mode: DashboardCardMode.overdue, onAction: () {});
}

@widgetbook.UseCase(
  name: '30일 경과',
  type: DashboardLimitCard,
  path: '[Widgets]/Dashboard',
)
Widget dashboardLimitCardExpiredUseCase(BuildContext context) {
  return DashboardLimitCard(
    mode: DashboardCardMode.expiredTaxInvoice,
    onAction: () {},
  );
}

@widgetbook.UseCase(
  name: '복합 상태(미납 우선)',
  type: DashboardLimitCard,
  path: '[Widgets]/Dashboard',
)
Widget dashboardLimitCardCombinedIssueUseCase(BuildContext context) {
  return DashboardLimitCard(mode: DashboardCardMode.overdue, onAction: () {});
}

@widgetbook.UseCase(
  name: '한도 없음',
  type: DashboardLimitCard,
  path: '[Widgets]/Dashboard',
)
Widget dashboardLimitCardZeroUseCase(BuildContext context) {
  return DashboardLimitCard(
    mode: DashboardCardMode.zeroLimit,
    zeroLimitReason: '최근 세금계산서 발행 이력이 부족해 한도가 산정되지 않았어요.',
  );
}
