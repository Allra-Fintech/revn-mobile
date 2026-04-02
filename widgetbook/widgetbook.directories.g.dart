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
import 'use_cases/dashboard/dashboard_limit_card/book.dart'
    as _asset_revn_widgetbook_use_cases_dashboard_dashboard_limit_card_book;
import 'use_cases/dashboard/dashboard_page/book.dart'
    as _asset_revn_widgetbook_use_cases_dashboard_dashboard_page_book;

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
      _widgetbook.WidgetbookFolder(
        name: 'Dashboard',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'DashboardPage',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: '기본',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_page_book
                        .dashboardPageBasicUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '만료 + 미납',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_page_book
                        .dashboardPageExpiredAndOverdueUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '미납 있음',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_page_book
                        .dashboardPageOverdueUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '세금계산서 만료',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_page_book
                        .dashboardPageExpiredTaxInvoiceUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '한도 없음',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_page_book
                        .dashboardPageZeroLimitUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookCategory(
    name: 'Widgets',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'Dashboard',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'DashboardLimitCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: '30일 경과',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_limit_card_book
                        .dashboardLimitCardExpiredUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '미납',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_limit_card_book
                        .dashboardLimitCardOverdueUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '복합 상태(미납 우선)',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_limit_card_book
                        .dashboardLimitCardCombinedIssueUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '정상',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_limit_card_book
                        .dashboardLimitCardAvailableUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: '한도 없음',
                builder:
                    _asset_revn_widgetbook_use_cases_dashboard_dashboard_limit_card_book
                        .dashboardLimitCardZeroUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
