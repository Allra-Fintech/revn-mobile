import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_dto.dart';

part 'sign_in_response_dto.freezed.dart';
part 'sign_in_response_dto.g.dart';

@freezed
sealed class SignInResponseDto with _$SignInResponseDto {
  const SignInResponseDto._();

  const factory SignInResponseDto({
    required String accessToken,
    required String refreshToken,
    required UserDto user,
  }) = _SignInResponseDto;

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDtoFromJson(json);

  @override
  String toString() {
    return 'SignInResponseDto('
        'hasAccessToken: ${accessToken.isNotEmpty}, '
        'hasRefreshToken: ${refreshToken.isNotEmpty}, '
        'hasUser: true'
        ')';
  }
}
