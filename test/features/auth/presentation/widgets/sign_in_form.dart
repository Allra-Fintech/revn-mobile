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

  testWidgets('이메일과 비밀번호를 입력하면 로그인 버튼이 활성화된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    final emailField = tester.widget<TextField>(find.byType(TextField).at(0));
    final passwordField = tester.widget<TextField>(find.byType(TextField).at(1));

    emailField.onChanged?.call('test@test.com');
    passwordField.onChanged?.call('1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));

    expect(button.onPressed, isNotNull);
  });

  testWidgets('비밀번호 표시 아이콘 탭 시 obscureText가 토글된다', (tester) async {
    await tester.pumpWidget(buildTestApp());

    TextField passwordField() => tester.widget<TextField>(find.byType(TextField).at(1));
    final container = ProviderScope.containerOf(
      tester.element(find.byType(SignInForm)),
    );

    expect(passwordField().obscureText, isTrue);

    container.read(signInFormProvider.notifier).toggleObscurePassword();
    await tester.pump();

    expect(passwordField().obscureText, isFalse);
  });

  testWidgets('로그인 버튼 탭 시 trim된 이메일과 비밀번호로 로그인 요청한다', (tester) async {
    const user = CurrentUser(
      id: '1',
      email: 'test@test.com',
      nickname: 'tester',
      profileImageUrl: null,
    );
    when(
      () => signInUseCase(email: 'test@test.com', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await tester.pumpWidget(buildTestApp());
    final emailField = tester.widget<TextField>(find.byType(TextField).at(0));
    final passwordField = tester.widget<TextField>(find.byType(TextField).at(1));

    emailField.onChanged?.call('  test@test.com  ');
    passwordField.onChanged?.call('1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    button.onPressed?.call();
    await tester.pumpAndSettle();

    verify(() => signInUseCase(email: 'test@test.com', password: '1234')).called(1);
  });

  testWidgets('로그인 실패 시 에러 스낵바를 보여준다', (tester) async {
    when(
      () => signInUseCase(email: 'test@test.com', password: '1234'),
    ).thenReturn(TaskEither.left(const AuthFailure.invalidCredentials()));

    await tester.pumpWidget(buildTestApp());
    final emailField = tester.widget<TextField>(find.byType(TextField).at(0));
    final passwordField = tester.widget<TextField>(find.byType(TextField).at(1));

    emailField.onChanged?.call('test@test.com');
    passwordField.onChanged?.call('1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    button.onPressed?.call();
    await tester.pumpAndSettle();

    expect(find.text('이메일 또는 비밀번호를 확인해주세요.'), findsOneWidget);
  });

  testWidgets('네트워크 오류 시 네트워크 오류 스낵바를 보여준다', (tester) async {
    when(
      () => signInUseCase(email: 'test@test.com', password: '1234'),
    ).thenReturn(TaskEither.left(
      const AuthFailure.common(CommonFailure.network()),
    ));

    await tester.pumpWidget(buildTestApp());
    final emailField = tester.widget<TextField>(find.byType(TextField).at(0));
    final passwordField = tester.widget<TextField>(find.byType(TextField).at(1));

    emailField.onChanged?.call('test@test.com');
    passwordField.onChanged?.call('1234');
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    button.onPressed?.call();
    await tester.pumpAndSettle();

    expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
  });
}
