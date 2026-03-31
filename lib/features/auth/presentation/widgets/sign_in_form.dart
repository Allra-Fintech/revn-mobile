import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/controllers/sign_in_controller.dart';
import '../../domain/failures/auth_failure.dart';
import '../providers/sign_in_form_provider.dart';

class SignInForm extends ConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signInFormProvider);
    final canSubmit = ref.watch(signInCanSubmitProvider);
    final signInState = ref.watch(signInControllerProvider);

    ref.listen(signInControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final message = switch (error) {
            InvalidCredentials() => '이메일 또는 비밀번호를 확인해주세요.',
            Unauthorized() => '인증이 만료되었거나 유효하지 않습니다.',
            Network() => '네트워크 연결을 확인해주세요.',
            Storage() => '기기 저장소 접근에 실패했습니다.',
            Server(:final message) => message ?? '서버 오류가 발생했습니다.',
            Unknown(:final message) => message ?? '알 수 없는 오류가 발생했습니다.',
            _ => '로그인에 실패했습니다.',
          };

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );
    });

    final isLoading = signInState.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          enabled: !isLoading,
          onChanged: ref.read(signInFormProvider.notifier).updateEmail,
          decoration: const InputDecoration(
            labelText: '이메일',
            hintText: 'example@email.com',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: form.obscurePassword,
          enabled: !isLoading,
          onChanged: ref.read(signInFormProvider.notifier).updatePassword,
          decoration: InputDecoration(
            labelText: '비밀번호',
            suffixIcon: IconButton(
              onPressed: isLoading
                  ? null
                  : ref.read(signInFormProvider.notifier).toggleObscurePassword,
              icon: Icon(
                form.obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: (!canSubmit || isLoading)
              ? null
              : () async {
                  await ref
                      .read(signInControllerProvider.notifier)
                      .signIn(
                        email: form.email.trim(),
                        password: form.password,
                      );
                },
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
