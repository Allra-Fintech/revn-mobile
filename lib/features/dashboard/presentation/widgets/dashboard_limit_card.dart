import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../application/states/dashboard_state.dart';

class DashboardLimitCard extends StatelessWidget {
  const DashboardLimitCard({
    super.key,
    required this.mode,
    this.availableLimitAmount,
    this.limitTypeLabel,
    this.zeroLimitReason,
    this.onAction,
  }) : assert(
         mode != DashboardCardMode.normal ||
             (availableLimitAmount != null && limitTypeLabel != null),
         'normal mode requires availableLimitAmount and limitTypeLabel',
       );

  final DashboardCardMode mode;
  final int? availableLimitAmount;
  final String? limitTypeLabel;
  final String? zeroLimitReason;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final copy = _DashboardLimitCardCopy.fromMode(
      mode: mode,
      amount: availableLimitAmount,
      limitTypeLabel: limitTypeLabel,
      zeroLimitReason: zeroLimitReason,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: copy.backgroundColors(colorScheme),
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: copy.pillBackgroundColor(colorScheme),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                copy.badgeLabel,
                style: textTheme.labelMedium?.copyWith(
                  color: copy.pillForegroundColor(colorScheme),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            copy.title,
            style: textTheme.titleLarge?.copyWith(
              color: copy.foregroundColor(colorScheme),
              fontWeight: FontWeight.w800,
            ),
          ),
          if (copy.amountLabel != null) ...[
            const SizedBox(height: 8),
            Text(
              copy.amountLabel!,
              style: textTheme.displaySmall?.copyWith(
                color: copy.foregroundColor(colorScheme),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            copy.description,
            style: textTheme.bodyMedium?.copyWith(
              color: copy.foregroundColor(colorScheme).withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          if (copy.secondaryDescription != null) ...[
            const SizedBox(height: 12),
            Text(
              copy.secondaryDescription!,
              style: textTheme.bodySmall?.copyWith(
                color: copy
                    .foregroundColor(colorScheme)
                    .withValues(alpha: 0.82),
                height: 1.5,
              ),
            ),
          ],
          if (copy.actionLabel != null) ...[
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: copy.buttonBackgroundColor(colorScheme),
                foregroundColor: copy.buttonForegroundColor(colorScheme),
              ),
              child: Text(copy.actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

class _DashboardLimitCardCopy {
  const _DashboardLimitCardCopy({
    required this.badgeLabel,
    required this.title,
    required this.description,
    this.amountLabel,
    this.secondaryDescription,
    this.actionLabel,
  });

  final String badgeLabel;
  final String title;
  final String description;
  final String? amountLabel;
  final String? secondaryDescription;
  final String? actionLabel;

  factory _DashboardLimitCardCopy.fromMode({
    required DashboardCardMode mode,
    required int? amount,
    required String? limitTypeLabel,
    required String? zeroLimitReason,
  }) {
    final amountFormatter = NumberFormat('#,###');
    return switch (mode) {
      DashboardCardMode.normal => _DashboardLimitCardCopy(
        badgeLabel: limitTypeLabel!,
        title: '가용 한도',
        amountLabel: '${amountFormatter.format(amount!)}원',
        description: '세금계산서 기준으로 산정된 오늘의 가용 한도예요.',
        actionLabel: '선지급 받기',
      ),
      DashboardCardMode.overdue => const _DashboardLimitCardCopy(
        badgeLabel: '미납',
        title: '미납 내역이 있어요',
        description: '미납 금액을 먼저 납부하면 선지급 이용을 다시 진행할 수 있어요.',
        actionLabel: '납부하기',
      ),
      DashboardCardMode.expiredTaxInvoice => const _DashboardLimitCardCopy(
        badgeLabel: '30일 경과',
        title: '세금계산서 발행일이 30일을 지났어요',
        description: '정확한 한도 확인을 위해 간편인증을 다시 진행해주세요.',
        actionLabel: '간편인증 재진행',
      ),
      DashboardCardMode.zeroLimit => _DashboardLimitCardCopy(
        badgeLabel: '한도 없음',
        title: '가용 한도가 없어요',
        description: '지금은 선지급 가능한 한도가 없어요.',
        secondaryDescription: zeroLimitReason ?? '최근 발행 내역과 상환 상태를 다시 확인해주세요.',
      ),
    };
  }

  List<Color> backgroundColors(ColorScheme colorScheme) {
    return switch (actionLabel) {
      '납부하기' => const [Color(0xFFFFF2F0), Color(0xFFFFE1DA)],
      '간편인증 재진행' => const [Color(0xFFFFF8E8), Color(0xFFFFEDBF)],
      null =>
        badgeLabel == '한도 없음'
            ? const [Color(0xFFF4F7FB), Color(0xFFE8EEF6)]
            : [colorScheme.primary, colorScheme.primaryContainer],
      _ => [colorScheme.primary, colorScheme.primaryContainer],
    };
  }

  Color foregroundColor(ColorScheme colorScheme) {
    return switch (actionLabel) {
      '납부하기' => const Color(0xFF8E2318),
      '간편인증 재진행' => const Color(0xFF7A4E02),
      null =>
        badgeLabel == '한도 없음' ? colorScheme.onSurface : colorScheme.onPrimary,
      _ => colorScheme.onPrimary,
    };
  }

  Color pillBackgroundColor(ColorScheme colorScheme) {
    final foreground = foregroundColor(colorScheme);
    return foreground.withValues(
      alpha: actionLabel == null && badgeLabel != '한도 없음' ? 0.18 : 0.12,
    );
  }

  Color pillForegroundColor(ColorScheme colorScheme) {
    return foregroundColor(colorScheme);
  }

  Color buttonBackgroundColor(ColorScheme colorScheme) {
    return switch (actionLabel) {
      '납부하기' => const Color(0xFF8E2318),
      '간편인증 재진행' => const Color(0xFF7A4E02),
      _ => colorScheme.surface,
    };
  }

  Color buttonForegroundColor(ColorScheme colorScheme) {
    return switch (actionLabel) {
      '납부하기' => Colors.white,
      '간편인증 재진행' => Colors.white,
      _ => colorScheme.primary,
    };
  }
}
