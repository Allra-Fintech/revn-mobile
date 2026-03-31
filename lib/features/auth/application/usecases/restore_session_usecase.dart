import '../../domain/entities/current_user.dart';
import '../../domain/repositories/auth_repository.dart';

class RestoreSessionUseCase {
  RestoreSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<CurrentUser?> call() {
    return _authRepository.restoreSession();
  }
}
