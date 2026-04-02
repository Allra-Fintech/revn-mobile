import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/controllers/sign_in_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/usecases/sign_in_usecase.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  late ProviderContainer container;
  late MockSignInUseCase signInUseCase;

  setUp(() {
    signInUseCase = MockSignInUseCase();

    container = ProviderContainer(
      overrides: [signInUseCaseProvider.overrideWithValue(signInUseCase)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('로그인 성공 시 AuthController가 authenticated가 된다', () async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'Sangmin',
    );

    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    await container
        .read(signInControllerProvider.notifier)
        .signIn(businessNumber: '1234567890', password: '1234');

    expect(
      container.read(authControllerProvider),
      const AuthState.authenticated(user),
    );
  });

  test('로그인 실패 시 AsyncError 상태가 된다', () async {
    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.left(const AuthFailure.invalidCredentials()));

    await container
        .read(signInControllerProvider.notifier)
        .signIn(businessNumber: '1234567890', password: '1234');

    final state = container.read(signInControllerProvider);

    expect(state.submission.hasError, true);
    expect(state.submission.error, const AuthFailure.invalidCredentials());
  });

  test('네트워크 오류 시 common failure로 AsyncError 상태가 된다', () async {
    when(
      () => signInUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(
      TaskEither.left(const AuthFailure.common(CommonFailure.network())),
    );

    await container
        .read(signInControllerProvider.notifier)
        .signIn(businessNumber: '1234567890', password: '1234');

    final state = container.read(signInControllerProvider);

    expect(state.submission.hasError, true);
    expect(
      state.submission.error,
      const AuthFailure.common(CommonFailure.network()),
    );
  });

  test('autoDispose 이후 비동기 로그인 완료가 auth 상태를 덮어쓰지 않는다', () async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'Sangmin',
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

    final subscription = container.listen(signInControllerProvider, (_, _) {});
    final future = container
        .read(signInControllerProvider.notifier)
        .signIn(businessNumber: '1234567890', password: '1234');

    subscription.close();
    await container.pump();

    completer.complete(user);
    await expectLater(future, completes);

    expect(container.read(authControllerProvider), const AuthState.initial());
  });
}
