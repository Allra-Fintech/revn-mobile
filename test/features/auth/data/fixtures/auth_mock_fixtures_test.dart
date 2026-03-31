import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/data/dtos/sign_in_response_dto.dart';
import 'package:revn/features/auth/data/dtos/user_dto.dart';
import 'package:revn/features/auth/data/fixtures/auth_mock_fixtures.dart';

void main() {
  test('success sign in fixture matches SignInResponseDto contract', () {
    final dto = SignInResponseDto.fromJson(
      AuthMockFixtures.successSignInResponseJson,
    );

    expect(dto.accessToken, 'mock-access-token');
    expect(dto.user.businessNumber, AuthMockFixtures.successBusinessNumber);
  });

  test('empty state fixture matches SignInResponseDto contract', () {
    final dto = SignInResponseDto.fromJson(
      AuthMockFixtures.emptyStateSignInResponseJson,
    );

    expect(dto.user.businessNumber, AuthMockFixtures.emptyStateBusinessNumber);
    expect(dto.user.nickname, isEmpty);
  });

  test('me fixture matches UserDto contract', () {
    final dto = UserDto.fromJson(AuthMockFixtures.meResponseJson);

    expect(dto.businessNumber, AuthMockFixtures.successBusinessNumber);
    expect(dto.nickname, 'Mock Owner');
  });
}
