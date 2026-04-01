import 'package:dio/dio.dart';

import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';
import '../fixtures/auth_mock_fixtures.dart';
import 'auth_remote_data_source.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  MockAuthRemoteDataSource({this.latency = const Duration(milliseconds: 800)});

  final Duration latency;

  @override
  Future<void> verifyBusinessNumber({required String businessNumber}) async {
    await Future<void>.delayed(latency);

    final normalizedBusinessNumber = _normalizeBusinessNumber(businessNumber);

    if (normalizedBusinessNumber.length != 10) {
      throw _httpError(
        path: '/auth/business-number/verify',
        statusCode: 400,
        message: '유효한 사업자번호를 입력해주세요.',
      );
    }

    switch (normalizedBusinessNumber) {
      case AuthMockFixtures.successBusinessNumber:
        return;
      case AuthMockFixtures.duplicateRegistrationBusinessNumber:
        throw _httpError(
          path: '/auth/business-number/verify',
          statusCode: 409,
          message: '이미 가입된 사업자번호입니다.',
        );
      case AuthMockFixtures.validationErrorBusinessNumber:
        throw _httpError(
          path: '/auth/business-number/verify',
          statusCode: 400,
          message: '사업자번호 인증에 실패했습니다.',
        );
      case AuthMockFixtures.timeoutBusinessNumber:
        throw _timeoutError(
          path: '/auth/business-number/verify',
          message: 'Mock connection timeout.',
        );
      default:
        throw _httpError(
          path: '/auth/business-number/verify',
          statusCode: 400,
          message: '확인 가능한 사업자번호를 입력해주세요.',
        );
    }
  }

  @override
  Future<SignInResponseDto> signIn({
    required String businessNumber,
    required String password,
  }) async {
    await Future<void>.delayed(latency);

    final normalizedBusinessNumber = _normalizeBusinessNumber(businessNumber);

    if (normalizedBusinessNumber.isEmpty || password.trim().isEmpty) {
      throw _httpError(
        path: '/auth/sign-in',
        statusCode: 400,
        message: 'Business number and password are required.',
      );
    }

    return switch (normalizedBusinessNumber) {
      AuthMockFixtures.successBusinessNumber =>
        AuthMockFixtures.successSignInResponse(),
      AuthMockFixtures.emptyStateBusinessNumber =>
        AuthMockFixtures.emptyStateSignInResponse(),
      AuthMockFixtures.validationErrorBusinessNumber => throw _httpError(
        path: '/auth/sign-in',
        statusCode: 400,
        message: 'Mock validation failure.',
      ),
      AuthMockFixtures.unauthorizedBusinessNumber => throw _httpError(
        path: '/auth/sign-in',
        statusCode: 401,
        message: 'Mock unauthorized.',
      ),
      AuthMockFixtures.timeoutBusinessNumber => throw _timeoutError(
        path: '/auth/sign-in',
        message: 'Mock connection timeout.',
      ),
      _ => throw _httpError(
        path: '/auth/sign-in',
        statusCode: 403,
        message: 'Mock invalid credentials.',
      ),
    };
  }

  @override
  Future<SignInResponseDto> signUp({
    required String businessNumber,
    required String password,
  }) async {
    await Future<void>.delayed(latency);

    final normalizedBusinessNumber = _normalizeBusinessNumber(businessNumber);

    if (normalizedBusinessNumber.isEmpty || password.trim().isEmpty) {
      throw _httpError(
        path: '/auth/sign-up',
        statusCode: 400,
        message: '사업자번호와 비밀번호를 입력해주세요.',
      );
    }

    return switch (normalizedBusinessNumber) {
      AuthMockFixtures.successBusinessNumber =>
        AuthMockFixtures.successSignUpResponse(),
      AuthMockFixtures.validationErrorBusinessNumber => throw _httpError(
        path: '/auth/sign-up',
        statusCode: 400,
        message: '회원가입 정보를 다시 확인해주세요.',
      ),
      AuthMockFixtures.duplicateRegistrationBusinessNumber => throw _httpError(
        path: '/auth/sign-up',
        statusCode: 409,
        message: '이미 가입된 사업자번호입니다.',
      ),
      AuthMockFixtures.timeoutBusinessNumber => throw _timeoutError(
        path: '/auth/sign-up',
        message: 'Mock connection timeout.',
      ),
      _ => throw _httpError(
        path: '/auth/sign-up',
        statusCode: 400,
        message: '회원가입에 실패했습니다.',
      ),
    };
  }

  @override
  Future<UserDto> getMe() async {
    await Future<void>.delayed(latency);
    return AuthMockFixtures.meResponse();
  }

  String _normalizeBusinessNumber(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  DioException _httpError({
    required String path,
    required int statusCode,
    required String message,
  }) {
    final requestOptions = RequestOptions(path: path);

    return DioException.badResponse(
      statusCode: statusCode,
      requestOptions: requestOptions,
      response: Response<Map<String, dynamic>>(
        requestOptions: requestOptions,
        statusCode: statusCode,
        data: <String, dynamic>{'message': message},
      ),
    );
  }

  DioException _timeoutError({required String path, required String message}) {
    return DioException(
      requestOptions: RequestOptions(path: path),
      type: DioExceptionType.connectionTimeout,
      message: message,
    );
  }
}
