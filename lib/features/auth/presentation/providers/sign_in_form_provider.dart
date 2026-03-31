import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_provider.freezed.dart';

final _nonDigitRegExp = RegExp(r'\D');

String normalizeBusinessNumber(String value) {
  final digits = value.replaceAll(_nonDigitRegExp, '');
  if (digits.length <= 10) {
    return digits;
  }

  return digits.substring(0, 10);
}

String formatBusinessNumber(String value) {
  final digits = normalizeBusinessNumber(value);
  if (digits.length <= 3) {
    return digits;
  }

  if (digits.length <= 5) {
    return '${digits.substring(0, 3)}-${digits.substring(3)}';
  }

  return '${digits.substring(0, 3)}-${digits.substring(3, 5)}-${digits.substring(5)}';
}

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
