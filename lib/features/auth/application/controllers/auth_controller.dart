import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import '../states/auth_state.dart';
import '../../domain/entities/current_user.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> restoreSession() async {
    state = const AuthState.loading();

    final useCase = ref.read(restoreSessionUseCaseProvider);
    final result = await useCase().run();

    result.match(
      (failure) {
        state = const AuthState.unauthenticated();
      },
      (user) {
        if (user == null) {
          state = const AuthState.unauthenticated();
        } else {
          state = AuthState.authenticated(user);
        }
      },
    );
  }

  void setAuthenticated(CurrentUser user) {
    state = AuthState.authenticated(user);
  }

  Future<void> signOut() async {
    final useCase = ref.read(signOutUseCaseProvider);
    final result = await useCase().run();

    result.match(
      (failure) {
        state = const AuthState.unauthenticated();
      },
      (_) {
        state = const AuthState.unauthenticated();
      },
    );
  }
}
