import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/states/sign_in_controller_state.dart';
import 'package:revn/features/auth/application/states/sign_up_controller_state.dart';
import 'package:revn/features/auth/application/states/social_auth_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/presentation/providers/sign_up_flow_provider.dart';

const authPreviewBusinessNumber = '1234567890';

const authPreviewUser = CurrentUser(
  id: 'widgetbook-user',
  businessNumber: authPreviewBusinessNumber,
  username: 'Widgetbook Preview',
);

class AuthPreviewConfig {
  const AuthPreviewConfig({
    this.authState = const AuthState.unauthenticated(),
    this.signInState = const SignInControllerState(),
    this.socialAuthState = const SocialAuthState(),
    this.signUpState = const SignUpControllerState(),
    this.signUpFlowState = const SignUpFlowState(),
    this.previewUser = authPreviewUser,
  });

  final AuthState authState;
  final SignInControllerState signInState;
  final SocialAuthState socialAuthState;
  final SignUpControllerState signUpState;
  final SignUpFlowState signUpFlowState;
  final CurrentUser previewUser;
}
