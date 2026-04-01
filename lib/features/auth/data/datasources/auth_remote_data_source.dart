import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> verifyBusinessNumber({required String businessNumber});

  Future<SignInResponseDto> signIn({
    required String businessNumber,
    required String password,
  });

  Future<SignInResponseDto> signUp({
    required String businessNumber,
    required String password,
  });

  Future<UserDto> getMe();
}
