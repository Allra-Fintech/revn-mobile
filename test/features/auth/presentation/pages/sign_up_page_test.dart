import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/controllers/social_auth_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/states/social_auth_state.dart';
import 'package:revn/features/auth/application/usecases/link_social_account_usecase.dart';
import 'package:revn/features/auth/application/usecases/sign_up_usecase.dart';
import 'package:revn/features/auth/application/usecases/verify_business_number_usecase.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/entities/pending_social_link.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/models/agreement_document.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_up_page.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';
import 'package:revn/features/auth/presentation/widgets/social_link_notice_card.dart';

import '../../helpers/test_auth_controller.dart';
import '../../helpers/test_social_auth_controller.dart';

class MockVerifyBusinessNumberUseCase extends Mock
    implements VerifyBusinessNumberUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockLinkSocialAccountUseCase extends Mock
    implements LinkSocialAccountUseCase {}

class _AgreementDetailsTestPage extends StatelessWidget {
  const _AgreementDetailsTestPage({required this.document});

  final AgreementDocument document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(document.title)),
      body: Text(document.url),
    );
  }
}

void main() {
  late MockVerifyBusinessNumberUseCase verifyBusinessNumberUseCase;
  late MockSignUpUseCase signUpUseCase;
  late MockLinkSocialAccountUseCase linkSocialAccountUseCase;
  late TestAuthController authController;

  setUp(() {
    verifyBusinessNumberUseCase = MockVerifyBusinessNumberUseCase();
    signUpUseCase = MockSignUpUseCase();
    linkSocialAccountUseCase = MockLinkSocialAccountUseCase();
    authController = TestAuthController(const AuthState.unauthenticated());
  });

  ProviderContainer containerOf(WidgetTester tester) {
    return ProviderScope.containerOf(tester.element(find.byType(SignUpPage)));
  }

  Widget buildTestApp({
    SocialAuthState initialSocialAuthState = const SocialAuthState(),
  }) {
    return ProviderScope(
      overrides: [
        verifyBusinessNumberUseCaseProvider.overrideWithValue(
          verifyBusinessNumberUseCase,
        ),
        signUpUseCaseProvider.overrideWithValue(signUpUseCase),
        linkSocialAccountUseCaseProvider.overrideWithValue(
          linkSocialAccountUseCase,
        ),
        authControllerProvider.overrideWith(() => authController),
        socialAuthControllerProvider.overrideWith(
          () => TestSocialAuthController(initialSocialAuthState),
        ),
      ],
      child: const MaterialApp(home: SignUpPage()),
    );
  }

  Widget buildRouterTestApp({
    SocialAuthState initialSocialAuthState = const SocialAuthState(),
  }) {
    final router = GoRouter(
      initialLocation: AuthRoute.signUp.path,
      routes: [
        GoRoute(
          name: AuthRoute.signUp.name,
          path: AuthRoute.signUp.path,
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          name: AuthRoute.signIn.name,
          path: AuthRoute.signIn.path,
          builder: (context, state) => SignInPage(
            initialBusinessNumber: state
                .uri
                .queryParameters[AuthRoutes.signInBusinessNumberQueryParameter],
          ),
        ),
        GoRoute(
          name: AuthRoute.agreement.name,
          path: AuthRoute.agreement.path,
          builder: (context, state) => _AgreementDetailsTestPage(
            document: state.extra! as AgreementDocument,
          ),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        verifyBusinessNumberUseCaseProvider.overrideWithValue(
          verifyBusinessNumberUseCase,
        ),
        signUpUseCaseProvider.overrideWithValue(signUpUseCase),
        linkSocialAccountUseCaseProvider.overrideWithValue(
          linkSocialAccountUseCase,
        ),
        authControllerProvider.overrideWith(() => authController),
        socialAuthControllerProvider.overrideWith(
          () => TestSocialAuthController(initialSocialAuthState),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pump();
  }

  PendingSocialLink kakaoPendingLink({
    SocialLinkStatus linkStatus = SocialLinkStatus.pending,
    String? lastErrorMessage,
  }) {
    return PendingSocialLink(
      provider: SocialProvider.kakao,
      accessToken: 'pending-kakao-token',
      linkStatus: linkStatus,
      lastErrorMessage: lastErrorMessage,
    );
  }

  Future<void> goToCredentialsStep(WidgetTester tester) async {
    await tester.tap(find.textContaining('서비스 이용약관'));
    await tester.pump();
    await tester.tap(find.textContaining('개인정보 수집 및 이용동의'));
    await tester.pump();
    await tester.tap(find.textContaining('개인정보 제공 및 위탁동의'));
    await tester.pump();
    await tester.ensureVisible(find.widgetWithText(FilledButton, '다음'));
    await tester.tap(find.widgetWithText(FilledButton, '다음'));
    await tester.pumpAndSettle();
  }

  Future<void> completeSignUpFlow(
    WidgetTester tester, {
    required String businessNumber,
    required String password,
  }) async {
    await goToCredentialsStep(tester);

    await tester.enterText(find.byType(TextFormField).at(0), businessNumber);
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(1), password);
    await tester.enterText(find.byType(TextFormField).at(2), password);
    await tester.tap(find.widgetWithText(FilledButton, '가입하기'));
    await tester.pumpAndSettle();
  }

  FilledButton filledButton(WidgetTester tester, String text) {
    return tester.widget<FilledButton>(find.widgetWithText(FilledButton, text));
  }

  String? textFieldValue(WidgetTester tester, int index) {
    return tester
        .widget<TextFormField>(find.byType(TextFormField).at(index))
        .controller
        ?.text;
  }

  testWidgets('전체 동의 시 모든 약관 체크박스가 선택된다', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.text('전체 동의'));
    await tester.pumpAndSettle();

    final checkboxes = tester.widgetList<Checkbox>(find.byType(Checkbox));

    expect(checkboxes.every((checkbox) => checkbox.value ?? false), true);
  });

  testWidgets('필수 약관 3개에만 상세 보기 아이콘이 노출된다', (tester) async {
    await pumpPage(tester);

    expect(find.byIcon(Icons.chevron_right_rounded), findsNWidgets(3));
    expect(find.byTooltip('서비스 이용약관 보기'), findsOneWidget);
    expect(find.byTooltip('개인정보 수집 및 이용동의 보기'), findsOneWidget);
    expect(find.byTooltip('개인정보 제공 및 위탁동의 보기'), findsOneWidget);
    expect(find.byTooltip('전체 동의 보기'), findsNothing);
    expect(find.byTooltip('마케팅 활용 및 광고성 정보 수신 동의 보기'), findsNothing);
  });

  testWidgets('상세 보기 아이콘 탭 시 체크 상태는 유지되고 상세 페이지가 열린다', (tester) async {
    await tester.pumpWidget(buildRouterTestApp());
    await tester.pump();

    final checkboxesBeforeTap = tester
        .widgetList<Checkbox>(find.byType(Checkbox))
        .toList();

    expect(checkboxesBeforeTap[1].value, false);

    await tester.tap(find.byTooltip('서비스 이용약관 보기'));
    await tester.pumpAndSettle();

    expect(find.text('서비스 이용약관'), findsOneWidget);
    expect(find.text('https://docs.revn.co.kr/terms'), findsOneWidget);
    expect(find.byType(SignUpPage), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byType(SignUpPage), findsOneWidget);
    expect(
      tester.widgetList<Checkbox>(find.byType(Checkbox)).toList()[1].value,
      false,
    );
  });

  testWidgets('약관 행 탭은 기존처럼 동의 체크만 토글한다', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.textContaining('서비스 이용약관'));
    await tester.pumpAndSettle();

    expect(
      tester.widgetList<Checkbox>(find.byType(Checkbox)).toList()[1].value,
      true,
    );
    expect(find.text('https://docs.revn.co.kr/terms'), findsNothing);
  });

  testWidgets('각 상세 보기 아이콘은 올바른 문서로 연결된다', (tester) async {
    await tester.pumpWidget(buildRouterTestApp());
    await tester.pump();

    await tester.tap(find.byTooltip('개인정보 수집 및 이용동의 보기'));
    await tester.pumpAndSettle();

    expect(find.text('개인정보 수집 및 이용동의'), findsOneWidget);
    expect(find.text('https://docs.revn.co.kr/privacy'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('개인정보 제공 및 위탁동의 보기'));
    await tester.pumpAndSettle();

    expect(find.text('개인정보 제공 및 위탁동의'), findsOneWidget);
    expect(find.text('https://docs.revn.co.kr/third-party'), findsOneWidget);
  });

  testWidgets('필수 약관만 동의해도 다음 단계로 이동할 수 있다', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.textContaining('서비스 이용약관'));
    await tester.pump();
    await tester.tap(find.textContaining('개인정보 수집 및 이용동의'));
    await tester.pump();
    await tester.tap(find.textContaining('개인정보 제공 및 위탁동의'));
    await tester.pump();

    final nextButton = filledButton(tester, '다음');
    final allAgreementCheckbox = tester
        .widgetList<Checkbox>(find.byType(Checkbox))
        .first;

    expect(nextButton.onPressed, isNotNull);
    expect(allAgreementCheckbox.value, false);

    await tester.ensureVisible(find.widgetWithText(FilledButton, '다음'));
    await tester.tap(find.widgetWithText(FilledButton, '다음'));
    await tester.pumpAndSettle();

    expect(find.text('사업자번호'), findsOneWidget);
  });

  testWidgets('전체 동의 후 개별 약관을 해제하면 전체 동의도 해제된다', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.text('전체 동의'));
    await tester.pump();
    await tester.tap(find.textContaining('개인정보 제공 및 위탁동의'));
    await tester.pumpAndSettle();

    final checkboxes = tester
        .widgetList<Checkbox>(find.byType(Checkbox))
        .toList();

    expect(checkboxes.first.value, false);
    expect(checkboxes[3].value, false);
  });

  testWidgets('pending link가 있어도 회원가입 화면에서는 연결 안내 카드를 보여주지 않는다', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        initialSocialAuthState: SocialAuthState(
          pendingLink: kakaoPendingLink(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SocialLinkNoticeCard), findsNothing);
    expect(find.text('카카오 계정을 연결하는 중입니다'), findsNothing);
  });

  testWidgets('사업자번호 인증은 validator 통과 후 mock 인증을 호출한다', (tester) async {
    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));

    await pumpPage(tester);
    await goToCredentialsStep(tester);

    await tester.enterText(find.byType(TextFormField).at(0), '123456789');
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pump();

    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsOneWidget);
    verifyNever(
      () => verifyBusinessNumberUseCase(
        businessNumber: any(named: 'businessNumber'),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), '1234567890');
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pumpAndSettle();

    verify(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).called(1);
    expect(find.text('사업자번호 인증이 완료되었습니다.'), findsOneWidget);
  });

  testWidgets('인증 후 사업자번호를 수정하면 재인증이 필요해진다', (tester) async {
    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));

    await pumpPage(tester);
    await goToCredentialsStep(tester);

    await tester.enterText(find.byType(TextFormField).at(0), '1234567890');
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pumpAndSettle();

    expect(filledButton(tester, '가입하기').onPressed, isNotNull);

    await tester.enterText(find.byType(TextFormField).at(0), '4090000000');
    await tester.pumpAndSettle();

    expect(find.text('가입 전에 사업자번호 인증이 필요합니다.'), findsOneWidget);
    expect(filledButton(tester, '가입하기').onPressed, isNull);
  });

  testWidgets('비밀번호 확인이 다르면 가입을 진행하지 않는다', (tester) async {
    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));

    await pumpPage(tester);
    await goToCredentialsStep(tester);

    await tester.enterText(find.byType(TextFormField).at(0), '1234567890');
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.enterText(find.byType(TextFormField).at(2), '4321');
    await tester.tap(find.widgetWithText(FilledButton, '가입하기'));
    await tester.pump();

    expect(find.text('비밀번호가 일치하지 않습니다.'), findsOneWidget);
    verifyNever(
      () => signUpUseCase(
        businessNumber: any(named: 'businessNumber'),
        password: any(named: 'password'),
      ),
    );
  });

  testWidgets('중복 사업자번호 인증 시 안내 다이얼로그 후 로그인 화면으로 이동하고 번호를 채운다', (tester) async {
    when(
      () => verifyBusinessNumberUseCase(businessNumber: '4090000000'),
    ).thenReturn(TaskEither.left(const AuthFailure.duplicateBusinessNumber()));

    await tester.pumpWidget(buildRouterTestApp());
    await tester.pump();
    await goToCredentialsStep(tester);

    await tester.enterText(find.byType(TextFormField).at(0), '4090000000');
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.text('입력하신 사업자번호는 이미 등록되어 있습니다.\n로그인 화면으로 이동하시겠습니까?'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(FilledButton, '이동'));
    await tester.pumpAndSettle();

    expect(find.byType(SignInPage), findsOneWidget);
    expect(textFieldValue(tester, 0), '409-00-00000');
    expect(textFieldValue(tester, 1), isEmpty);
  });

  testWidgets('가입 성공 시 시작하기 버튼 전까지는 머물고 버튼 탭 후 authenticated 상태가 된다', (
    tester,
  ) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await pumpPage(tester);
    await goToCredentialsStep(tester);

    await tester.enterText(find.byType(TextFormField).at(0), '1234567890');
    await tester.tap(find.widgetWithText(OutlinedButton, '인증하기'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.enterText(find.byType(TextFormField).at(2), '1234');
    await tester.tap(find.widgetWithText(FilledButton, '가입하기'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    verify(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).called(1);
    expect(find.text('가입을 환영합니다'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '시작하기'), findsOneWidget);

    expect(
      containerOf(tester).read(authControllerProvider),
      const AuthState.unauthenticated(),
    );

    await tester.tap(find.widgetWithText(FilledButton, '시작하기'));
    await tester.pumpAndSettle();

    expect(
      containerOf(tester).read(authControllerProvider),
      const AuthState.authenticated(user),
    );
  });

  testWidgets('카카오 pending link 상태로 회원가입 성공 시 연동 확인 다이얼로그가 뜬다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await tester.pumpWidget(
      buildTestApp(
        initialSocialAuthState: SocialAuthState(
          pendingLink: kakaoPendingLink(),
        ),
      ),
    );
    await tester.pump();

    await completeSignUpFlow(
      tester,
      businessNumber: '1234567890',
      password: '1234',
    );

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('카카오 계정 연동'), findsOneWidget);
    expect(
      find.text(
        '최근 로그인한 카카오 게정을 가입과 연동할 수 있습니다. 다음 로그인시 카카오로 간편하게 로그인할 수 있어요.',
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(TextButton, '나중에'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '연동'), findsOneWidget);
  });

  testWidgets('연동 확인 다이얼로그에서 나중에를 누르면 welcome 단계로 이동하고 연동 호출은 없다', (
    tester,
  ) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await tester.pumpWidget(
      buildTestApp(
        initialSocialAuthState: SocialAuthState(
          pendingLink: kakaoPendingLink(),
        ),
      ),
    );
    await tester.pump();

    await completeSignUpFlow(
      tester,
      businessNumber: '1234567890',
      password: '1234',
    );
    await tester.tap(find.widgetWithText(TextButton, '나중에'));
    await tester.pumpAndSettle();

    verifyNever(
      () => linkSocialAccountUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'pending-kakao-token',
      ),
    );
    expect(find.text('가입을 환영합니다'), findsOneWidget);
  });

  testWidgets('연동 확인 다이얼로그에서 연동을 누르면 연동 호출 후 welcome 단계로 이동한다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));
    when(
      () => linkSocialAccountUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'pending-kakao-token',
      ),
    ).thenReturn(TaskEither.right(unit));

    await tester.pumpWidget(
      buildTestApp(
        initialSocialAuthState: SocialAuthState(
          pendingLink: kakaoPendingLink(),
        ),
      ),
    );
    await tester.pump();

    await completeSignUpFlow(
      tester,
      businessNumber: '1234567890',
      password: '1234',
    );
    await tester.tap(find.widgetWithText(FilledButton, '연동'));
    await tester.pumpAndSettle();

    verify(
      () => linkSocialAccountUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'pending-kakao-token',
      ),
    ).called(1);
    expect(find.text('가입을 환영합니다'), findsOneWidget);
    expect(
      containerOf(tester).read(socialAuthControllerProvider).pendingLink,
      isNull,
    );
  });

  testWidgets('연동 실패 시 snackbar만 보여주고 welcome 단계로 이동한다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));
    when(
      () => linkSocialAccountUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'pending-kakao-token',
      ),
    ).thenReturn(
      TaskEither.left(const AuthFailure.common(CommonFailure.server('연동 실패'))),
    );

    await tester.pumpWidget(
      buildTestApp(
        initialSocialAuthState: SocialAuthState(
          pendingLink: kakaoPendingLink(),
        ),
      ),
    );
    await tester.pump();

    await completeSignUpFlow(
      tester,
      businessNumber: '1234567890',
      password: '1234',
    );
    await tester.tap(find.widgetWithText(FilledButton, '연동'));
    await tester.pumpAndSettle();

    expect(find.text('연동 실패'), findsOneWidget);
    expect(find.text('가입을 환영합니다'), findsOneWidget);
    expect(find.byType(SocialLinkNoticeCard), findsNothing);
    expect(
      containerOf(
        tester,
      ).read(socialAuthControllerProvider).pendingLink?.linkStatus,
      SocialLinkStatus.failed,
    );
  });

  testWidgets('나중에를 선택한 뒤 시작하기를 누르면 pending link를 정리하고 authenticated 상태가 된다', (
    tester,
  ) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await tester.pumpWidget(
      buildTestApp(
        initialSocialAuthState: SocialAuthState(
          pendingLink: kakaoPendingLink(),
        ),
      ),
    );
    await tester.pump();

    await completeSignUpFlow(
      tester,
      businessNumber: '1234567890',
      password: '1234',
    );
    await tester.tap(find.widgetWithText(TextButton, '나중에'));
    await tester.pumpAndSettle();

    expect(
      containerOf(tester).read(socialAuthControllerProvider).pendingLink,
      isNotNull,
    );

    await tester.tap(find.widgetWithText(FilledButton, '시작하기'));
    await tester.pumpAndSettle();

    expect(
      containerOf(tester).read(socialAuthControllerProvider).pendingLink,
      isNull,
    );
    expect(
      containerOf(tester).read(authControllerProvider),
      const AuthState.authenticated(user),
    );
  });
}
