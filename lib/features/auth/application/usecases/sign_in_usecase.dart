import '../../domain/entities/current_user.dart';
import '../../domain/repositories/auth_repository.dart';

class SignInUseCase {
  SignInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<CurrentUser> call({
    required String email,
    required String password,
  }) {
    return _authRepository.signIn(email: email, password: password);
  }
}
