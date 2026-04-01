import 'package:fpdart/fpdart.dart';

import '../../domain/entities/social_provider.dart';
import '../../domain/repositories/auth_repository.dart';

class LinkSocialAccountUseCase {
  LinkSocialAccountUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AuthResultFuture<Unit> call({
    required SocialProvider provider,
    required String accessToken,
  }) {
    return _authRepository.linkSocialAccount(
      provider: provider,
      accessToken: accessToken,
    );
  }
}
