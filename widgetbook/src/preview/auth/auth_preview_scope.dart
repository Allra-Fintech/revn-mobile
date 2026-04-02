import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/controllers/sign_in_controller.dart';
import 'package:revn/features/auth/application/controllers/sign_up_controller.dart';
import 'package:revn/features/auth/application/controllers/social_auth_controller.dart';
import 'package:revn/features/auth/presentation/providers/sign_up_flow_provider.dart';

import 'auth_preview_config.dart';
import 'auth_preview_controllers.dart';

class AuthPreviewScope extends StatelessWidget {
  const AuthPreviewScope({
    super.key,
    required this.config,
    required this.child,
  });

  final AuthPreviewConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(
          () => PreviewAuthController(initialState: config.authState),
        ),
        signInControllerProvider.overrideWith(
          () => PreviewSignInController(
            initialState: config.signInState,
            previewUser: config.previewUser,
          ),
        ),
        socialAuthControllerProvider.overrideWith(
          () =>
              PreviewSocialAuthController(initialState: config.socialAuthState),
        ),
        signUpControllerProvider.overrideWith(
          () => PreviewSignUpController(
            initialState: config.signUpState,
            previewUser: config.previewUser,
          ),
        ),
        signUpFlowProvider.overrideWith(
          () => PreviewSignUpFlowNotifier(initialState: config.signUpFlowState),
        ),
      ],
      child: child,
    );
  }
}
