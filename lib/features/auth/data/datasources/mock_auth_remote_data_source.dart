import 'package:dio/dio.dart';

import '../dtos/sign_in_response_dto.dart';
import '../dtos/user_dto.dart';
import '../fixtures/auth_mock_fixtures.dart';
import 'auth_remote_data_source.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  MockAuthRemoteDataSource({this.latency = const Duration(milliseconds: 800)});

  final Duration latency;

  @override
  Future<SignInResponseDto> signIn({
    required String businessNumber,
    required String password,
  }) async {
    await Future<void>.delayed(latency);

    final normalizedBusinessNumber = businessNumber.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

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
  Future<UserDto> getMe() async {
    await Future<void>.delayed(latency);
    return AuthMockFixtures.meResponse();
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
