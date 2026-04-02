import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/usecases/restore_session_usecase.dart';
import 'package:revn/features/auth/application/usecases/sign_out_usecase.dart';
import 'package:revn/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';

class MockRestoreSessionUseCase extends Mock implements RestoreSessionUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  const user = CurrentUser(
    id: '1',
    businessNumber: '1234567890',
    username: 'Sangmin',
  );

  late ProviderContainer container;
  late MockRestoreSessionUseCase restoreSessionUseCase;
  late MockSignOutUseCase signOutUseCase;
  late MockAuthLocalDataSource localDataSource;

  setUp(() {
    restoreSessionUseCase = MockRestoreSessionUseCase();
    signOutUseCase = MockSignOutUseCase();
    localDataSource = MockAuthLocalDataSource();

    container = ProviderContainer(
      overrides: [
        restoreSessionUseCaseProvider.overrideWithValue(restoreSessionUseCase),
        signOutUseCaseProvider.overrideWithValue(signOutUseCase),
        authLocalDataSourceProvider.overrideWithValue(localDataSource),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('restoreSession 성공 시 authenticated 상태가 된다', () async {
    when(() => restoreSessionUseCase()).thenReturn(TaskEither.right(user));

    final notifier = container.read(authControllerProvider.notifier);
    await notifier.restoreSession();

    final state = container.read(authControllerProvider);

    expect(state, const AuthState.authenticated(user));
  });

  test('restoreSession 결과가 null이면 unauthenticated 상태가 된다', () async {
    when(
      () => restoreSessionUseCase(),
    ).thenReturn(TaskEither<AuthFailure, CurrentUser?>.right(null));

    final notifier = container.read(authControllerProvider.notifier);
    await notifier.restoreSession();

    final state = container.read(authControllerProvider);

    expect(state, const AuthState.unauthenticated());
  });

  test('restoreSession unauthorized면 토큰 정리 후 unauthenticated 상태가 된다', () async {
    when(
      () => restoreSessionUseCase(),
    ).thenReturn(TaskEither.left(const AuthFailure.unauthorized()));
    when(() => localDataSource.clearTokens()).thenAnswer((_) async {});

    final notifier = container.read(authControllerProvider.notifier);
    await notifier.restoreSession();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(),
    );
    verify(() => restoreSessionUseCase()).called(1);
    verify(() => localDataSource.clearTokens()).called(1);
  });

  test('restoreSession 일시 실패 후 재시도 성공 시 authenticated 상태가 된다', () async {
    var attempts = 0;

    when(() => restoreSessionUseCase()).thenAnswer((_) {
      attempts += 1;

      return attempts == 1
          ? TaskEither.left(const AuthFailure.common(CommonFailure.network()))
          : TaskEither.right(user);
    });

    final notifier = container.read(authControllerProvider.notifier);
    await notifier.restoreSession();

    expect(
      container.read(authControllerProvider),
      const AuthState.authenticated(user),
    );
    verify(() => restoreSessionUseCase()).called(2);
  });

  test('restoreSession 재시도 후에도 실패하면 restoreFailed 상태가 된다', () async {
    const failure = AuthFailure.common(CommonFailure.network());

    when(() => restoreSessionUseCase()).thenReturn(TaskEither.left(failure));

    final notifier = container.read(authControllerProvider.notifier);
    await notifier.restoreSession();

    expect(
      container.read(authControllerProvider),
      const AuthState.restoreFailed(failure),
    );
    verify(() => restoreSessionUseCase()).called(2);
  });

  test('signOut 성공 후 unauthenticated 상태가 된다', () async {
    when(() => signOutUseCase()).thenReturn(TaskEither.right(unit));

    final notifier = container.read(authControllerProvider.notifier);
    notifier.setAuthenticated(user);

    await notifier.signOut();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(),
    );
  });

  test('signOut 실패 시 notice를 담은 unauthenticated 상태가 된다', () async {
    const failure = AuthFailure.common(CommonFailure.storage());
    when(() => signOutUseCase()).thenReturn(TaskEither.left(failure));

    final notifier = container.read(authControllerProvider.notifier);
    notifier.setAuthenticated(user);

    await notifier.signOut();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(notice: failure),
    );
  });

  test('clearUnauthenticatedNotice는 unauthenticated notice를 소비한다', () async {
    const failure = AuthFailure.common(CommonFailure.storage());
    when(() => signOutUseCase()).thenReturn(TaskEither.left(failure));

    final notifier = container.read(authControllerProvider.notifier);
    notifier.setAuthenticated(user);
    await notifier.signOut();
    notifier.clearUnauthenticatedNotice();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(),
    );
  });
}
