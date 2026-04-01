import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/controllers/auth_controller.dart';
import '../../application/controllers/sign_up_controller.dart';

class SignUpWelcomeStep extends ConsumerWidget {
  const SignUpWelcomeStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedUpUser = ref.watch(signUpControllerProvider).signedUpUser;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_rounded, size: 72, color: colorScheme.primary),
        const SizedBox(height: 20),
        Text(
          '가입을 환영합니다',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: signedUpUser == null
                ? null
                : () => ref
                      .read(authControllerProvider.notifier)
                      .setAuthenticated(signedUpUser),
            child: const Text('시작하기'),
          ),
        ),
      ],
    );
  }
}
