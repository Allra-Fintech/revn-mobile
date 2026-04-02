import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:revn/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/data/dtos/sign_in_response_dto.dart';
import 'package:revn/features/auth/data/dtos/user_dto.dart';
import 'package:revn/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';
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
          businessNumber: '1234567890',
          username: 'Sangmin',
        ),
      );

      when(
        () => remoteDataSource.signIn(
          businessNumber: '1234567890',
          password: '1234',
        ),
      ).thenAnswer((_) async => response);

      when(
        () => localDataSource.saveTokens(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        ),
      ).thenAnswer((_) async {});

      final result = await repository
          .signIn(businessNumber: '1234567890', password: '1234')
          .run();

      expect(result.isRight(), true);

      result.match((_) => fail('Right expected'), (user) {
        expect(user.id, '1');
        expect(user.businessNumber, '1234567890');
        expect(user.username, 'Sangmin');
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
          businessNumber: any(named: 'businessNumber'),
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
          .signIn(businessNumber: '1234567890', password: '1234')
          .run();

      expect(result.isLeft(), true);

      result.match((failure) {
        expect(failure, const AuthFailure.unauthorized());
      }, (_) => fail('Left expected'));
    });
  });

  group('verifyBusinessNumber', () {
    test('성공 시 unit을 반환한다', () async {
      when(
        () =>
            remoteDataSource.verifyBusinessNumber(businessNumber: '1234567890'),
      ).thenAnswer((_) async {});

      final result = await repository
          .verifyBusinessNumber(businessNumber: '1234567890')
          .run();

      expect(result, const Right(unit));
      verify(
        () =>
            remoteDataSource.verifyBusinessNumber(businessNumber: '1234567890'),
      ).called(1);
    });

    test('중복 사업자번호 인증 에러는 duplicate failure를 반환한다', () async {
      when(
        () => remoteDataSource.verifyBusinessNumber(
          businessNumber: any(named: 'businessNumber'),
        ),
      ).thenThrow(
        DioException.badResponse(
          statusCode: 409,
          requestOptions: RequestOptions(path: '/auth/business-number/verify'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(
              path: '/auth/business-number/verify',
            ),
            statusCode: 409,
            data: const {'message': '이미 가입된 사업자번호입니다.'},
          ),
        ),
      );

      final result = await repository
          .verifyBusinessNumber(businessNumber: '4090000000')
          .run();

      expect(result.isLeft(), true);

      result.match((failure) {
        expect(failure, const AuthFailure.duplicateBusinessNumber());
      }, (_) => fail('Left expected'));
    });
  });

  group('signUp', () {
    test('성공 시 토큰 저장 후 CurrentUser를 반환한다', () async {
      const response = SignInResponseDto(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        user: UserDto(
          id: '2',
          businessNumber: '1234567890',
          username: 'New Owner',
        ),
      );

      when(
        () => remoteDataSource.signUp(
          businessNumber: '1234567890',
          password: '1234',
        ),
      ).thenAnswer((_) async => response);

      when(
        () => localDataSource.saveTokens(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        ),
      ).thenAnswer((_) async {});

      final result = await repository
          .signUp(businessNumber: '1234567890', password: '1234')
          .run();

      expect(result.isRight(), true);

      result.match((_) => fail('Right expected'), (user) {
        expect(user.id, '2');
        expect(user.businessNumber, '1234567890');
        expect(user.username, 'New Owner');
      });

      verify(
        () => localDataSource.saveTokens(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        ),
      ).called(1);
    });

    test('409 에러면 message를 담은 common server failure를 반환한다', () async {
      when(
        () => remoteDataSource.signUp(
          businessNumber: any(named: 'businessNumber'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        DioException.badResponse(
          statusCode: 409,
          requestOptions: RequestOptions(path: '/auth/sign-up'),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/auth/sign-up'),
            statusCode: 409,
            data: const {'message': '이미 가입된 사업자번호입니다.'},
          ),
        ),
      );

      final result = await repository
          .signUp(businessNumber: '1234567890', password: '1234')
          .run();

      expect(result.isLeft(), true);

      result.match((failure) {
        expect(
          failure,
          const AuthFailure.common(CommonFailure.server('이미 가입된 사업자번호입니다.')),
        );
      }, (_) => fail('Left expected'));
    });
  });

  group('signInWithSocial', () {
    test('성공 시 토큰 저장 후 CurrentUser를 반환한다', () async {
      const response = SignInResponseDto(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        user: UserDto(
          id: 'social-user',
          businessNumber: '1234567890',
          username: 'Social Owner',
        ),
      );

      when(
        () => remoteDataSource.signInWithSocial(
          provider: SocialProvider.kakao,
          accessToken: 'social-token',
        ),
      ).thenAnswer((_) async => response);

      when(
        () => localDataSource.saveTokens(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        ),
      ).thenAnswer((_) async {});

      final result = await repository
          .signInWithSocial(
            provider: SocialProvider.kakao,
            accessToken: 'social-token',
          )
          .run();

      expect(result.isRight(), true);
      result.match((_) => fail('Right expected'), (user) {
        expect(user.id, 'social-user');
        expect(user.username, 'Social Owner');
      });
    });

    test('404 에러면 socialAccountNotLinked failure를 반환한다', () async {
      when(
        () => remoteDataSource.signInWithSocial(
          provider: SocialProvider.kakao,
          accessToken: any(named: 'accessToken'),
        ),
      ).thenThrow(
        DioException.badResponse(
          statusCode: 404,
          requestOptions: RequestOptions(path: SocialProvider.kakao.signInPath),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(
              path: SocialProvider.kakao.signInPath,
            ),
            statusCode: 404,
            data: const {'message': '연동된 소셜 계정이 없습니다.'},
          ),
        ),
      );

      final result = await repository
          .signInWithSocial(
            provider: SocialProvider.kakao,
            accessToken: 'social-token',
          )
          .run();

      expect(result.isLeft(), true);
      result.match((failure) {
        expect(
          failure,
          const AuthFailure.socialAccountNotLinked(SocialProvider.kakao),
        );
      }, (_) => fail('Left expected'));
    });
  });

  group('linkSocialAccount', () {
    test('저장된 app access token으로 연동 요청을 보낸다', () async {
      when(
        () => localDataSource.getAccessToken(),
      ).thenAnswer((_) async => 'app-access-token');
      when(
        () => remoteDataSource.linkSocialAccount(
          provider: SocialProvider.kakao,
          accessToken: 'social-token',
          appAccessToken: 'app-access-token',
        ),
      ).thenAnswer((_) async {});

      final result = await repository
          .linkSocialAccount(
            provider: SocialProvider.kakao,
            accessToken: 'social-token',
          )
          .run();

      expect(result, const Right(unit));
      verify(
        () => remoteDataSource.linkSocialAccount(
          provider: SocialProvider.kakao,
          accessToken: 'social-token',
          appAccessToken: 'app-access-token',
        ),
      ).called(1);
    });

    test('저장된 app access token이 없으면 storage failure를 반환한다', () async {
      when(
        () => localDataSource.getAccessToken(),
      ).thenAnswer((_) async => null);

      final result = await repository
          .linkSocialAccount(
            provider: SocialProvider.kakao,
            accessToken: 'social-token',
          )
          .run();

      expect(result.isLeft(), true);
      result.match((failure) {
        expect(failure, const AuthFailure.common(CommonFailure.storage()));
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

      verifyNever(
        () => remoteDataSource.getMe(
          appAccessToken: any(named: 'appAccessToken'),
        ),
      );
    });

    test('access token이 있으면 getMe 후 user를 반환한다', () async {
      when(
        () => localDataSource.getAccessToken(),
      ).thenAnswer((_) async => 'access-token');

      when(
        () => remoteDataSource.getMe(appAccessToken: 'access-token'),
      ).thenAnswer(
        (_) async => const UserDto(
          id: '1',
          businessNumber: '1234567890',
          username: 'Sangmin',
        ),
      );

      final result = await repository.restoreSession().run();

      expect(result.isRight(), true);

      result.match((_) => fail('Right expected'), (user) {
        expect(user, isNotNull);
        expect(user!.businessNumber, '1234567890');
      });

      verify(
        () => remoteDataSource.getMe(appAccessToken: 'access-token'),
      ).called(1);
    });

    test('secure storage plugin 예외는 storage failure를 반환한다', () async {
      when(
        () => localDataSource.getAccessToken(),
      ).thenThrow(MissingPluginException('secure storage unavailable'));

      final result = await repository.restoreSession().run();

      expect(result.isLeft(), true);
      result.match((failure) {
        expect(failure, const AuthFailure.common(CommonFailure.storage()));
      }, (_) => fail('Left expected'));
    });
  });

  group('signOut', () {
    test('토큰을 삭제하고 unit을 반환한다', () async {
      when(() => localDataSource.clearTokens()).thenAnswer((_) async {});

      final result = await repository.signOut().run();

      expect(result.isRight(), true);
      verify(() => localDataSource.clearTokens()).called(1);
    });

    test('storage platform 예외는 storage failure를 반환한다', () async {
      when(
        () => localDataSource.clearTokens(),
      ).thenThrow(PlatformException(code: 'storage_error'));

      final result = await repository.signOut().run();

      expect(result.isLeft(), true);
      result.match((failure) {
        expect(failure, const AuthFailure.common(CommonFailure.storage()));
      }, (_) => fail('Left expected'));
    });
  });
}
