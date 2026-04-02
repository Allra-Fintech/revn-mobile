import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import '../states/sign_in_controller_state.dart';
import 'social_auth_controller.dart';
import 'auth_controller.dart';

final signInControllerProvider =
    NotifierProvider.autoDispose<SignInController, SignInControllerState>(
      SignInController.new,
    );

class SignInController extends Notifier<SignInControllerState> {
  @override
  SignInControllerState build() {
    return const SignInControllerState();
  }

  Future<void> signIn({
    required String businessNumber,
    required String password,
  }) async {
    state = state.copyWith(
      submission: const AsyncLoading(),
      signedInUser: null,
    );

    final useCase = ref.read(signInUseCaseProvider);
    final result = await useCase(
      businessNumber: businessNumber,
      password: password,
    ).run();

    if (!ref.mounted) {
      return;
    }

    await result.match(
      (failure) async {
        if (!ref.mounted) {
          return;
        }

        state = state.copyWith(
          submission: AsyncError<void>(failure, StackTrace.current),
          signedInUser: null,
        );
      },
      (user) async {
        final linked = await ref
            .read(socialAuthControllerProvider.notifier)
            .completePendingLink(user);

        if (!ref.mounted) {
          return;
        }

        state = state.copyWith(
          submission: const AsyncData<void>(null),
          signedInUser: user,
        );

        if (!linked) {
          return;
        }

        ref.read(authControllerProvider.notifier).setAuthenticated(user);
      },
    );
  }

  Future<void> retryPendingSocialLink() async {
    final user = state.signedInUser;
    if (user == null) {
      return;
    }

    final linked = await ref
        .read(socialAuthControllerProvider.notifier)
        .retryPendingLink(user);

    if (!ref.mounted) {
      return;
    }

    if (!linked) {
      return;
    }

    ref.read(authControllerProvider.notifier).setAuthenticated(user);
  }

  void completeSignInWithoutSocialLink() {
    final user = state.signedInUser;
    if (user == null) {
      return;
    }

    ref.read(socialAuthControllerProvider.notifier).clearPendingLink();
    ref.read(authControllerProvider.notifier).setAuthenticated(user);
  }
}
