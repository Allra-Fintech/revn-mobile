import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

enum DashboardCardMode { normal, overdue, expiredTaxInvoice, zeroLimit }

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState({
    required String userName,
    required int availableLimitAmount,
    required String limitTypeLabel,
    @Default(false) bool hasExpiredTaxInvoice,
    @Default(false) bool hasOverdueBalance,
    String? zeroLimitReason,
  }) = _DashboardState;
}

extension DashboardStateX on DashboardState {
  bool get hasAvailableLimit => availableLimitAmount > 0;
  DashboardCardMode get cardMode {
    if (hasOverdueBalance) {
      return DashboardCardMode.overdue;
    }

    if (hasExpiredTaxInvoice) {
      return DashboardCardMode.expiredTaxInvoice;
    }

    if (!hasAvailableLimit) {
      return DashboardCardMode.zeroLimit;
    }

    return DashboardCardMode.normal;
  }

  String get resolvedZeroLimitReason =>
      zeroLimitReason ?? '최근 발행 내역과 상환 상태를 다시 확인해주세요.';
}
