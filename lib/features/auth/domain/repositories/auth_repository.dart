import 'package:fpdart/fpdart.dart';

import '../entities/current_user.dart';
import '../entities/social_provider.dart';
import '../failures/auth_failure.dart';

typedef AuthResultFuture<T> = TaskEither<AuthFailure, T>;

abstract interface class AuthRepository {
  AuthResultFuture<Unit> verifyBusinessNumber({required String businessNumber});

  AuthResultFuture<CurrentUser> signIn({
    required String businessNumber,
    required String password,
  });

  AuthResultFuture<CurrentUser> signInWithSocial({
    required SocialProvider provider,
    required String accessToken,
  });

  AuthResultFuture<CurrentUser> signUp({
    required String businessNumber,
    required String password,
  });

  AuthResultFuture<Unit> linkSocialAccount({
    required SocialProvider provider,
    required String accessToken,
  });

  AuthResultFuture<CurrentUser?> restoreSession();

  AuthResultFuture<Unit> signOut();
}
