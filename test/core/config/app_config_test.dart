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

  group('AppApiMode.fromValue', () {
    test('parses mock', () {
      expect(AppApiMode.fromValue('mock'), AppApiMode.mock);
    });

    test('parses real', () {
      expect(AppApiMode.fromValue('real'), AppApiMode.real);
    });

    test('throws for unsupported values', () {
      expect(() => AppApiMode.fromValue('fake'), throwsArgumentError);
    });
  });

  group('AppConfig.fromValues', () {
    test('normalizes trailing slash', () {
      final config = AppConfig.fromValues(
        environment: 'dev',
        baseUrl: 'https://api.example.com/',
        apiMode: 'real',
      );

      expect(config.environment, AppEnvironment.dev);
      expect(config.baseUrl, 'https://api.example.com');
      expect(config.apiMode, AppApiMode.real);
    });

    test('defaults dev environment to mock mode', () {
      final config = AppConfig.fromValues(environment: 'dev', baseUrl: '');

      expect(config.environment, AppEnvironment.dev);
      expect(config.baseUrl, '');
      expect(config.apiMode, AppApiMode.mock);
      expect(config.usesMockApi, isTrue);
    });

    test('defaults staging environment to real mode', () {
      final config = AppConfig.fromValues(
        environment: 'staging',
        baseUrl: 'https://staging-api.example.com',
      );

      expect(config.environment, AppEnvironment.staging);
      expect(config.baseUrl, 'https://staging-api.example.com');
      expect(config.apiMode, AppApiMode.real);
    });

    test('allows empty base url in mock mode', () {
      final config = AppConfig.fromValues(
        environment: 'prod',
        baseUrl: '',
        apiMode: 'mock',
      );

      expect(config.environment, AppEnvironment.prod);
      expect(config.baseUrl, '');
      expect(config.apiMode, AppApiMode.mock);
    });

    test('throws when real mode base url is empty', () {
      expect(
        () => AppConfig.fromValues(
          environment: 'prod',
          baseUrl: '',
          apiMode: 'real',
        ),
        throwsArgumentError,
      );
    });
  });
}
