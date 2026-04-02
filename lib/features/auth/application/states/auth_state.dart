import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_user.dart';
import '../../domain/failures/auth_failure.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.restoreFailed(AuthFailure failure) = _RestoreFailed;
  const factory AuthState.authenticated(CurrentUser user) = _Authenticated;
  const factory AuthState.unauthenticated({AuthFailure? notice}) =
      _Unauthenticated;
}
