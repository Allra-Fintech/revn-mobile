import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/utils/auth_failure_message.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_requested) return;
    _requested = true;

    Future.microtask(() {
      ref.read(authControllerProvider.notifier).restoreSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = ref
        .watch(authControllerProvider)
        .when(
          initial: () => const CircularProgressIndicator(),
          loading: () => const CircularProgressIndicator(),
          restoreFailed: (failure) => _RestoreFailedView(
            failure: failure,
            onRetry: () =>
                ref.read(authControllerProvider.notifier).restoreSession(),
          ),
          authenticated: (_) => const CircularProgressIndicator(),
          unauthenticated: (_) => const CircularProgressIndicator(),
        );

    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.all(24), child: body),
      ),
    );
  }
}

class _RestoreFailedView extends StatelessWidget {
  const _RestoreFailedView({required this.failure, required this.onRetry});

  final AuthFailure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '세션을 복구하지 못했습니다.',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          authFailureMessage(failure),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        FilledButton(onPressed: onRetry, child: const Text('다시 시도')),
      ],
    );
  }
}
