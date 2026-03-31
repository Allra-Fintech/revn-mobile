import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';

class AuthMockFixtures {
  const AuthMockFixtures._();

  static const successBusinessNumber = '1234567890';
  static const emptyStateBusinessNumber = '2000000000';
  static const validationErrorBusinessNumber = '4000000000';
  static const unauthorizedBusinessNumber = '4010000000';
  static const timeoutBusinessNumber = '4080000000';
  static const invalidCredentialsBusinessNumber = '4030000000';
  static const defaultPassword = '1234';

  static const successSignInResponseJson = <String, dynamic>{
    'accessToken': 'mock-access-token',
    'refreshToken': 'mock-refresh-token',
    'user': <String, dynamic>{
      'id': 'mock-user-1',
      'businessNumber': successBusinessNumber,
      'nickname': 'Mock Owner',
      'profileImageUrl': null,
    },
  };

  static const emptyStateSignInResponseJson = <String, dynamic>{
    'accessToken': 'mock-access-token-empty',
    'refreshToken': 'mock-refresh-token-empty',
    'user': <String, dynamic>{
      'id': 'mock-user-empty',
      'businessNumber': emptyStateBusinessNumber,
      'nickname': '',
      'profileImageUrl': null,
    },
  };

  static const meResponseJson = <String, dynamic>{
    'id': 'mock-user-1',
    'businessNumber': successBusinessNumber,
    'nickname': 'Mock Owner',
    'profileImageUrl': null,
  };

  static SignInResponseDto successSignInResponse() {
    return SignInResponseDto.fromJson(successSignInResponseJson);
  }

  static SignInResponseDto emptyStateSignInResponse() {
    return SignInResponseDto.fromJson(emptyStateSignInResponseJson);
  }

  static UserDto meResponse() {
    return UserDto.fromJson(meResponseJson);
  }
}
