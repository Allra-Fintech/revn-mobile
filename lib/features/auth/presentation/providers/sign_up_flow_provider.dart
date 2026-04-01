import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/business_number_text_input_formatter.dart';

part 'sign_up_flow_provider.freezed.dart';

enum SignUpStep { agreements, credentials, welcome }

@freezed
sealed class SignUpFlowState with _$SignUpFlowState {
  const factory SignUpFlowState({
    @Default(SignUpStep.agreements) SignUpStep step,
    @Default(false) bool serviceTermsAgreed,
    @Default(false) bool privacyCollectionAgreed,
    @Default(false) bool privacySharingAgreed,
    @Default(false) bool marketingAgreed,
    @Default('') String businessNumber,
    String? verifiedBusinessNumber,
    @Default('') String password,
    @Default('') String passwordConfirmation,
    @Default(true) bool obscurePassword,
    @Default(true) bool obscurePasswordConfirmation,
  }) = _SignUpFlowState;
}

extension SignUpFlowStateX on SignUpFlowState {
  bool get areRequiredAgreementsAccepted =>
      serviceTermsAgreed && privacyCollectionAgreed && privacySharingAgreed;

  bool get isAllAgreed => areRequiredAgreementsAccepted && marketingAgreed;

  bool get isBusinessNumberVerified =>
      businessNumber.isNotEmpty && businessNumber == verifiedBusinessNumber;
}

final signUpFlowProvider =
    NotifierProvider.autoDispose<SignUpFlowNotifier, SignUpFlowState>(
      SignUpFlowNotifier.new,
    );

class SignUpFlowNotifier extends Notifier<SignUpFlowState> {
  @override
  SignUpFlowState build() {
    return const SignUpFlowState();
  }

  void reset() {
    state = const SignUpFlowState();
  }

  void setStep(SignUpStep step) {
    state = state.copyWith(step: step);
  }

  void toggleAllAgreements(bool value) {
    state = state.copyWith(
      serviceTermsAgreed: value,
      privacyCollectionAgreed: value,
      privacySharingAgreed: value,
      marketingAgreed: value,
    );
  }

  void updateServiceTermsAgreement(bool value) {
    state = state.copyWith(serviceTermsAgreed: value);
  }

  void updatePrivacyCollectionAgreement(bool value) {
    state = state.copyWith(privacyCollectionAgreed: value);
  }

  void updatePrivacySharingAgreement(bool value) {
    state = state.copyWith(privacySharingAgreed: value);
  }

  void updateMarketingAgreement(bool value) {
    state = state.copyWith(marketingAgreed: value);
  }

  void updateBusinessNumber(String businessNumber) {
    final normalizedBusinessNumber = normalizeBusinessNumber(businessNumber);
    final shouldResetVerification =
        normalizedBusinessNumber != state.verifiedBusinessNumber;

    state = state.copyWith(
      businessNumber: normalizedBusinessNumber,
      verifiedBusinessNumber: shouldResetVerification
          ? null
          : state.verifiedBusinessNumber,
    );
  }

  void markBusinessNumberVerified() {
    state = state.copyWith(verifiedBusinessNumber: state.businessNumber);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updatePasswordConfirmation(String passwordConfirmation) {
    state = state.copyWith(passwordConfirmation: passwordConfirmation);
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleObscurePasswordConfirmation() {
    state = state.copyWith(
      obscurePasswordConfirmation: !state.obscurePasswordConfirmation,
    );
  }
}
