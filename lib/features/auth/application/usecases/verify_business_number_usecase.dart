import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/auth_repository.dart';

class VerifyBusinessNumberUseCase {
  VerifyBusinessNumberUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<Unit> call({required String businessNumber}) {
    return _authRepository.verifyBusinessNumber(businessNumber: businessNumber);
  }
}
