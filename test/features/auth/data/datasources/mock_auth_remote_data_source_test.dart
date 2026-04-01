import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/data/datasources/mock_auth_remote_data_source.dart';
import 'package:revn/features/auth/data/fixtures/auth_mock_fixtures.dart';

void main() {
  late MockAuthRemoteDataSource dataSource;

  setUp(() {
    dataSource = MockAuthRemoteDataSource(latency: Duration.zero);
  });

  test('verifyBusinessNumber success scenario completes', () async {
    await dataSource.verifyBusinessNumber(
      businessNumber: AuthMockFixtures.successBusinessNumber,
    );
  });

  test(
    'verifyBusinessNumber duplicate registration scenario throws 409 dio exception',
    () async {
      await expectLater(
        () => dataSource.verifyBusinessNumber(
          businessNumber: AuthMockFixtures.duplicateRegistrationBusinessNumber,
        ),
        throwsA(
          isA<DioException>().having(
            (error) => error.response?.statusCode,
            'statusCode',
            409,
          ),
        ),
      );
    },
  );

  test(
    'verifyBusinessNumber validation scenario throws 400 dio exception',
    () async {
      await expectLater(
        () => dataSource.verifyBusinessNumber(
          businessNumber: AuthMockFixtures.validationErrorBusinessNumber,
        ),
        throwsA(
          isA<DioException>().having(
            (error) => error.response?.statusCode,
            'statusCode',
            400,
          ),
        ),
      );
    },
  );

  test('success credentials return mock sign in response', () async {
    final response = await dataSource.signIn(
      businessNumber: AuthMockFixtures.successBusinessNumber,
      password: AuthMockFixtures.defaultPassword,
    );

    expect(
      response.user.businessNumber,
      AuthMockFixtures.successBusinessNumber,
    );
    expect(response.user.username, 'Mock Owner');
  });

  test('signUp success scenario returns session response', () async {
    final response = await dataSource.signUp(
      businessNumber: AuthMockFixtures.successBusinessNumber,
      password: AuthMockFixtures.defaultPassword,
    );

    expect(
      response.user.businessNumber,
      AuthMockFixtures.successBusinessNumber,
    );
    expect(response.user.username, 'New Owner');
  });

  test('signUp duplicate scenario throws 409 dio exception', () async {
    await expectLater(
      () => dataSource.signUp(
        businessNumber: AuthMockFixtures.duplicateRegistrationBusinessNumber,
        password: AuthMockFixtures.defaultPassword,
      ),
      throwsA(
        isA<DioException>().having(
          (error) => error.response?.statusCode,
          'statusCode',
          409,
        ),
      ),
    );
  });

  test('empty-state credentials return an empty username scenario', () async {
    final response = await dataSource.signIn(
      businessNumber: AuthMockFixtures.emptyStateBusinessNumber,
      password: AuthMockFixtures.defaultPassword,
    );

    expect(
      response.user.businessNumber,
      AuthMockFixtures.emptyStateBusinessNumber,
    );
    expect(response.user.username, isEmpty);
  });

  test('validation scenario throws 400 dio exception', () async {
    await expectLater(
      () => dataSource.signIn(
        businessNumber: AuthMockFixtures.validationErrorBusinessNumber,
        password: AuthMockFixtures.defaultPassword,
      ),
      throwsA(
        isA<DioException>().having(
          (error) => error.response?.statusCode,
          'statusCode',
          400,
        ),
      ),
    );
  });

  test('unauthorized scenario throws 401 dio exception', () async {
    await expectLater(
      () => dataSource.signIn(
        businessNumber: AuthMockFixtures.unauthorizedBusinessNumber,
        password: AuthMockFixtures.defaultPassword,
      ),
      throwsA(
        isA<DioException>().having(
          (error) => error.response?.statusCode,
          'statusCode',
          401,
        ),
      ),
    );
  });

  test('timeout scenario throws connection timeout dio exception', () async {
    await expectLater(
      () => dataSource.signIn(
        businessNumber: AuthMockFixtures.timeoutBusinessNumber,
        password: AuthMockFixtures.defaultPassword,
      ),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.connectionTimeout,
        ),
      ),
    );
  });

  test('getMe returns the mock user fixture', () async {
    final user = await dataSource.getMe();

    expect(user.businessNumber, AuthMockFixtures.successBusinessNumber);
    expect(user.username, 'Mock Owner');
  });
}
