import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/features/dashboard/application/controllers/dashboard_controller.dart';
import 'package:revn/features/dashboard/application/states/dashboard_state.dart';
import 'package:revn/features/dashboard/presentation/pages/dashboard_action_placeholder_page.dart';
import 'package:revn/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:revn/features/dashboard/presentation/routes/dashboard_routes.dart';

class TestDashboardController extends DashboardController {
  TestDashboardController(this._initialState);

  final DashboardState _initialState;

  @override
  DashboardState build() => _initialState;
}

void main() {
  Widget buildTestApp(DashboardState state) {
    final router = GoRouter(
      initialLocation: DashboardRoute.dashboard.path,
      routes: [
        GoRoute(
          path: DashboardRoute.dashboard.path,
          builder: (context, routeState) => const DashboardPage(),
        ),
        GoRoute(
          path: DashboardRoute.reAuth.path,
          builder: (context, routeState) =>
              const DashboardActionPlaceholderPage(
                title: '간편인증 재진행',
                description: '테스트 목적지',
              ),
        ),
        GoRoute(
          path: DashboardRoute.advanceRequest.path,
          builder: (context, routeState) =>
              const DashboardActionPlaceholderPage(
                title: '선지급 신청',
                description: '테스트 목적지',
              ),
        ),
        GoRoute(
          path: DashboardRoute.payment.path,
          builder: (context, routeState) =>
              const DashboardActionPlaceholderPage(
                title: '납부하기',
                description: '테스트 목적지',
              ),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        dashboardControllerProvider.overrideWith(
          () => TestDashboardController(state),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  const normalState = DashboardState(
    userName: '홍길동',
    availableLimitAmount: 3200000,
    limitTypeLabel: 'Type 1',
  );

  testWidgets('정상 상태에서 대시보드 핵심 요소를 렌더링한다', (tester) async {
    await tester.pumpWidget(buildTestApp(normalState));
    await tester.pumpAndSettle();

    expect(find.text('홍길동님'), findsOneWidget);
    expect(find.text('3,200,000원'), findsOneWidget);
    expect(find.text('Type 1'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '선지급 받기'), findsOneWidget);
  });

  testWidgets('세금계산서 만료 상태에서 금액 없이 재인증 카드만 보여준다', (tester) async {
    await tester.pumpWidget(
      buildTestApp(normalState.copyWith(hasExpiredTaxInvoice: true)),
    );
    await tester.pumpAndSettle();

    expect(find.text('세금계산서 발행일이 30일을 지났어요'), findsOneWidget);
    expect(find.text('3,200,000원'), findsNothing);
    expect(find.text('Type 1'), findsNothing);
    expect(find.text('선지급 받기'), findsNothing);
    expect(find.widgetWithText(FilledButton, '간편인증 재진행'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, '간편인증 재진행'));
    await tester.pumpAndSettle();

    expect(find.text('테스트 목적지'), findsOneWidget);
    expect(find.text('간편인증 재진행'), findsWidgets);
  });

  testWidgets('한도 0원 상태에서 금액과 버튼 없이 사유만 보여준다', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DashboardState(
          userName: '홍길동',
          availableLimitAmount: 0,
          limitTypeLabel: 'Type 2',
          zeroLimitReason: '최근 세금계산서 발행 이력이 부족해 한도가 산정되지 않았어요.',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('가용 한도가 없어요'), findsOneWidget);
    expect(find.text('0원'), findsNothing);
    expect(find.text('Type 2'), findsNothing);
    expect(find.text('최근 세금계산서 발행 이력이 부족해 한도가 산정되지 않았어요.'), findsOneWidget);
    expect(find.text('선지급 받기'), findsNothing);
    expect(find.text('납부하기'), findsNothing);
    expect(find.text('간편인증 재진행'), findsNothing);
  });

  testWidgets('미납 상태에서 금액 없이 납부하기 카드만 보여준다', (tester) async {
    await tester.pumpWidget(
      buildTestApp(normalState.copyWith(hasOverdueBalance: true)),
    );
    await tester.pumpAndSettle();

    expect(find.text('미납 내역이 있어요'), findsOneWidget);
    expect(find.text('3,200,000원'), findsNothing);
    expect(find.text('Type 1'), findsNothing);
    expect(find.text('선지급 받기'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, '납부하기'));
    await tester.pumpAndSettle();

    expect(find.text('납부하기'), findsWidgets);
    expect(find.text('테스트 목적지'), findsOneWidget);
  });

  testWidgets('미납과 30일 경과가 함께 있으면 미납 카드가 우선이다', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        normalState.copyWith(
          hasOverdueBalance: true,
          hasExpiredTaxInvoice: true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('미납 내역이 있어요'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '납부하기'), findsOneWidget);
    expect(find.text('세금계산서 발행일이 30일을 지났어요'), findsNothing);
    expect(find.text('간편인증 재진행'), findsNothing);
  });
}
