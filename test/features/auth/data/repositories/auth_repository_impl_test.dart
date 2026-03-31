import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:revn/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/data/dtos/sign_in_response_dto.dart';
import 'package:revn/features/auth/data/dtos/user_dto.dart';
import 'package:revn/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late MockAuthLocalDataSource localDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    localDataSource = MockAuthLocalDataSource();

    repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  group('signIn', () {
    test('성공 시 토큰 저장 후 CurrentUser를 반환한다', () async {
      const response = SignInResponseDto(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        user: UserDto(
          id: '1',
          email: 'test@test.com',
          nickname: 'Sangmin',
          profileImageUrl: null,
        ),
      );

      when(
        () => remoteDataSource.signIn(email: 'test@test.com', password: '1234'),
      ).thenAnswer((_) async => response);

      when(
        () => localDataSource.saveTokens(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        ),
      ).thenAnswer((_) async {});

      final result = await repository
          .signIn(email: 'test@test.com', password: '1234')
          .run();

      expect(result.isRight(), true);

      result.match((_) => fail('Right expected'), (user) {
        expect(user.id, '1');
        expect(user.email, 'test@test.com');
        expect(user.nickname, 'Sangmin');
      });

      verify(
        () => localDataSource.saveTokens(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        ),
      ).called(1);
    });

    test('401 에러면 unauthorized failure를 반환한다', () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/sign-in'),
          response: Response(
            requestOptions: RequestOptions(path: '/auth/sign-in'),
            statusCode: 401,
          ),
        ),
      );

      final result = await repository
          .signIn(email: 'test@test.com', password: '1234')
          .run();

      expect(result.isLeft(), true);

      result.match((failure) {
        expect(failure, const AuthFailure.unauthorized());
      }, (_) => fail('Left expected'));
    });
  });

  group('restoreSession', () {
    test('access token이 없으면 Right(null)을 반환한다', () async {
      when(
        () => localDataSource.getAccessToken(),
      ).thenAnswer((_) async => null);

      final result = await repository.restoreSession().run();

      expect(result.isRight(), true);

      result.match(
        (_) => fail('Right expected'),
        (user) => expect(user, isNull),
      );

      verifyNever(() => remoteDataSource.getMe());
    });

    test('access token이 있으면 getMe 후 user를 반환한다', () async {
      when(
        () => localDataSource.getAccessToken(),
      ).thenAnswer((_) async => 'access-token');

      when(() => remoteDataSource.getMe()).thenAnswer(
        (_) async => const UserDto(
          id: '1',
          email: 'test@test.com',
          nickname: 'Sangmin',
          profileImageUrl: null,
        ),
      );

      final result = await repository.restoreSession().run();

      expect(result.isRight(), true);

      result.match((_) => fail('Right expected'), (user) {
        expect(user, isNotNull);
        expect(user!.email, 'test@test.com');
      });

      verify(() => remoteDataSource.getMe()).called(1);
    });
  });

  group('signOut', () {
    test('토큰을 삭제하고 unit을 반환한다', () async {
      when(() => localDataSource.clearTokens()).thenAnswer((_) async {});

      final result = await repository.signOut().run();

      expect(result.isRight(), true);
      verify(() => localDataSource.clearTokens()).called(1);
    });
  });
}
