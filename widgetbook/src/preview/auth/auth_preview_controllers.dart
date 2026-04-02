import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/controllers/sign_in_controller.dart';
import 'package:revn/features/auth/application/controllers/sign_up_controller.dart';
import 'package:revn/features/auth/application/controllers/social_auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/states/sign_in_controller_state.dart';
import 'package:revn/features/auth/application/states/sign_up_controller_state.dart';
import 'package:revn/features/auth/application/states/social_auth_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/entities/pending_social_link.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';
import 'package:revn/features/auth/presentation/providers/sign_up_flow_provider.dart';

class PreviewAuthController extends AuthController {
  PreviewAuthController({required this.initialState});

  final AuthState initialState;

  @override
  AuthState build() => initialState;

  @override
  Future<void> restoreSession() async {
    state = const AuthState.unauthenticated();
  }

  @override
  Future<void> signOut() async {
    state = const AuthState.unauthenticated();
  }
}

class PreviewSignInController extends SignInController {
  PreviewSignInController({
    required this.initialState,
    required this.previewUser,
  });

  final SignInControllerState initialState;
  final CurrentUser previewUser;

  @override
  SignInControllerState build() => initialState;

  @override
  Future<void> signIn({
    required String businessNumber,
    required String password,
  }) async {
    final signedInUser = state.signedInUser ?? previewUser;

    state = state.copyWith(
      submission: const AsyncData<void>(null),
      signedInUser: signedInUser.copyWith(
        businessNumber: businessNumber.isEmpty
            ? signedInUser.businessNumber
            : businessNumber,
      ),
    );

    if (ref.read(socialAuthControllerProvider).pendingLink == null) {
      ref
          .read(authControllerProvider.notifier)
          .setAuthenticated(state.signedInUser!);
    }
  }

  @override
  Future<void> retryPendingSocialLink() async {
    final signedInUser = state.signedInUser ?? previewUser;

    state = state.copyWith(
      submission: const AsyncData<void>(null),
      signedInUser: signedInUser,
    );

    final linked = await ref
        .read(socialAuthControllerProvider.notifier)
        .retryPendingLink(signedInUser);

    if (linked) {
      ref.read(authControllerProvider.notifier).setAuthenticated(signedInUser);
    }
  }

  @override
  void completeSignInWithoutSocialLink() {
    final signedInUser = state.signedInUser ?? previewUser;

    state = state.copyWith(
      submission: const AsyncData<void>(null),
      signedInUser: signedInUser,
    );

    ref.read(socialAuthControllerProvider.notifier).clearPendingLink();
    ref.read(authControllerProvider.notifier).setAuthenticated(signedInUser);
  }
}

class PreviewSocialAuthController extends SocialAuthController {
  PreviewSocialAuthController({required this.initialState});

  final SocialAuthState initialState;

  @override
  SocialAuthState build() => initialState;

  @override
  Future<void> signInWithProvider(SocialProvider provider) async {
    state = SocialAuthState(
      socialSignIn: const AsyncData<void>(null),
      pendingLink: PendingSocialLink(
        provider: provider,
        accessToken: 'widgetbook-${provider.id}-token',
      ),
    );
  }

  @override
  Future<bool> completePendingLink(CurrentUser user) async {
    if (state.pendingLink == null) {
      return true;
    }

    state = const SocialAuthState();
    return true;
  }

  @override
  Future<bool> retryPendingLink(CurrentUser user) {
    return completePendingLink(user);
  }

  @override
  void clearPendingLink() {
    state = state.copyWith(pendingLink: null);
  }

  @override
  void resetSocialSignInError() {
    state = state.copyWith(socialSignIn: const AsyncData<void>(null));
  }
}

class PreviewSignUpController extends SignUpController {
  PreviewSignUpController({
    required this.initialState,
    required this.previewUser,
  });

  final SignUpControllerState initialState;
  final CurrentUser previewUser;

  @override
  SignUpControllerState build() => initialState;

  @override
  void reset() {
    state = const SignUpControllerState();
  }

  @override
  void resetVerification() {
    state = state.copyWith(verification: const AsyncData<void>(null));
  }

  @override
  Future<bool> verifyBusinessNumber({required String businessNumber}) async {
    state = state.copyWith(verification: const AsyncData<void>(null));
    return true;
  }

  @override
  Future<CurrentUser?> signUp({
    required String businessNumber,
    required String password,
  }) async {
    final signedUpUser = (state.signedUpUser ?? previewUser).copyWith(
      businessNumber: businessNumber,
    );

    state = state.copyWith(
      verification: const AsyncData<void>(null),
      submission: const AsyncData<void>(null),
      signedUpUser: signedUpUser,
    );

    return signedUpUser;
  }
}

class PreviewSignUpFlowNotifier extends SignUpFlowNotifier {
  PreviewSignUpFlowNotifier({required this.initialState});

  final SignUpFlowState initialState;

  @override
  SignUpFlowState build() => initialState;
}
