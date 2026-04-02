import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
sealed class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String id,
    required String businessNumber,
    String? username,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  @override
  String toString() {
    return 'UserDto('
        'hasId: ${id.isNotEmpty}, '
        'hasBusinessNumber: ${businessNumber.isNotEmpty}, '
        'hasUsername: ${username != null && username!.isNotEmpty}'
        ')';
  }
}
