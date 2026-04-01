import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/common_failure.dart';

part 'auth_failure.freezed.dart';

@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidCredentials() = InvalidCredentials;
  const factory AuthFailure.unauthorized() = Unauthorized;
  const factory AuthFailure.duplicateBusinessNumber() = DuplicateBusinessNumber;
  const factory AuthFailure.common(CommonFailure failure) = CommonAuthFailure;
}
