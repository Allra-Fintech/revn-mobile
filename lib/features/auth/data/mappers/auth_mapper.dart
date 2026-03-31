import '../../domain/entities/current_user.dart';
import '../dtos/user_dto.dart';

extension UserDtoMapper on UserDto {
  CurrentUser toEntity() {
    return CurrentUser(
      id: id,
      businessNumber: businessNumber,
      username: username,
    );
  }
}
