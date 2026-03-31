import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revn/features/auth/data/datasources/auth_local_data_source.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage storage;
  late AuthLocalDataSource dataSource;

  setUp(() {
    storage = MockFlutterSecureStorage();
    dataSource = AuthLocalDataSource(storage);
  });

  group('saveTokens', () {
    test('stores access and refresh tokens with the expected keys', () async {
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await dataSource.saveTokens(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      );

      verifyInOrder([
        () => storage.write(key: 'auth.accessToken', value: 'access-token'),
        () => storage.write(key: 'auth.refreshToken', value: 'refresh-token'),
      ]);
    });
  });

  group('getAccessToken', () {
    test('reads the access token with the expected key', () async {
      when(
        () => storage.read(key: 'auth.accessToken'),
      ).thenAnswer((_) async => 'access-token');

      final token = await dataSource.getAccessToken();

      expect(token, 'access-token');
      verify(() => storage.read(key: 'auth.accessToken')).called(1);
    });
  });

  group('getRefreshToken', () {
    test('reads the refresh token with the expected key', () async {
      when(
        () => storage.read(key: 'auth.refreshToken'),
      ).thenAnswer((_) async => 'refresh-token');

      final token = await dataSource.getRefreshToken();

      expect(token, 'refresh-token');
      verify(() => storage.read(key: 'auth.refreshToken')).called(1);
    });
  });

  group('clearTokens', () {
    test('deletes both stored tokens', () async {
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await dataSource.clearTokens();

      verifyInOrder([
        () => storage.delete(key: 'auth.accessToken'),
        () => storage.delete(key: 'auth.refreshToken'),
      ]);
    });
  });
}
