import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

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

  FormFieldState<String> businessNumberFieldState(WidgetTester tester) =>
      tester.state<FormFieldState<String>>(find.byType(TextFormField).at(0));

  FormFieldState<String> passwordFieldState(WidgetTester tester) =>
      tester.state<FormFieldState<String>>(find.byType(TextFormField).at(1));

  void fillForm(
    WidgetTester tester, {
    required String businessNumber,
    required String password,
  }) {
    final container = ProviderScope.containerOf(
      tester.element(find.byType(SignInForm)),
    );

    businessNumberFieldState(tester).didChange(businessNumber);
    passwordFieldState(tester).didChange(password);
    container
        .read(signInFormProvider.notifier)
        .updateBusinessNumber(businessNumber);
    container.read(signInFormProvider.notifier).updatePassword(password);
  }

  setUp(() {
    signInUseCase = MockSignInUseCase();
  });

  Widget buildTestApp() {
    return ProviderScope(
      overrides: [signInUseCaseProvider.overrideWithValue(signInUseCase)],
      child: const MaterialApp(home: Scaffold(body: SignInForm())),
    );
  }

  testWidgets('초기에는 로그인 버튼이 비활성화된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    final button = tester.widget<FilledButton>(find.byType(FilledButton));

    expect(button.onPressed, isNull);
  });

  testWidgets('로그인 폼을 Form으로 렌더링한다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('사업자번호 10자리와 비밀번호를 입력하면 로그인 버튼이 활성화된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    fillForm(tester, businessNumber: '1234567890', password: '1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));

    expect(button.onPressed, isNotNull);
  });

  testWidgets('사업자번호가 10자리가 아니면 로그인 버튼이 비활성화된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    fillForm(tester, businessNumber: '123456789', password: '1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));

    expect(button.onPressed, isNull);
  });

  testWidgets('비밀번호 표시 아이콘 탭 시 obscureText가 토글된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    EditableText passwordField() => tester.widget<EditableText>(
      find.descendant(
        of: find.byType(TextFormField).at(1),
        matching: find.byType(EditableText),
      ),
    );
    final container = ProviderScope.containerOf(
      tester.element(find.byType(SignInForm)),
    );

    expect(passwordField().obscureText, isTrue);

    container.read(signInFormProvider.notifier).toggleObscurePassword();
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
    fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    button.onPressed?.call();
    await tester.pumpAndSettle();

    verify(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).called(1);
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
    fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    final buttonBeforeTap = tester.widget<FilledButton>(
      find.byType(FilledButton),
    );
    buttonBeforeTap.onPressed?.call();
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
    fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    button.onPressed?.call();
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
    fillForm(tester, businessNumber: '123-45-67890', password: '1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    button.onPressed?.call();
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
