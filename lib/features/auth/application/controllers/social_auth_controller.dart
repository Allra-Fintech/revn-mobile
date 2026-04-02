import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revn/core/errors/common_failure.dart';

import '../../../../app/providers/app_providers.dart';
import '../providers/auth_providers.dart';
import '../states/social_auth_state.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/entities/pending_social_link.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/failures/auth_failure.dart';
import 'auth_controller.dart';

final socialAuthControllerProvider =
    NotifierProvider<SocialAuthController, SocialAuthState>(
      SocialAuthController.new,
    );

class SocialAuthController extends Notifier<SocialAuthState> {
  @override
  SocialAuthState build() {
    return const SocialAuthState();
  }

  Future<void> signInWithProvider(SocialProvider provider) async {
    state = state.copyWith(
      socialSignIn: const AsyncLoading(),
      pendingLink: null,
    );

    try {
      final accessToken = await ref
          .read(socialTokenProviderProvider)
          .getAccessToken(provider);

      final result = await ref
          .read(signInWithSocialUseCaseProvider)(
            provider: provider,
            accessToken: accessToken,
          )
          .run();

      result.match(
        (failure) {
          if (failure case SocialAccountNotLinked(:final provider)) {
            state = SocialAuthState(
              socialSignIn: const AsyncData<void>(null),
              pendingLink: PendingSocialLink(
                provider: provider,
                accessToken: accessToken,
              ),
            );
            return;
          }

          state = state.copyWith(
            socialSignIn: AsyncError<void>(failure, StackTrace.current),
          );
        },
        (user) {
          ref.read(authControllerProvider.notifier).setAuthenticated(user);
          state = const SocialAuthState();
        },
      );
    } catch (error, stackTrace) {
      ref
          .read(talkerProvider)
          .handle(
            error,
            stackTrace,
            'Social sign-in failed while requesting provider token or authenticating.',
          );
      state = state.copyWith(
        socialSignIn: AsyncError<void>(
          const AuthFailure.common(CommonFailure.unknown()),
          stackTrace,
        ),
      );
    }
  }

  Future<bool> completePendingLink(CurrentUser user) async {
    final pendingLink = state.pendingLink;
    if (pendingLink == null) {
      return true;
    }

    state = state.copyWith(
      pendingLink: pendingLink.copyWith(
        linkStatus: SocialLinkStatus.linking,
        lastErrorMessage: null,
      ),
    );

    final result = await ref
        .read(linkSocialAccountUseCaseProvider)(
          provider: pendingLink.provider,
          accessToken: pendingLink.accessToken,
        )
        .run();

    return result.match(
      (failure) {
        state = state.copyWith(
          pendingLink: pendingLink.copyWith(
            linkStatus: SocialLinkStatus.failed,
            lastErrorMessage: _messageForFailure(failure),
          ),
        );
        return false;
      },
      (_) {
        state = const SocialAuthState();
        return true;
      },
    );
  }

  Future<bool> retryPendingLink(CurrentUser user) {
    return completePendingLink(user);
  }

  void clearPendingLink() {
    state = state.copyWith(pendingLink: null);
  }

  void resetSocialSignInError() {
    state = state.copyWith(socialSignIn: const AsyncData<void>(null));
  }

  String _messageForFailure(AuthFailure failure) {
    return switch (failure) {
      InvalidCredentials() => '소셜 계정 인증 정보를 다시 확인해주세요.',
      Unauthorized() => '인증이 만료되었거나 유효하지 않습니다.',
      DuplicateBusinessNumber() => '이미 가입된 사업자번호입니다.',
      SocialAccountNotLinked(:final provider) =>
        '${provider.displayName} 계정이 아직 연동되지 않았습니다.',
      CommonAuthFailure(:final failure) => switch (failure) {
        NetworkFailure() => '네트워크 연결을 확인해주세요.',
        StorageFailure() => '기기 저장소 접근에 실패했습니다.',
        ServerFailure() => '요청 처리 중 오류가 발생했습니다.',
        UnknownFailure() => '알 수 없는 오류가 발생했습니다.',
      },
    };
  }
}
