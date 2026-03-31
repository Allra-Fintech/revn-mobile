import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/common_failure.dart';
import '../../application/controllers/sign_in_controller.dart';
import '../../domain/failures/auth_failure.dart';
import '../providers/sign_in_form_provider.dart';

class BusinessNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatBusinessNumber(newValue.text);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;

  String? _validateBusinessNumber(String? value) {
    if (normalizeBusinessNumber(value ?? '').length == 10) {
      return null;
    }

    return '사업자번호 10자리를 입력해주세요.';
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').trim().isNotEmpty) {
      return null;
    }

    return '비밀번호를 입력해주세요.';
  }

  Future<void> _submit(SignInFormState form) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      if (!_showValidationErrors) {
        setState(() {
          _showValidationErrors = true;
        });
      }
      return;
    }

    await ref
        .read(signInControllerProvider.notifier)
        .signIn(businessNumber: form.businessNumber, password: form.password);
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(signInFormProvider);
    final signInState = ref.watch(signInControllerProvider);

    ref.listen(signInControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final message = switch (error) {
            InvalidCredentials() => '사업자번호 또는 비밀번호를 확인해주세요.',
            Unauthorized() => '인증이 만료되었거나 유효하지 않습니다.',
            CommonAuthFailure(:final failure) => switch (failure) {
              NetworkFailure() => '네트워크 연결을 확인해주세요.',
              StorageFailure() => '기기 저장소 접근에 실패했습니다.',
              ServerFailure(:final message) => message ?? '서버 오류가 발생했습니다.',
              UnknownFailure(:final message) => message ?? '알 수 없는 오류가 발생했습니다.',
            },
            _ => '로그인에 실패했습니다.',
          };

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );
    });

    final isLoading = signInState.isLoading;
    final autovalidateMode = _showValidationErrors
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                autovalidateMode: autovalidateMode,
                keyboardType: TextInputType.number,
                enabled: !isLoading,
                inputFormatters: [BusinessNumberTextInputFormatter()],
                onChanged: ref
                    .read(signInFormProvider.notifier)
                    .updateBusinessNumber,
                validator: _validateBusinessNumber,
                decoration: const InputDecoration(
                  labelText: '사업자번호',
                  hintText: '123-45-67890',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: autovalidateMode,
                obscureText: form.obscurePassword,
                enabled: !isLoading,
                onChanged: ref.read(signInFormProvider.notifier).updatePassword,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  suffixIcon: IconButton(
                    onPressed: isLoading
                        ? null
                        : ref
                              .read(signInFormProvider.notifier)
                              .toggleObscurePassword,
                    icon: Icon(
                      form.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: isLoading ? null : () => _submit(form),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('로그인'),
        ),
      ],
    );
  }
}
