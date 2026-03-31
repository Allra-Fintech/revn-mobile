import 'package:fpdart/fpdart.dart';

import '../entities/current_user.dart';
import '../failures/auth_failure.dart';

typedef AuthResultFuture<T> = TaskEither<AuthFailure, T>;

abstract interface class AuthRepository {
  AuthResultFuture<CurrentUser> signIn({
    required String email,
    required String password,
  });

  AuthResultFuture<CurrentUser?> restoreSession();

  AuthResultFuture<Unit> signOut();
}
