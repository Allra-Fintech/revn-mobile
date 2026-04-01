import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/usecases/sign_in_with_social_usecase.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/domain/services/social_token_provider.dart';
import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';

import '../../helpers/test_auth_controller.dart';

class MockSignInWithSocialUseCase extends Mock
    implements SignInWithSocialUseCase {}

class MockSocialTokenProvider extends Mock implements SocialTokenProvider {}

class _SignUpPlaceholderPage extends StatelessWidget {
  const _SignUpPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('회원가입 페이지')));
  }
}

void main() {
  late MockSignInWithSocialUseCase signInWithSocialUseCase;
  late MockSocialTokenProvider socialTokenProvider;
  late TestAuthController authController;

  setUp(() {
    signInWithSocialUseCase = MockSignInWithSocialUseCase();
    socialTokenProvider = MockSocialTokenProvider();
    authController = TestAuthController(const AuthState.unauthenticated());
  });

  Widget buildTestApp() {
    final router = GoRouter(
      initialLocation: AuthRoute.signIn.path,
      routes: [
        GoRoute(
          name: AuthRoute.signIn.name,
          path: AuthRoute.signIn.path,
          builder: (context, state) => const SignInPage(),
        ),
        GoRoute(
          name: AuthRoute.signUp.name,
          path: AuthRoute.signUp.path,
          builder: (context, state) => const _SignUpPlaceholderPage(),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(() => authController),
        signInWithSocialUseCaseProvider.overrideWithValue(
          signInWithSocialUseCase,
        ),
        socialTokenProviderProvider.overrideWithValue(socialTokenProvider),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('카카오 로그인 버튼 탭 시 현재 로그인 화면에서 연결 안내를 보여준다', (tester) async {
    when(
      () => socialTokenProvider.getAccessToken(SocialProvider.kakao),
    ).thenAnswer((_) async => 'unlinked-social-token');
    when(
      () => signInWithSocialUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'unlinked-social-token',
      ),
    ).thenReturn(
      TaskEither.left(
        const AuthFailure.socialAccountNotLinked(SocialProvider.kakao),
      ),
    );

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, '카카오 로그인'));
    await tester.pumpAndSettle();

    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.text('카카오 계정 연동'), findsOneWidget);
    expect(
      find.text('현재 카카오 계정과 연동된 사업자번호가 없습니다. \n최초 사업자번호로 로그인 후 카카오 로그인이 가능합니다.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '카카오 로그인'), findsNothing);
    expect(find.widgetWithText(TextButton, '회원가입'), findsOneWidget);
  });

  testWidgets('연결 안내 상태에서도 회원가입 링크로 이동할 수 있다', (tester) async {
    when(
      () => socialTokenProvider.getAccessToken(SocialProvider.kakao),
    ).thenAnswer((_) async => 'unlinked-social-token');
    when(
      () => signInWithSocialUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'unlinked-social-token',
      ),
    ).thenReturn(
      TaskEither.left(
        const AuthFailure.socialAccountNotLinked(SocialProvider.kakao),
      ),
    );

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, '카카오 로그인'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '회원가입'));
    await tester.pumpAndSettle();

    expect(find.text('회원가입 페이지'), findsOneWidget);
  });

  testWidgets('연결 안내 상태에서 X 버튼 탭 시 카카오 로그인 버튼이 다시 보인다', (tester) async {
    when(
      () => socialTokenProvider.getAccessToken(SocialProvider.kakao),
    ).thenAnswer((_) async => 'unlinked-social-token');
    when(
      () => signInWithSocialUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'unlinked-social-token',
      ),
    ).thenReturn(
      TaskEither.left(
        const AuthFailure.socialAccountNotLinked(SocialProvider.kakao),
      ),
    );

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, '카카오 로그인'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, '카카오 로그인'), findsOneWidget);
    expect(find.text('카카오 계정 연동'), findsNothing);
  });
}
