import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/agreement_document.dart';
import '../providers/sign_up_flow_provider.dart';
import '../routes/auth_routes.dart';

class SignUpAgreementsStep extends ConsumerWidget {
  const SignUpAgreementsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(signUpFlowProvider);
    final notifier = ref.read(signUpFlowProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AgreementCheckboxTile(
                  title: '전체 동의',
                  value: flow.isAllAgreed,
                  isRequired: false,
                  onChanged: notifier.toggleAllAgreements,
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(color: colorScheme.outlineVariant),
                const SizedBox(height: 8),
                _AgreementCheckboxTile(
                  title: '서비스 이용약관',
                  value: flow.serviceTermsAgreed,
                  isRequired: true,
                  onChanged: notifier.updateServiceTermsAgreement,
                  onDetailsPressed: () => context.pushNamed(
                    AuthRoute.agreement.name,
                    extra: AgreementDocument.serviceTerms,
                  ),
                ),
                _AgreementCheckboxTile(
                  title: '개인정보 수집 및 이용동의',
                  value: flow.privacyCollectionAgreed,
                  isRequired: true,
                  onChanged: notifier.updatePrivacyCollectionAgreement,
                  onDetailsPressed: () => context.pushNamed(
                    AuthRoute.agreement.name,
                    extra: AgreementDocument.privacyCollection,
                  ),
                ),
                _AgreementCheckboxTile(
                  title: '개인정보 제공 및 위탁동의',
                  value: flow.privacySharingAgreed,
                  isRequired: true,
                  onChanged: notifier.updatePrivacySharingAgreement,
                  onDetailsPressed: () => context.pushNamed(
                    AuthRoute.agreement.name,
                    extra: AgreementDocument.privacySharing,
                  ),
                ),
                _AgreementCheckboxTile(
                  title: '마케팅 활용 및 광고성 정보 수신 동의',
                  value: flow.marketingAgreed,
                  isRequired: false,
                  onChanged: notifier.updateMarketingAgreement,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: flow.areRequiredAgreementsAccepted
                    ? () => notifier.setStep(SignUpStep.credentials)
                    : null,
                child: const Text('다음'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AgreementCheckboxTile extends StatelessWidget {
  const _AgreementCheckboxTile({
    required this.title,
    required this.value,
    required this.isRequired,
    required this.onChanged,
    this.onDetailsPressed,
    this.titleStyle,
  });

  final String title;
  final bool value;
  final bool isRequired;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onDetailsPressed;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onChanged(!value),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (next) => onChanged(next ?? false),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: title,
                  style:
                      titleStyle ??
                      Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  children: [
                    TextSpan(
                      text: isRequired ? ' (필수)' : '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (onDetailsPressed != null)
              IconButton(
                onPressed: onDetailsPressed,
                icon: const Icon(Icons.chevron_right_rounded),
                splashRadius: 20,
                tooltip: '$title 보기',
              ),
          ],
        ),
      ),
    );
  }
}
