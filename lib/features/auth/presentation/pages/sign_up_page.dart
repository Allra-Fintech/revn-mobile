import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/sign_up_controller.dart';
import 'package:revn/features/auth/application/states/sign_up_controller_state.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';

import '../providers/sign_up_flow_provider.dart';
import '../widgets/sign_up_agreements_step.dart';
import '../widgets/sign_up_credentials_step.dart';
import '../widgets/sign_up_welcome_step.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  String _messageForFailure(AuthFailure failure) {
    return switch (failure) {
      InvalidCredentials() => '입력한 정보를 다시 확인해주세요.',
      Unauthorized() => '인증이 만료되었거나 유효하지 않습니다.',
      CommonAuthFailure(:final failure) => switch (failure) {
        NetworkFailure() => '네트워크 연결을 확인해주세요.',
        StorageFailure() => '기기 저장소 접근에 실패했습니다.',
        ServerFailure(:final message) => message ?? '요청 처리 중 오류가 발생했습니다.',
        UnknownFailure(:final message) => message ?? '알 수 없는 오류가 발생했습니다.',
      },
    };
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _listenToSignUpState(
    SignUpControllerState? previous,
    SignUpControllerState next,
  ) {
    if (previous?.verification.isLoading == true &&
        next.verification.hasError) {
      _showSnackBar(
        _messageForFailure(next.verification.error! as AuthFailure),
      );
    }

    if (previous?.submission.isLoading == true && next.submission.hasError) {
      _showSnackBar(_messageForFailure(next.submission.error! as AuthFailure));
    }

    final signedUpUser = next.signedUpUser;
    if (signedUpUser != null && previous?.signedUpUser != signedUpUser) {
      ref.read(signUpFlowProvider.notifier).setStep(SignUpStep.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(signUpFlowProvider);

    ref.listen(signUpControllerProvider, _listenToSignUpState);

    final stepContent = switch (flow.step) {
      SignUpStep.agreements => const SignUpAgreementsStep(),
      SignUpStep.credentials => const SignUpCredentialsStep(),
      SignUpStep.welcome => const SignUpWelcomeStep(),
    };

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: KeyedSubtree(
                      key: ValueKey(flow.step),
                      child: stepContent,
                    ),
                  ),
                  if (flow.step != SignUpStep.welcome) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('이미 계정이 있으신가요?'),
                        TextButton(
                          onPressed: () => context.go(AuthRoute.signIn.path),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('로그인'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
