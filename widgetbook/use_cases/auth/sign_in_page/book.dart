import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:revn/features/auth/presentation/pages/sign_in_page.dart';

import '../../../src/preview/auth/auth_preview_scope.dart';
import 'scenarios.dart';

@widgetbook.UseCase(name: '기본', type: SignInPage, path: '[Pages]/Auth')
Widget signInPageBasicUseCase(BuildContext context) {
  return const AuthPreviewScope(
    config: signInPageBasicConfig,
    child: SignInPage(),
  );
}

@widgetbook.UseCase(name: '소셜 미연동 안내', type: SignInPage, path: '[Pages]/Auth')
Widget signInPageSocialNotLinkedUseCase(BuildContext context) {
  return const AuthPreviewScope(
    config: signInPageSocialNotLinkedConfig,
    child: SignInPage(),
  );
}
