import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import 'auth_controller.dart';

final signInControllerProvider = AsyncNotifierProvider<SignInController, void>(
  SignInController.new,
);

class SignInController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    final useCase = ref.read(signInUseCaseProvider);
    final result = await useCase(email: email, password: password).run();

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
