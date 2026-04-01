import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/data/datasources/dio_auth_remote_data_source.dart';

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
    test('requests the current user and parses the response dto', () async {
      when(() => dio.get<Map<String, dynamic>>('/auth/me')).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/me'),
          data: const {
            'id': '1',
            'businessNumber': '1234567890',
            'username': 'Mock Owner',
          },
        ),
      );

      final user = await dataSource.getMe();

      expect(user.id, '1');
      expect(user.businessNumber, '1234567890');
      expect(user.username, 'Mock Owner');
      verify(() => dio.get<Map<String, dynamic>>('/auth/me')).called(1);
    });

    test('throws FormatException when getMe response data is null', () async {
      when(() => dio.get<Map<String, dynamic>>('/auth/me')).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/auth/me'),
        ),
      );

      await expectLater(dataSource.getMe, throwsA(isA<FormatException>()));
    });
  });
}
