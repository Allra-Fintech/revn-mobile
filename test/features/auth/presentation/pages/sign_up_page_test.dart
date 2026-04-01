import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/usecases/sign_up_usecase.dart';
import 'package:revn/features/auth/application/usecases/verify_business_number_usecase.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/pages/sign_up_page.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';

import '../../helpers/test_auth_controller.dart';

class MockVerifyBusinessNumberUseCase extends Mock
    implements VerifyBusinessNumberUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

void main() {
  late MockVerifyBusinessNumberUseCase verifyBusinessNumberUseCase;
  late MockSignUpUseCase signUpUseCase;
  late TestAuthController authController;

  setUp(() {
    verifyBusinessNumberUseCase = MockVerifyBusinessNumberUseCase();
    signUpUseCase = MockSignUpUseCase();
    authController = TestAuthController(const AuthState.unauthenticated());
  });

  ProviderContainer containerOf(WidgetTester tester) {
    return ProviderScope.containerOf(tester.element(find.byType(SignUpPage)));
  }

  Widget buildTestApp() {
    return ProviderScope(
      overrides: [
        verifyBusinessNumberUseCaseProvider.overrideWithValue(
          verifyBusinessNumberUseCase,
        ),
        signUpUseCaseProvider.overrideWithValue(signUpUseCase),
        authControllerProvider.overrideWith(() => authController),
      ],
      child: const MaterialApp(home: SignUpPage()),
    );
  }

  Widget buildRouterTestApp() {
    final router = GoRouter(
      initialLocation: AuthRoute.signUp.path,
      routes: [
        GoRoute(
          path: AuthRoute.signUp.path,
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: AuthRoute.signIn.path,
          builder: (context, state) => SignInPage(
            initialBusinessNumber: state
                .uri
                .queryParameters[AuthRoutes.signInBusinessNumberQueryParameter],
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
        authControllerProvider.overrideWith(() => authController),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pump();
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
    expect(find.text('이미 가입된 사업자번호입니다. 로그인 화면으로 이동할게요.'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, '로그인하기'));
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
}
