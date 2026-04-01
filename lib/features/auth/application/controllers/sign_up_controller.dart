import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import '../states/sign_up_controller_state.dart';
import '../../domain/entities/current_user.dart';

final signUpControllerProvider =
    NotifierProvider.autoDispose<SignUpController, SignUpControllerState>(
      SignUpController.new,
    );

class SignUpController extends Notifier<SignUpControllerState> {
  @override
  SignUpControllerState build() {
    return const SignUpControllerState();
  }

  void reset() {
    state = const SignUpControllerState();
  }

  void resetVerification() {
    state = state.copyWith(verification: const AsyncData<void>(null));
  }

  Future<bool> verifyBusinessNumber({required String businessNumber}) async {
    state = state.copyWith(verification: const AsyncLoading());

    final useCase = ref.read(verifyBusinessNumberUseCaseProvider);
    final result = await useCase(businessNumber: businessNumber).run();

    return result.match(
      (failure) {
        state = state.copyWith(
          verification: AsyncError<void>(failure, StackTrace.current),
        );
        return false;
      },
      (_) {
        state = state.copyWith(verification: const AsyncData<void>(null));
        return true;
      },
    );
  }

  Future<CurrentUser?> signUp({
    required String businessNumber,
    required String password,
  }) async {
    state = state.copyWith(
      submission: const AsyncLoading(),
      signedUpUser: null,
    );

    final useCase = ref.read(signUpUseCaseProvider);
    final result = await useCase(
      businessNumber: businessNumber,
      password: password,
    ).run();

    return result.match(
      (failure) {
        state = state.copyWith(
          submission: AsyncError<void>(failure, StackTrace.current),
          signedUpUser: null,
        );
        return null;
      },
      (user) {
        state = state.copyWith(
          submission: const AsyncData<void>(null),
          signedUpUser: user,
        );
        return user;
      },
    );
  }
}
