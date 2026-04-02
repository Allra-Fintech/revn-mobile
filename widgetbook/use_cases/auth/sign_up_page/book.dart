import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:revn/features/auth/presentation/pages/sign_up_page.dart';

import '../../../src/preview/auth/auth_preview_scope.dart';
import 'scenarios.dart';

@widgetbook.UseCase(name: '약관', type: SignUpPage, path: '[Pages]/Auth')
Widget signUpPageAgreementsUseCase(BuildContext context) {
  return const AuthPreviewScope(
    config: signUpPageAgreementsConfig,
    child: SignUpPage(),
  );
}

@widgetbook.UseCase(name: '인증정보 입력', type: SignUpPage, path: '[Pages]/Auth')
Widget signUpPageCredentialsUseCase(BuildContext context) {
  return const AuthPreviewScope(
    config: signUpPageCredentialsConfig,
    child: SignUpPage(),
  );
}

@widgetbook.UseCase(name: '가입 완료', type: SignUpPage, path: '[Pages]/Auth')
Widget signUpPageWelcomeUseCase(BuildContext context) {
  return const AuthPreviewScope(
    config: signUpPageWelcomeConfig,
    child: SignUpPage(),
  );
}
