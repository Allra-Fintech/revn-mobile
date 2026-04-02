import '../../domain/entities/current_user.dart';
import '../../domain/repositories/auth_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<CurrentUser> call({
    required String businessNumber,
    required String password,
  }) {
    return _authRepository.signUp(
      businessNumber: businessNumber,
      password: password,
    );
  }
}
