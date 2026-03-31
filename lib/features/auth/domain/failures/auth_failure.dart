import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidCredentials() = InvalidCredentials;
  const factory AuthFailure.unauthorized() = Unauthorized;
  const factory AuthFailure.network() = Network;
  const factory AuthFailure.server([String? message]) = Server;
  const factory AuthFailure.storage() = Storage;
  const factory AuthFailure.unknown([String? message]) = Unknown;
}
