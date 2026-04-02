import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_auth_request_dto.freezed.dart';
part 'social_auth_request_dto.g.dart';

@freezed
sealed class SocialAuthRequestDto with _$SocialAuthRequestDto {
  const factory SocialAuthRequestDto({required String accessToken}) =
      _SocialAuthRequestDto;

  factory SocialAuthRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SocialAuthRequestDtoFromJson(json);
}
