import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/common_failure.dart';
import '../../../../core/widgets/revn_text_form_field.dart';
import '../../application/controllers/sign_in_controller.dart';
import '../../domain/failures/auth_failure.dart';
import '../providers/sign_in_form_provider.dart';
import '../utils/business_number_text_input_formatter.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key, this.initialBusinessNumber});

  final String? initialBusinessNumber;

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _businessNumberController;
  late final TextEditingController _passwordController;
  bool _showValidationErrors = false;
  bool _didHydrateInitialForm = false;

  @override
  void initState() {
    super.initState();

    _businessNumberController = TextEditingController(
      text: formatBusinessNumber(widget.initialBusinessNumber ?? ''),
    );
    _passwordController = TextEditingController();

    _scheduleInitialHydration(widget.initialBusinessNumber);
  }

  @override
  void didUpdateWidget(covariant SignInForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialBusinessNumber != widget.initialBusinessNumber) {
      _didHydrateInitialForm = false;
      _syncController(
        _businessNumberController,
        formatBusinessNumber(widget.initialBusinessNumber ?? ''),
      );
      _syncController(_passwordController, '');
      _scheduleInitialHydration(widget.initialBusinessNumber);
    }
  }

  @override
  void dispose() {
    _businessNumberController.dispose();
    _passwordController.dispose();
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

  void _hydrateForm(String? businessNumber) {
    ref
        .read(signInFormProvider.notifier)
        .hydrate(businessNumber: businessNumber ?? '');
  }

  void _scheduleInitialHydration(String? businessNumber) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _hydrateForm(businessNumber);
      setState(() {
        _didHydrateInitialForm = true;
      });
    });
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
    final form = ref.watch(signInFormProvider);
    final signInState = ref.watch(signInControllerProvider);

    if (_didHydrateInitialForm) {
      _syncController(
        _businessNumberController,
        formatBusinessNumber(form.businessNumber),
      );
      _syncController(_passwordController, form.password);
    }

    ref.listen(signInControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final message = switch (error) {
            InvalidCredentials() => '사업자번호 또는 비밀번호를 확인해주세요.',
            Unauthorized() => '인증이 만료되었거나 유효하지 않습니다.',
            DuplicateBusinessNumber() => '이미 가입된 사업자번호입니다.',
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
              RevnTextFormField(
                controller: _businessNumberController,
                autovalidateMode: autovalidateMode,
                keyboardType: TextInputType.number,
                enabled: !isLoading,
                inputFormatters: [BusinessNumberTextInputFormatter()],
                textInputAction: TextInputAction.next,
                onChanged: ref
                    .read(signInFormProvider.notifier)
                    .updateBusinessNumber,
                validator: _validateBusinessNumber,
                labelText: '사업자번호',
                hintText: '123-45-67890',
              ),
              const SizedBox(height: 16),
              RevnTextFormField(
                controller: _passwordController,
                autovalidateMode: autovalidateMode,
                obscureText: form.obscurePassword,
                enabled: !isLoading,
                textInputAction: TextInputAction.done,
                onChanged: ref.read(signInFormProvider.notifier).updatePassword,
                validator: _validatePassword,
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
