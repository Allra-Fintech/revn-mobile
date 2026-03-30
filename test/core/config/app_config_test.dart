import 'package:flutter_test/flutter_test.dart';
import 'package:revn/core/config/app_config.dart';

void main() {
  group('AppEnvironment.fromValue', () {
    test('parses dev', () {
      expect(AppEnvironment.fromValue('dev'), AppEnvironment.dev);
    });

    test('parses staging', () {
      expect(AppEnvironment.fromValue('staging'), AppEnvironment.staging);
    });

    test('parses prod', () {
      expect(AppEnvironment.fromValue('prod'), AppEnvironment.prod);
    });

    test('throws for unsupported values', () {
      expect(
        () => AppEnvironment.fromValue('development'),
        throwsArgumentError,
      );
    });
  });

  group('AppConfig.fromValues', () {
    test('normalizes trailing slash', () {
      final config = AppConfig.fromValues(
        environment: 'dev',
        baseUrl: 'https://api.example.com/',
      );

      expect(config.environment, AppEnvironment.dev);
      expect(config.baseUrl, 'https://api.example.com');
    });

    test('keeps base url without trailing slash', () {
      final config = AppConfig.fromValues(
        environment: 'staging',
        baseUrl: 'https://staging-api.example.com',
      );

      expect(config.environment, AppEnvironment.staging);
      expect(config.baseUrl, 'https://staging-api.example.com');
    });

    test('throws when base url is empty', () {
      expect(
        () => AppConfig.fromValues(environment: 'prod', baseUrl: ''),
        throwsArgumentError,
      );
    });
  });
}
