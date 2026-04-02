import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';

class AuthMockFixtures {
  const AuthMockFixtures._();

  static const successBusinessNumber = '1234567890';
  static const emptyStateBusinessNumber = '2000000000';
  static const validationErrorBusinessNumber = '4000000000';
  static const unauthorizedBusinessNumber = '4010000000';
  static const timeoutBusinessNumber = '4080000000';
  static const duplicateRegistrationBusinessNumber = '4090000000';
  static const invalidCredentialsBusinessNumber = '4030000000';
  static const defaultPassword = '1234';
  static const linkedKakaoAccessToken = 'mock-kakao-linked-token';
  static const unlinkedKakaoAccessToken = 'mock-kakao-unlinked-token';
  static const linkFailureKakaoAccessToken = 'mock-kakao-link-failure-token';
  static const timeoutKakaoAccessToken = 'mock-kakao-timeout-token';
  static const socialAccountNotLinkedMessage = '연동된 소셜 계정이 없습니다.';

  static const successSignInResponseJson = <String, dynamic>{
    'accessToken': 'mock-access-token',
    'refreshToken': 'mock-refresh-token',
    'user': <String, dynamic>{
      'id': 'mock-user-1',
      'businessNumber': successBusinessNumber,
      'username': 'Mock Owner',
    },
  };

  static const emptyStateSignInResponseJson = <String, dynamic>{
    'accessToken': 'mock-access-token-empty',
    'refreshToken': 'mock-refresh-token-empty',
    'user': <String, dynamic>{
      'id': 'mock-user-empty',
      'businessNumber': emptyStateBusinessNumber,
      'username': '',
    },
  };

  static const successSignUpResponseJson = <String, dynamic>{
    'accessToken': 'mock-sign-up-access-token',
    'refreshToken': 'mock-sign-up-refresh-token',
    'user': <String, dynamic>{
      'id': 'mock-user-sign-up',
      'businessNumber': successBusinessNumber,
      'username': 'New Owner',
    },
  };

  static const meResponseJson = <String, dynamic>{
    'id': 'mock-user-1',
    'businessNumber': successBusinessNumber,
    'username': 'Mock Owner',
  };

  static SignInResponseDto successSignInResponse() {
    return SignInResponseDto.fromJson(successSignInResponseJson);
  }

  static SignInResponseDto emptyStateSignInResponse() {
    return SignInResponseDto.fromJson(emptyStateSignInResponseJson);
  }

  static SignInResponseDto successSignUpResponse() {
    return SignInResponseDto.fromJson(successSignUpResponseJson);
  }

  static UserDto meResponse() {
    return UserDto.fromJson(meResponseJson);
  }
}
