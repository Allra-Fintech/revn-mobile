import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/controllers/social_auth_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/usecases/link_social_account_usecase.dart';
import 'package:revn/features/auth/application/usecases/sign_in_with_social_usecase.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/entities/pending_social_link.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/domain/services/social_token_provider.dart';

import '../../helpers/test_auth_controller.dart';

class MockSignInWithSocialUseCase extends Mock
    implements SignInWithSocialUseCase {}

class MockLinkSocialAccountUseCase extends Mock
    implements LinkSocialAccountUseCase {}

class MockSocialTokenProvider extends Mock implements SocialTokenProvider {}

void main() {
  late ProviderContainer container;
  late MockSignInWithSocialUseCase signInWithSocialUseCase;
  late MockLinkSocialAccountUseCase linkSocialAccountUseCase;
  late MockSocialTokenProvider socialTokenProvider;
  late TestAuthController authController;

  const user = CurrentUser(
    id: '1',
    businessNumber: '1234567890',
    username: 'Mock Owner',
  );

  setUp(() {
    signInWithSocialUseCase = MockSignInWithSocialUseCase();
    linkSocialAccountUseCase = MockLinkSocialAccountUseCase();
    socialTokenProvider = MockSocialTokenProvider();
    authController = TestAuthController(const AuthState.unauthenticated());

    container = ProviderContainer(
      overrides: [
        authControllerProvider.overrideWith(() => authController),
        signInWithSocialUseCaseProvider.overrideWithValue(
          signInWithSocialUseCase,
        ),
        linkSocialAccountUseCaseProvider.overrideWithValue(
          linkSocialAccountUseCase,
        ),
        socialTokenProviderProvider.overrideWithValue(socialTokenProvider),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('소셜 로그인 성공 시 authenticated 상태가 된다', () async {
    when(
      () => socialTokenProvider.getAccessToken(SocialProvider.kakao),
    ).thenAnswer((_) async => 'linked-social-token');
    when(
      () => signInWithSocialUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'linked-social-token',
      ),
    ).thenReturn(TaskEither.right(user));

    await container
        .read(socialAuthControllerProvider.notifier)
        .signInWithProvider(SocialProvider.kakao);

    expect(
      container.read(authControllerProvider),
      const AuthState.authenticated(user),
    );
    expect(container.read(socialAuthControllerProvider).pendingLink, isNull);
  });

  test('미연동 소셜 계정이면 pending link 상태를 저장한다', () async {
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

    await container
        .read(socialAuthControllerProvider.notifier)
        .signInWithProvider(SocialProvider.kakao);

    final state = container.read(socialAuthControllerProvider);

    expect(state.pendingLink, isNotNull);
    expect(state.pendingLink!.provider, SocialProvider.kakao);
    expect(state.pendingLink!.accessToken, 'unlinked-social-token');
    expect(state.pendingLink!.linkStatus, SocialLinkStatus.pending);
  });

  test('pending link 연동 성공 시 상태를 정리한다', () async {
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
    when(
      () => linkSocialAccountUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'unlinked-social-token',
      ),
    ).thenReturn(TaskEither.right(unit));

    await container
        .read(socialAuthControllerProvider.notifier)
        .signInWithProvider(SocialProvider.kakao);

    final linked = await container
        .read(socialAuthControllerProvider.notifier)
        .completePendingLink(user);

    expect(linked, true);
    expect(container.read(socialAuthControllerProvider).pendingLink, isNull);
  });

  test('pending link 연동 실패 시 failed 상태와 메시지를 저장한다', () async {
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
    when(
      () => linkSocialAccountUseCase(
        provider: SocialProvider.kakao,
        accessToken: 'unlinked-social-token',
      ),
    ).thenReturn(
      TaskEither.left(const AuthFailure.common(CommonFailure.server('연동 실패'))),
    );

    await container
        .read(socialAuthControllerProvider.notifier)
        .signInWithProvider(SocialProvider.kakao);

    final linked = await container
        .read(socialAuthControllerProvider.notifier)
        .completePendingLink(user);

    final state = container.read(socialAuthControllerProvider);

    expect(linked, false);
    expect(state.pendingLink, isNotNull);
    expect(state.pendingLink!.linkStatus, SocialLinkStatus.failed);
    expect(state.pendingLink!.lastErrorMessage, '연동 실패');
  });
}
