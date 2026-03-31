import '../../domain/entities/current_user.dart';
import '../dtos/user_dto.dart';

extension UserDtoMapper on UserDto {
  CurrentUser toEntity() {
    return CurrentUser(
      id: id,
      email: email,
      nickname: nickname,
      profileImageUrl: profileImageUrl,
    );
  }
}
