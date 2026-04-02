import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_request_dto.freezed.dart';
part 'sign_in_request_dto.g.dart';

@freezed
sealed class SignInRequestDto with _$SignInRequestDto {
  const SignInRequestDto._();

  const factory SignInRequestDto({
    required String businessNumber,
    required String password,
  }) = _SignInRequestDto;

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestDtoFromJson(json);

  @override
  String toString() {
    return 'SignInRequestDto('
        'hasBusinessNumber: ${businessNumber.isNotEmpty}, '
        'hasPassword: ${password.isNotEmpty}'
        ')';
  }
}
