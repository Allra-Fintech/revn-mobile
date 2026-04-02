import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/data/datasources/dio_auth_remote_data_source.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late DioAuthRemoteDataSource dataSource;

  setUp(() {
    dio = MockDio();
    dataSource = DioAuthRemoteDataSource(dio);
  });

  group('verifyBusinessNumber', () {
    test('posts business number verification request', () async {
      final capturedBodies = <Map<String, dynamic>>[];

      when(
        () => dio.post<void>(
          '/auth/business-number/verify',
          data: any(named: 'data'),
        ),
      ).thenAnswer((invocation) async {
        capturedBodies.add(
          Map<String, dynamic>.from(
            invocation.namedArguments[#data] as Map<dynamic, dynamic>,
          ),
        );

        return Response<void>(
          requestOptions: RequestOptions(path: '/auth/business-number/verify'),
        );
      });

      await dataSource.verifyBusinessNumber(businessNumber: '1234567890');

      expect(capturedBodies.single, {'businessNumber': '1234567890'});
    });
  });

  group('signIn', () {
    test('posts serialized credentials and parses the response dto', () async {
      final capturedBodies = <Map<String, dynamic>>[];

      when(
        () => dio.post<Map<String, dynamic>>(
          '/auth/sign-in',
          data: any(named: 'data'),
        ),
      ).thenAnswer((invocation) async {
        capturedBodies.add(
          Map<String, dynamic>.from(
            invocation.namedArguments[#data] as Map<dynamic, dynamic>,
          ),
        );

        return Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/sign-in'),
          data: const {
            'accessToken': 'access-token',
            'refreshToken': 'refresh-token',
            'user': {
              'id': '1',
              'businessNumber': '1234567890',
              'username': 'Mock Owner',
            },
          },
        );
      });

      final response = await dataSource.signIn(
        businessNumber: '1234567890',
        password: '1234',
      );

      expect(capturedBodies.single, {
        'businessNumber': '1234567890',
        'password': '1234',
      });
      expect(response.accessToken, 'access-token');
      expect(response.refreshToken, 'refresh-token');
      expect(response.user.businessNumber, '1234567890');
      expect(response.user.username, 'Mock Owner');
    });

    test('throws FormatException when sign-in response data is null', () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          '/auth/sign-in',
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/sign-in'),
        ),
      );

      await expectLater(
        () => dataSource.signIn(businessNumber: '1234567890', password: '1234'),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('signInWithSocial', () {
    test(
      'posts provider-based social token and parses the response dto',
      () async {
        final capturedBodies = <Map<String, dynamic>>[];

        when(
          () => dio.post<Map<String, dynamic>>(
            SocialProvider.kakao.signInPath,
            data: any(named: 'data'),
          ),
        ).thenAnswer((invocation) async {
          capturedBodies.add(
            Map<String, dynamic>.from(
              invocation.namedArguments[#data] as Map<dynamic, dynamic>,
            ),
          );

          return Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(
              path: SocialProvider.kakao.signInPath,
            ),
            data: const {
              'accessToken': 'access-token',
              'refreshToken': 'refresh-token',
              'user': {
                'id': '1',
                'businessNumber': '1234567890',
                'username': 'Mock Owner',
              },
            },
          );
        });

        final response = await dataSource.signInWithSocial(
          provider: SocialProvider.kakao,
          accessToken: 'social-access-token',
        );

        expect(capturedBodies.single, {'accessToken': 'social-access-token'});
        expect(response.accessToken, 'access-token');
        expect(response.user.username, 'Mock Owner');
      },
    );
  });

  group('signUp', () {
    test('posts serialized credentials and parses the response dto', () async {
      final capturedBodies = <Map<String, dynamic>>[];

      when(
        () => dio.post<Map<String, dynamic>>(
          '/auth/sign-up',
          data: any(named: 'data'),
        ),
      ).thenAnswer((invocation) async {
        capturedBodies.add(
          Map<String, dynamic>.from(
            invocation.namedArguments[#data] as Map<dynamic, dynamic>,
          ),
        );

        return Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/sign-up'),
          data: const {
            'accessToken': 'access-token',
            'refreshToken': 'refresh-token',
            'user': {
              'id': '1',
              'businessNumber': '1234567890',
              'username': 'New Owner',
            },
          },
        );
      });

      final response = await dataSource.signUp(
        businessNumber: '1234567890',
        password: '1234',
      );

      expect(capturedBodies.single, {
        'businessNumber': '1234567890',
        'password': '1234',
      });
      expect(response.accessToken, 'access-token');
      expect(response.refreshToken, 'refresh-token');
      expect(response.user.businessNumber, '1234567890');
      expect(response.user.username, 'New Owner');
    });

    test('throws FormatException when sign-up response data is null', () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          '/auth/sign-up',
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/sign-up'),
        ),
      );

      await expectLater(
        () => dataSource.signUp(businessNumber: '1234567890', password: '1234'),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('getMe', () {
    test(
      'requests the current user with bearer auth and parses the response dto',
      () async {
        final capturedOptions = <Options?>[];

        when(
          () => dio.get<Map<String, dynamic>>(
            '/auth/me',
            options: any(named: 'options'),
          ),
        ).thenAnswer((invocation) async {
          capturedOptions.add(invocation.namedArguments[#options] as Options?);

          return Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/auth/me'),
            data: const {
              'id': '1',
              'businessNumber': '1234567890',
              'username': 'Mock Owner',
            },
          );
        });

        final user = await dataSource.getMe(appAccessToken: 'app-access-token');

        expect(user.id, '1');
        expect(user.businessNumber, '1234567890');
        expect(user.username, 'Mock Owner');
        expect(
          capturedOptions.single?.headers,
          containsPair('Authorization', 'Bearer app-access-token'),
        );
      },
    );

    test('throws FormatException when getMe response data is null', () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          '/auth/me',
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/me'),
        ),
      );

      await expectLater(
        () => dataSource.getMe(appAccessToken: 'app-access-token'),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('linkSocialAccount', () {
    test('posts social link request with bearer auth', () async {
      final capturedBodies = <Map<String, dynamic>>[];
      final capturedOptions = <Options?>[];

      when(
        () => dio.post<void>(
          SocialProvider.kakao.linkPath,
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((invocation) async {
        capturedBodies.add(
          Map<String, dynamic>.from(
            invocation.namedArguments[#data] as Map<dynamic, dynamic>,
          ),
        );
        capturedOptions.add(invocation.namedArguments[#options] as Options?);

        return Response<void>(
          requestOptions: RequestOptions(path: SocialProvider.kakao.linkPath),
        );
      });

      await dataSource.linkSocialAccount(
        provider: SocialProvider.kakao,
        accessToken: 'social-access-token',
        appAccessToken: 'app-access-token',
      );

      expect(capturedBodies.single, {'accessToken': 'social-access-token'});
      expect(
        capturedOptions.single?.headers,
        containsPair('Authorization', 'Bearer app-access-token'),
      );
    });
  });
}
