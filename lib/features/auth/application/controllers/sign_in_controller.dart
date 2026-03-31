import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import 'auth_controller.dart';

final signInControllerProvider = AsyncNotifierProvider<SignInController, void>(
  SignInController.new,
);

class SignInController extends AsyncNotifier<void> {
  @override
  void build() {}

  Future<void> signIn({
    required String businessNumber,
    required String password,
  }) async {
    state = const AsyncLoading();

    final useCase = ref.read(signInUseCaseProvider);
    final result = await useCase(
      businessNumber: businessNumber,
      password: password,
    ).run();

    result.match(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        ref.read(authControllerProvider.notifier).setAuthenticated(user);
        state = const AsyncData(null);
      },
    );
  }
}
