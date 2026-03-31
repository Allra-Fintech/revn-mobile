import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<SignInResponseDto> signIn({
    required String businessNumber,
    required String password,
  });

  Future<UserDto> getMe();
}
