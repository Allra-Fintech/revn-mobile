import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/application/controllers/sign_up_controller.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/domain/entities/current_user.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/application/usecases/sign_up_usecase.dart';
import 'package:revn/features/auth/application/usecases/verify_business_number_usecase.dart';

class MockVerifyBusinessNumberUseCase extends Mock
    implements VerifyBusinessNumberUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

void main() {
  late ProviderContainer container;
  late MockVerifyBusinessNumberUseCase verifyBusinessNumberUseCase;
  late MockSignUpUseCase signUpUseCase;

  setUp(() {
    verifyBusinessNumberUseCase = MockVerifyBusinessNumberUseCase();
    signUpUseCase = MockSignUpUseCase();

    container = ProviderContainer(
      overrides: [
        verifyBusinessNumberUseCaseProvider.overrideWithValue(
          verifyBusinessNumberUseCase,
        ),
        signUpUseCaseProvider.overrideWithValue(signUpUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('사업자번호 인증 성공 시 verification 상태가 AsyncData가 된다', () async {
    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(TaskEither.right(unit));

    final isVerified = await container
        .read(signUpControllerProvider.notifier)
        .verifyBusinessNumber(businessNumber: '1234567890');

    expect(isVerified, true);
    expect(
      container.read(signUpControllerProvider).verification,
      const AsyncData<void>(null),
    );
  });

  test('사업자번호 인증 실패 시 verification error 상태가 된다', () async {
    when(
      () => verifyBusinessNumberUseCase(businessNumber: '1234567890'),
    ).thenReturn(
      TaskEither.left(
        const AuthFailure.common(CommonFailure.server('사업자번호 인증에 실패했습니다.')),
      ),
    );

    final isVerified = await container
        .read(signUpControllerProvider.notifier)
        .verifyBusinessNumber(businessNumber: '1234567890');

    final state = container.read(signUpControllerProvider);

    expect(isVerified, false);
    expect(state.verification.hasError, true);
    expect(
      state.verification.error,
      const AuthFailure.common(CommonFailure.server('사업자번호 인증에 실패했습니다.')),
    );
  });

  test('회원가입 성공 시 signedUpUser가 저장된다', () async {
    const user = CurrentUser(
      id: '1',
      businessNumber: '1234567890',
      username: 'New Owner',
    );

    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(TaskEither.right(user));

    final result = await container
        .read(signUpControllerProvider.notifier)
        .signUp(businessNumber: '1234567890', password: '1234');

    final state = container.read(signUpControllerProvider);

    expect(result, user);
    expect(state.submission, const AsyncData<void>(null));
    expect(state.signedUpUser, user);
  });

  test('회원가입 실패 시 submission error 상태가 된다', () async {
    when(
      () => signUpUseCase(businessNumber: '1234567890', password: '1234'),
    ).thenReturn(
      TaskEither.left(
        const AuthFailure.common(CommonFailure.server('이미 가입된 사업자번호입니다.')),
      ),
    );

    final result = await container
        .read(signUpControllerProvider.notifier)
        .signUp(businessNumber: '1234567890', password: '1234');

    final state = container.read(signUpControllerProvider);

    expect(result, isNull);
    expect(state.submission.hasError, true);
    expect(
      state.submission.error,
      const AuthFailure.common(CommonFailure.server('이미 가입된 사업자번호입니다.')),
    );
  });
}
