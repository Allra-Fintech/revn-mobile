import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/auth_repository.dart';

class SignOutUseCase {
  SignOutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<Unit> call() {
    return _authRepository.signOut();
  }
}
