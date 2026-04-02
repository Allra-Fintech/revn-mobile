import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import '../states/auth_state.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/failures/auth_failure.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  static const _restoreRetryDelay = Duration(milliseconds: 500);

  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> restoreSession() async {
    state = const AuthState.loading();

    final firstResult = await ref.read(restoreSessionUseCaseProvider)().run();
    await firstResult.match(_handleRestoreFailure, _handleRestoreSuccess);
  }

  void setAuthenticated(CurrentUser user) {
    state = AuthState.authenticated(user);
  }

  void clearUnauthenticatedNotice() {
    state.maybeWhen(
      unauthenticated: (notice) {
        if (notice != null) {
          state = const AuthState.unauthenticated();
        }
      },
      orElse: () {},
    );
  }

  Future<void> signOut() async {
    final useCase = ref.read(signOutUseCaseProvider);
    final result = await useCase().run();

    result.match(
      (failure) {
        state = AuthState.unauthenticated(notice: failure);
      },
      (_) {
        state = const AuthState.unauthenticated();
      },
    );
  }

  Future<void> _handleRestoreFailure(AuthFailure failure) async {
    if (failure is Unauthorized) {
      await _clearStoredSessionBestEffort();
      state = const AuthState.unauthenticated();
      return;
    }

    await Future<void>.delayed(_restoreRetryDelay);

    final retriedResult = await ref.read(restoreSessionUseCaseProvider)().run();
    await retriedResult.match((retryFailure) async {
      if (retryFailure is Unauthorized) {
        await _clearStoredSessionBestEffort();
        state = const AuthState.unauthenticated();
        return;
      }

      state = AuthState.restoreFailed(retryFailure);
    }, _handleRestoreSuccess);
  }

  Future<void> _handleRestoreSuccess(CurrentUser? user) async {
    if (user == null) {
      state = const AuthState.unauthenticated();
      return;
    }

    state = AuthState.authenticated(user);
  }

  Future<void> _clearStoredSessionBestEffort() async {
    try {
      await ref.read(authLocalDataSourceProvider).clearTokens();
    } catch (_) {
      // Ignore cleanup failures here because unauthorized recovery should
      // still return the user to a clean login flow.
    }
  }
}
