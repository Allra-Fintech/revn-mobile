import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/controllers/sign_up_controller.dart';
import '../providers/sign_up_flow_provider.dart';
import '../utils/business_number_text_input_formatter.dart';

class SignUpCredentialsStep extends ConsumerStatefulWidget {
  const SignUpCredentialsStep({super.key});

  @override
  ConsumerState<SignUpCredentialsStep> createState() =>
      _SignUpCredentialsStepState();
}

class _SignUpCredentialsStepState extends ConsumerState<SignUpCredentialsStep> {
  final _formKey = GlobalKey<FormState>();
  final _businessNumberFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController _businessNumberController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmationController;

  bool _showValidationErrors = false;

  @override
  void initState() {
    super.initState();

    final flow = ref.read(signUpFlowProvider);
    _businessNumberController = TextEditingController(
      text: formatBusinessNumber(flow.businessNumber),
    );
    _passwordController = TextEditingController(text: flow.password);
    _passwordConfirmationController = TextEditingController(
      text: flow.passwordConfirmation,
    );
  }

  @override
  void dispose() {
    _businessNumberController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

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

  String? _validatePasswordConfirmation(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return '비밀번호를 다시 입력해주세요.';
    }

    if (value != _passwordController.text) {
      return '비밀번호가 일치하지 않습니다.';
    }

    return null;
  }

  Future<void> _verifyBusinessNumber() async {
    final isBusinessNumberValid =
        _businessNumberFieldKey.currentState?.validate() ?? false;

    if (!isBusinessNumberValid) {
      if (!_showValidationErrors) {
        setState(() {
          _showValidationErrors = true;
        });
      }
      return;
    }

    final flow = ref.read(signUpFlowProvider);
    final isVerified = await ref
        .read(signUpControllerProvider.notifier)
        .verifyBusinessNumber(businessNumber: flow.businessNumber);

    if (isVerified && mounted) {
      ref.read(signUpFlowProvider.notifier).markBusinessNumberVerified();
    }
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      if (!_showValidationErrors) {
        setState(() {
          _showValidationErrors = true;
        });
      }
      return;
    }

    final flow = ref.read(signUpFlowProvider);
    if (!flow.isBusinessNumberVerified) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('사업자번호 인증을 먼저 완료해주세요.')));
      return;
    }

    await ref
        .read(signUpControllerProvider.notifier)
        .signUp(businessNumber: flow.businessNumber, password: flow.password);
  }

  void _syncController(TextEditingController controller, String value) {
    if (controller.text == value) {
      return;
    }

    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(signUpFlowProvider);
    final flowNotifier = ref.read(signUpFlowProvider.notifier);
    final controllerState = ref.watch(signUpControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    _syncController(
      _businessNumberController,
      formatBusinessNumber(flow.businessNumber),
    );
    _syncController(_passwordController, flow.password);
    _syncController(_passwordConfirmationController, flow.passwordConfirmation);

    final isVerifying = controllerState.verification.isLoading;
    final isSubmitting = controllerState.submission.isLoading;
    final isBusy = isVerifying || isSubmitting;
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
                key: _businessNumberFieldKey,
                controller: _businessNumberController,
                autovalidateMode: autovalidateMode,
                keyboardType: TextInputType.number,
                enabled: !isBusy,
                inputFormatters: [BusinessNumberTextInputFormatter()],
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  flowNotifier.updateBusinessNumber(value);
                  ref
                      .read(signUpControllerProvider.notifier)
                      .resetVerification();
                },
                validator: _validateBusinessNumber,
                decoration: const InputDecoration(
                  labelText: '사업자번호',
                  hintText: '123-45-67890',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: isBusy || flow.isBusinessNumberVerified
                    ? null
                    : _verifyBusinessNumber,
                child: isVerifying
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(flow.isBusinessNumberVerified ? '인증 완료' : '인증하기'),
              ),
              const SizedBox(height: 8),
              Text(
                flow.isBusinessNumberVerified
                    ? '사업자번호 인증이 완료되었습니다.'
                    : '가입 전에 사업자번호 인증이 필요합니다.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: flow.isBusinessNumberVerified
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: flow.isBusinessNumberVerified
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                autovalidateMode: autovalidateMode,
                obscureText: flow.obscurePassword,
                enabled: !isBusy,
                textInputAction: TextInputAction.next,
                onChanged: flowNotifier.updatePassword,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  suffixIcon: IconButton(
                    onPressed: isBusy
                        ? null
                        : flowNotifier.toggleObscurePassword,
                    icon: Icon(
                      flow.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordConfirmationController,
                autovalidateMode: autovalidateMode,
                obscureText: flow.obscurePasswordConfirmation,
                enabled: !isBusy,
                textInputAction: TextInputAction.done,
                onChanged: flowNotifier.updatePasswordConfirmation,
                validator: _validatePasswordConfirmation,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  suffixIcon: IconButton(
                    onPressed: isBusy
                        ? null
                        : flowNotifier.toggleObscurePasswordConfirmation,
                    icon: Icon(
                      flow.obscurePasswordConfirmation
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
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: isBusy || !flow.isBusinessNumberVerified
                    ? null
                    : _submit,
                child: isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('가입하기'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
