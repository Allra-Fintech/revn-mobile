import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:revn/app/theme/app_theme.dart';
import 'package:revn/core/config/app_config.dart';
import 'package:revn/core/logging/app_talker.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/dashboard/application/states/dashboard_state.dart';
import 'package:revn/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:revn/features/dashboard/presentation/widgets/dashboard_limit_card.dart';

import '../../widgetbook/src/preview/auth/auth_preview_scope.dart';
import '../../widgetbook/src/preview/dashboard/dashboard_preview_scope.dart';
import '../../widgetbook/src/preview/preview_shell.dart';
import '../../widgetbook/use_cases/auth/sign_in_page/scenarios.dart';
import '../../widgetbook/use_cases/dashboard/dashboard_page/scenarios.dart';
import '../../widgetbook/widgetbook.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<SharedPreferences> createSharedPreferences() async {
    SharedPreferences.setMockInitialValues(const {});
    return SharedPreferences.getInstance();
  }

  const previewConfig = AppConfig(
    environment: AppEnvironment.dev,
    baseUrl: '',
    apiMode: AppApiMode.mock,
  );

  testWidgets('Widgetbook 루트가 부팅된다', (tester) async {
    final sharedPreferences = await createSharedPreferences();

    await tester.pumpWidget(
      WidgetbookApp(
        sharedPreferences: sharedPreferences,
        talker: createTalker(),
        appConfig: previewConfig,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Widgetbook), findsOneWidget);
  });

  testWidgets('인증 기본 use case가 preview shell에서 렌더링된다', (tester) async {
    final sharedPreferences = await createSharedPreferences();
    final talker = createTalker();

    await tester.pumpWidget(
      WidgetbookPreviewShell(
        sharedPreferences: sharedPreferences,
        talker: talker,
        appConfig: previewConfig,
        theme: RevnTheme.light,
        child: const AuthPreviewScope(
          config: signInPageBasicConfig,
          child: SignInPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '로그인'), findsOneWidget);
  });

  testWidgets('대시보드 기본 use case가 preview shell에서 렌더링된다', (tester) async {
    final sharedPreferences = await createSharedPreferences();
    final talker = createTalker();

    await tester.pumpWidget(
      WidgetbookPreviewShell(
        sharedPreferences: sharedPreferences,
        talker: talker,
        appConfig: previewConfig,
        theme: RevnTheme.light,
        child: const DashboardPreviewScope(
          config: dashboardPageBasicConfig,
          child: DashboardPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DashboardPage), findsOneWidget);
    expect(find.text('3,200,000원'), findsOneWidget);
  });

  testWidgets('대시보드 한도 카드 위젯이 렌더링된다', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: RevnTheme.light,
        home: Scaffold(
          body: DashboardLimitCard(
            mode: DashboardCardMode.normal,
            availableLimitAmount: 3200000,
            limitTypeLabel: 'Type 1',
            onAction: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DashboardLimitCard), findsOneWidget);
    expect(find.text('3,200,000원'), findsOneWidget);
    expect(find.text('Type 1'), findsOneWidget);
  });
}
