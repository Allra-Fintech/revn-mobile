import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/usecases/sign_in_usecase.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/providers/sign_in_form_provider.dart';
import 'package:revn/features/auth/presentation/widgets/sign_in_form.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  late MockSignInUseCase signInUseCase;

  ProviderContainer containerOf(WidgetTester tester) {
    return ProviderScope.containerOf(tester.element(find.byType(SignInForm)));
  }

  String? textFieldValue(WidgetTester tester, int index) {
    return tester
        .widget<TextFormField>(find.byType(TextFormField).at(index))
        .controller
        ?.text;
  }

  Future<void> fillForm(
    WidgetTester tester, {
    required String businessNumber,
    required String password,
  }) async {
    await tester.enterText(find.byType(TextFormField).at(0), businessNumber);
    await tester.enterText(find.byType(TextFormField).at(1), password);
  }

  setUp(() {
    signInUseCase = MockSignInUseCase();
  });

  Widget buildTestApp({String? initialBusinessNumber}) {
    return ProviderScope(
      overrides: [signInUseCaseProvider.overrideWithValue(signInUseCase)],
      child: MaterialApp(
        home: Scaffold(
          body: SignInForm(initialBusinessNumber: initialBusinessNumber),
        ),
      ),
    );
  }

  Future<void> tapSubmitButton(WidgetTester tester) async {
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
  }

  testWidgets('초기에는 로그인 버튼이 활성화되고 에러를 보여주지 않는다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    final button = tester.widget<FilledButton>(find.byType(FilledButton));

    expect(button.onPressed, isNotNull);
    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsNothing);
    expect(find.text('비밀번호를 입력해주세요.'), findsNothing);
  });

  testWidgets('초기 사업자번호가 있으면 사업자번호만 채우고 비밀번호는 비운다', (tester) async {
    await tester.pumpWidget(buildTestApp(initialBusinessNumber: '1234567890'));
    await tester.pump();

    expect(textFieldValue(tester, 0), '123-45-67890');
    expect(textFieldValue(tester, 1), isEmpty);
    expect(
      containerOf(tester).read(signInFormProvider).businessNumber,
      '1234567890',
    );
    expect(containerOf(tester).read(signInFormProvider).password, isEmpty);
  });

  testWidgets('로그인 폼을 Form으로 렌더링한다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('빈 값으로 submit하면 validator 에러를 보여주고 로그인 요청하지 않는다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    await tapSubmitButton(tester);

    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsOneWidget);
    expect(find.text('비밀번호를 입력해주세요.'), findsOneWidget);
    verifyZeroInteractions(signInUseCase);
  });

  testWidgets('첫 submit 실패 이후 입력을 수정하면 에러가 즉시 갱신된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    await fillForm(tester, businessNumber: '123456789', password: '1234');
    await tester.pump();

    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsNothing);

    await tapSubmitButton(tester);

    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsOneWidget);

    await fillForm(tester, businessNumber: '1234567890', password: '1234');
    await tester.pump();

    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsNothing);
  });

  testWidgets('비밀번호 표시 아이콘 탭 시 obscureText가 토글된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    EditableText passwordField() => tester.widget<EditableText>(
      find.descendant(
        of: find.byType(TextFormField).at(1),
        matching: find.byType(EditableText),
      ),
    );
    final visibilityToggle = find.descendant(
      of: find.byType(TextFormField).at(1),
      matching: find.byType(IconButton),
    );

    expect(passwordField().obscureText, isTrue);

    await tester.tap(visibilityToggle);
    await tester.pump();

    expect(passwordField().obscureText, isFalse);
  });

  testWidgets('로그인 버튼 탭 시 정규화된 사업자번호와 비밀번호로 로그인 요청한다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'tester',
    );
    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await tester.pumpWidget(buildTestApp());
    await fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    verify(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).called(1);
  });

  testWidgets('초기 사업자번호가 있으면 비밀번호만 입력해 정규화된 번호로 로그인 요청한다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'tester',
    );
    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await tester.pumpWidget(
      buildTestApp(initialBusinessNumber: '123-45-67890'),
    );
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.pump();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    verify(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).called(1);
  });

  testWidgets('초기 사업자번호가 있어도 비밀번호가 비어 있으면 비밀번호 validator를 보여준다', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestApp(initialBusinessNumber: '1234567890'));
    await tester.pump();

    await tapSubmitButton(tester);

    expect(find.text('사업자번호 10자리를 입력해주세요.'), findsNothing);
    expect(find.text('비밀번호를 입력해주세요.'), findsOneWidget);
    verifyZeroInteractions(signInUseCase);
  });

  testWidgets('로그인 진행 중에는 버튼이 비활성화되고 로더가 보인다', (tester) async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'tester',
    );
    final completer = Completer<CurrentUser>();

    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(
      TaskEither<AuthFailure, CurrentUser>.tryCatch(
        () => completer.future,
        (error, stackTrace) => const AuthFailure.invalidCredentials(),
      ),
    );

    await tester.pumpWidget(buildTestApp());
    await fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    final buttonDuringLoading = tester.widget<FilledButton>(
      find.byType(FilledButton),
    );
    expect(buttonDuringLoading.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(user);
    await tester.pumpAndSettle();
  });

  testWidgets('로그인 실패 시 사업자번호 기준 에러 스낵바를 보여준다', (tester) async {
    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.left(const AuthFailure.invalidCredentials()));

    await tester.pumpWidget(buildTestApp());
    await fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('사업자번호 또는 비밀번호를 확인해주세요.'), findsOneWidget);
  });

  testWidgets('네트워크 오류 시 네트워크 오류 스낵바를 보여준다', (tester) async {
    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(
      TaskEither.left(const AuthFailure.common(CommonFailure.network())),
    );

    await tester.pumpWidget(buildTestApp());
    await fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
  });

  testWidgets('사업자번호 필드에 validator가 연결되어 있다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    final businessNumberField = tester.widget<TextFormField>(
      find.byType(TextFormField).at(0),
    );

    expect(
      businessNumberField.validator?.call('123456789'),
      '사업자번호 10자리를 입력해주세요.',
    );
  });
}
