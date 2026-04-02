import '../../domain/entities/current_user.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/repositories/auth_repository.dart';

class SignInWithSocialUseCase {
  SignInWithSocialUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<CurrentUser> call({
    required SocialProvider provider,
    required String accessToken,
  }) {
    return _authRepository.signInWithSocial(
      provider: provider,
      accessToken: accessToken,
    );
  }
}
