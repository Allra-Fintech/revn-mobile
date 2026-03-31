import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/app/providers/app_providers.dart';
import 'package:revn/core/config/app_config.dart';
import 'package:revn/core/logging/app_talker.dart';
import 'package:revn/features/auth/application/providers/auth_providers.dart';
import 'package:revn/features/auth/data/datasources/dio_auth_remote_data_source.dart';
import 'package:revn/features/auth/data/datasources/mock_auth_remote_data_source.dart';

void main() {
  test('auth remote data source uses mock implementation in mock api mode', () {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig.fromValues(environment: 'dev', baseUrl: ''),
        ),
      ],
    );
    addTearDown(container.dispose);

    final dataSource = container.read(authRemoteDataSourceProvider);

    expect(dataSource, isA<MockAuthRemoteDataSource>());
  });

  test('auth remote data source uses dio implementation in real api mode', () {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig.fromValues(
            environment: 'prod',
            baseUrl: 'https://api.example.com',
            apiMode: 'real',
          ),
        ),
        talkerProvider.overrideWith((ref) => createTalker()),
      ],
    );
    addTearDown(container.dispose);

    final dataSource = container.read(authRemoteDataSourceProvider);

    expect(dataSource, isA<DioAuthRemoteDataSource>());
  });
}
