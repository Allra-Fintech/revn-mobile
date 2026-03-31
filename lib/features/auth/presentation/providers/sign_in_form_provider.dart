import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_provider.freezed.dart';

@freezed
sealed class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @Default('') String email,
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

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }
}

final signInCanSubmitProvider = Provider<bool>((ref) {
  final form = ref.watch(signInFormProvider);

  return form.email.trim().isNotEmpty && form.password.trim().isNotEmpty;
});
