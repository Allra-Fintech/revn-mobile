import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:revn/features/dashboard/presentation/pages/dashboard_page.dart';

import '../../../src/preview/dashboard/dashboard_preview_scope.dart';
import 'scenarios.dart';

@widgetbook.UseCase(name: '기본', type: DashboardPage, path: '[Pages]/Dashboard')
Widget dashboardPageBasicUseCase(BuildContext context) {
  return const DashboardPreviewScope(
    config: dashboardPageBasicConfig,
    child: DashboardPage(),
  );
}

@widgetbook.UseCase(
  name: '세금계산서 만료',
  type: DashboardPage,
  path: '[Pages]/Dashboard',
)
Widget dashboardPageExpiredTaxInvoiceUseCase(BuildContext context) {
  return const DashboardPreviewScope(
    config: dashboardPageExpiredTaxInvoiceConfig,
    child: DashboardPage(),
  );
}

@widgetbook.UseCase(
  name: '한도 없음',
  type: DashboardPage,
  path: '[Pages]/Dashboard',
)
Widget dashboardPageZeroLimitUseCase(BuildContext context) {
  return const DashboardPreviewScope(
    config: dashboardPageZeroLimitConfig,
    child: DashboardPage(),
  );
}

@widgetbook.UseCase(
  name: '미납 있음',
  type: DashboardPage,
  path: '[Pages]/Dashboard',
)
Widget dashboardPageOverdueUseCase(BuildContext context) {
  return const DashboardPreviewScope(
    config: dashboardPageOverdueConfig,
    child: DashboardPage(),
  );
}

@widgetbook.UseCase(
  name: '만료 + 미납',
  type: DashboardPage,
  path: '[Pages]/Dashboard',
)
Widget dashboardPageExpiredAndOverdueUseCase(BuildContext context) {
  return const DashboardPreviewScope(
    config: dashboardPageExpiredAndOverdueConfig,
    child: DashboardPage(),
  );
}
