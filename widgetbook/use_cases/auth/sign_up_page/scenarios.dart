import 'package:revn/features/auth/application/states/sign_up_controller_state.dart';
import 'package:revn/features/auth/presentation/providers/sign_up_flow_provider.dart';

import '../../../src/preview/auth/auth_preview_config.dart';

const signUpPageAgreementsConfig = AuthPreviewConfig();

const signUpPageCredentialsConfig = AuthPreviewConfig(
  signUpFlowState: SignUpFlowState(
    step: SignUpStep.credentials,
    serviceTermsAgreed: true,
    privacyCollectionAgreed: true,
    privacySharingAgreed: true,
    businessNumber: authPreviewBusinessNumber,
    verifiedBusinessNumber: authPreviewBusinessNumber,
    password: 'widgetbook!',
    passwordConfirmation: 'widgetbook!',
  ),
);

const signUpPageWelcomeConfig = AuthPreviewConfig(
  signUpState: SignUpControllerState(signedUpUser: authPreviewUser),
  signUpFlowState: SignUpFlowState(
    step: SignUpStep.welcome,
    serviceTermsAgreed: true,
    privacyCollectionAgreed: true,
    privacySharingAgreed: true,
    businessNumber: authPreviewBusinessNumber,
    verifiedBusinessNumber: authPreviewBusinessNumber,
    password: 'widgetbook!',
    passwordConfirmation: 'widgetbook!',
  ),
);
