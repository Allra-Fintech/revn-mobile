import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/business_number_text_input_formatter.dart';

part 'sign_in_form_provider.freezed.dart';

@freezed
sealed class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @Default('') String businessNumber,
    @Default('') String password,
    @Default(true) bool obscurePassword,
  }) = _SignInFormState;
}

final signInFormProvider =
    NotifierProvider<SignInFormNotifier, SignInFormState>(
      SignInFormNotifier.new,
    );

class SignInFormNotifier extends Notifier<SignInFormState> {
  @override
  SignInFormState build() {
    return const SignInFormState();
  }

  void updateBusinessNumber(String businessNumber) {
    state = state.copyWith(
      businessNumber: normalizeBusinessNumber(businessNumber),
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }
}
