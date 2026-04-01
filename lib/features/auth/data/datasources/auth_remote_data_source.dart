import '../../domain/entities/social_provider.dart';
import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> verifyBusinessNumber({required String businessNumber});

  Future<SignInResponseDto> signIn({
    required String businessNumber,
    required String password,
  });

  Future<SignInResponseDto> signInWithSocial({
    required SocialProvider provider,
    required String accessToken,
  });

  Future<SignInResponseDto> signUp({
    required String businessNumber,
    required String password,
  });

  Future<void> linkSocialAccount({
    required SocialProvider provider,
    required String accessToken,
    required String appAccessToken,
  });

  Future<UserDto> getMe({required String appAccessToken});
}
