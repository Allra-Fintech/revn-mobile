import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/application/controllers/auth_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/application/states/auth_state.dart';
import 'package:revn/features/auth/application/usecases/restore_session_usecase.dart';
import 'package:revn/features/auth/application/usecases/sign_out_usecase.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';

class MockRestoreSessionUseCase extends Mock implements RestoreSessionUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  late ProviderContainer container;
  late MockRestoreSessionUseCase restoreSessionUseCase;
  late MockSignOutUseCase signOutUseCase;

  setUp(() {
    restoreSessionUseCase = MockRestoreSessionUseCase();
    signOutUseCase = MockSignOutUseCase();

    container = ProviderContainer(
      overrides: [
        restoreSessionUseCaseProvider.overrideWithValue(restoreSessionUseCase),
        signOutUseCaseProvider.overrideWithValue(signOutUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('restoreSession 성공 시 authenticated 상태가 된다', () async {
    const user = CurrentUser(
      id: '1',
      email: 'test@test.com',
      nickname: 'Sangmin',
      profileImageUrl: null,
    );

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

  test('signOut 성공 후 unauthenticated 상태가 된다', () async {
    when(() => signOutUseCase()).thenReturn(TaskEither.right(unit));

    final notifier = container.read(authControllerProvider.notifier);
    notifier.setAuthenticated(
      const CurrentUser(
        id: '1',
        email: 'test@test.com',
        nickname: 'Sangmin',
        profileImageUrl: null,
      ),
    );

    await notifier.signOut();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(),
    );
  });
}
