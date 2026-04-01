import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:revn/features/auth/presentation/routes/auth_routes.dart';

import '../../application/controllers/sign_in_controller.dart';
import '../../application/controllers/social_auth_controller.dart';
import '../../domain/entities/pending_social_link.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/failures/auth_failure.dart';
import '../utils/auth_failure_message.dart';
import '../widgets/social_link_notice_card.dart';
import '../widgets/sign_in_form.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key, this.initialBusinessNumber});

  final String? initialBusinessNumber;

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _listenToSocialAuth(AsyncValue<void>? previous, AsyncValue<void> next) {
    if (previous?.isLoading == true && next.hasError) {
      _showSnackBar(authFailureMessage(next.error! as AuthFailure));
      ref.read(socialAuthControllerProvider.notifier).resetSocialSignInError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInControllerProvider);
    final socialAuthState = ref.watch(socialAuthControllerProvider);
    final pendingLink = socialAuthState.pendingLink;
    final shouldShowLinkFailureActions =
        pendingLink?.linkStatus == SocialLinkStatus.failed &&
        signInState.signedInUser != null;

    ref.listen(
      socialAuthControllerProvider.select((state) => state.socialSignIn),
      _listenToSocialAuth,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SignInForm(
                    initialBusinessNumber: widget.initialBusinessNumber,
                  ),
                  if (pendingLink != null) ...[
                    SocialLinkNoticeCard(
                      title: shouldShowLinkFailureActions
                          ? '${pendingLink.provider.displayName} 연동을 완료하지 못했습니다'
                          : '${pendingLink.provider.displayName} 로그인은 완료되었습니다',
                      description: shouldShowLinkFailureActions
                          ? pendingLink.lastErrorMessage ??
                                '${pendingLink.provider.displayName} 계정 연동에 실패했습니다.'
                          : '${pendingLink.provider.displayName} 토큰은 이미 확보되었습니다.\n'
                                '사업자번호로 로그인하면 계정이 자동으로 연동됩니다.',
                      primaryActionLabel: shouldShowLinkFailureActions
                          ? '다시 시도'
                          : null,
                      onPrimaryAction: shouldShowLinkFailureActions
                          ? ref
                                .read(signInControllerProvider.notifier)
                                .retryPendingSocialLink
                          : null,
                      secondaryActionLabel: shouldShowLinkFailureActions
                          ? '나중에'
                          : '취소',
                      onSecondaryAction: shouldShowLinkFailureActions
                          ? ref
                                .read(signInControllerProvider.notifier)
                                .completeSignInWithoutSocialLink
                          : ref
                                .read(socialAuthControllerProvider.notifier)
                                .clearPendingLink,
                      onDismiss: shouldShowLinkFailureActions
                          ? ref
                                .read(signInControllerProvider.notifier)
                                .completeSignInWithoutSocialLink
                          : ref
                                .read(socialAuthControllerProvider.notifier)
                                .clearPendingLink,
                    ),
                    const SizedBox(height: 24),
                  ],

                  if (pendingLink == null) ...[
                    const SizedBox(height: 16),
                    FilledButton.tonalIcon(
                      onPressed:
                          signInState.submission.isLoading ||
                              socialAuthState.socialSignIn.isLoading
                          ? null
                          : () => ref
                                .read(socialAuthControllerProvider.notifier)
                                .signInWithProvider(SocialProvider.kakao),
                      icon: socialAuthState.socialSignIn.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.chat_bubble_rounded),
                      label: const Text('카카오 로그인'),
                    ),
                    const SizedBox(height: 16),
                  ] else
                    const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('아직 계정이 없으신가요?'),
                      TextButton(
                        onPressed: () => context.go(AuthRoute.signUp.path),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text('회원가입'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
