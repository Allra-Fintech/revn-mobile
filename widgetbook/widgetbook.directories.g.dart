// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

import 'use_cases/auth/sign_in_page/book.dart'
    as _asset_revn_widgetbook_use_cases_auth_sign_in_page_book;
import 'use_cases/auth/sign_up_page/book.dart'
    as _asset_revn_widgetbook_use_cases_auth_sign_up_page_book;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Pages',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'Auth',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'SignInPage',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: '기본',
                builder: _asset_revn_widgetbook_use_cases_auth_sign_in_page_book
                    .signInPageBasicUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '소셜 미연동 안내',
                builder: _asset_revn_widgetbook_use_cases_auth_sign_in_page_book
                    .signInPageSocialNotLinkedUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'SignUpPage',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: '가입 완료',
                builder: _asset_revn_widgetbook_use_cases_auth_sign_up_page_book
                    .signUpPageWelcomeUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '약관',
                builder: _asset_revn_widgetbook_use_cases_auth_sign_up_page_book
                    .signUpPageAgreementsUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '인증정보 입력',
                builder: _asset_revn_widgetbook_use_cases_auth_sign_up_page_book
                    .signUpPageCredentialsUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
