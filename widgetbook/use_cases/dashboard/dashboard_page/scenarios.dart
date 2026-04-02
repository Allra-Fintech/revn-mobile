import 'package:revn/features/dashboard/application/states/dashboard_state.dart';

import '../../../src/preview/dashboard/dashboard_preview_config.dart';

const dashboardPageBasicConfig = DashboardPreviewConfig();

const dashboardPageExpiredTaxInvoiceConfig = DashboardPreviewConfig(
  dashboardState: DashboardState(
    userName: '레븐',
    availableLimitAmount: 3200000,
    limitTypeLabel: 'Type 1',
    hasExpiredTaxInvoice: true,
  ),
);

const dashboardPageZeroLimitConfig = DashboardPreviewConfig(
  dashboardState: DashboardState(
    userName: '레븐',
    availableLimitAmount: 0,
    limitTypeLabel: 'Type 2',
    zeroLimitReason: '최근 세금계산서 발행 이력이 부족해 한도가 산정되지 않았어요.',
  ),
);

const dashboardPageOverdueConfig = DashboardPreviewConfig(
  dashboardState: DashboardState(
    userName: '레븐',
    availableLimitAmount: 3200000,
    limitTypeLabel: 'Type 1',
    hasOverdueBalance: true,
  ),
);

const dashboardPageExpiredAndOverdueConfig = DashboardPreviewConfig(
  dashboardState: DashboardState(
    userName: '레븐',
    availableLimitAmount: 1800000,
    limitTypeLabel: 'Type 1',
    hasExpiredTaxInvoice: true,
    hasOverdueBalance: true,
  ),
);
