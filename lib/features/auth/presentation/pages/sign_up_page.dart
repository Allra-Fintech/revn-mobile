import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/features/auth/application/controllers/social_auth_controller.dart';
import 'package:revn/features/auth/application/controllers/sign_up_controller.dart';
import 'package:revn/features/auth/application/states/sign_up_controller_state.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';

import '../providers/sign_up_flow_provider.dart';
import '../utils/auth_failure_message.dart';
import '../widgets/sign_up_agreements_step.dart';
import '../widgets/sign_up_credentials_step.dart';
import '../widgets/sign_up_welcome_step.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showDuplicateBusinessNumberDialog(String businessNumber) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('이미 가입된 사업자번호'),
          content: const Text('입력하신 사업자번호는 이미 등록되어 있습니다.\n로그인 화면으로 이동하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.go(
                  Uri(
                    path: AuthRoute.signIn.path,
                    queryParameters: <String, String>{
                      AuthRoutes.signInBusinessNumberQueryParameter:
                          businessNumber,
                    },
                  ).toString(),
                );
              },
              child: const Text('이동'),
            ),
          ],
        );
      },
    );
  }

  void _listenToSignUpState(
    SignUpControllerState? previous,
    SignUpControllerState next,
  ) {
    if (previous?.verification.isLoading == true &&
        next.verification.hasError) {
      final failure = next.verification.error! as AuthFailure;

      if (failure is DuplicateBusinessNumber) {
        _showDuplicateBusinessNumberDialog(
          ref.read(signUpFlowProvider).businessNumber,
        );
      } else {
        _showSnackBar(authFailureMessage(failure));
      }
    }

    if (previous?.submission.isLoading == true && next.submission.hasError) {
      _showSnackBar(authFailureMessage(next.submission.error! as AuthFailure));
    }

    final signedUpUser = next.signedUpUser;
    if (signedUpUser != null && previous?.signedUpUser != signedUpUser) {
      unawaited(_handleSignedUpUser(signedUpUser));
    }
  }

  Future<bool?> _showSocialLinkDialog(String providerDisplayName) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('$providerDisplayName 계정 연동'),
          content: Text(
            '최근 로그인한 $providerDisplayName 계정을 가입과 연동할 수 있습니다. 다음 로그인 시 $providerDisplayName로 간편하게 로그인할 수 있어요.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('나중에'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('연동'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignedUpUser(CurrentUser user) async {
    final pendingLink = ref.read(socialAuthControllerProvider).pendingLink;
    if (pendingLink == null) {
      ref.read(signUpFlowProvider.notifier).setStep(SignUpStep.welcome);
      return;
    }

    final shouldLinkNow = await _showSocialLinkDialog(
      pendingLink.provider.displayName,
    );
    if (!mounted) {
      return;
    }

    if (shouldLinkNow != true) {
      ref.read(signUpFlowProvider.notifier).setStep(SignUpStep.welcome);
      return;
    }

    final linked = await ref
        .read(socialAuthControllerProvider.notifier)
        .completePendingLink(user);
    if (!mounted) {
      return;
    }

    if (!linked) {
      final latestPendingLink = ref
          .read(socialAuthControllerProvider)
          .pendingLink;
      _showSnackBar(
        latestPendingLink?.lastErrorMessage ??
            '${pendingLink.provider.displayName} 계정 연동에 실패했습니다.',
      );
    }

    ref.read(signUpFlowProvider.notifier).setStep(SignUpStep.welcome);
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(signUpFlowProvider);
    ref.watch(signUpControllerProvider);

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
