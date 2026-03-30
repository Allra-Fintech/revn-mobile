enum AppEnvironment {
  dev('dev'),
  staging('staging'),
  prod('prod');

  const AppEnvironment(this.value);

  final String value;

  static AppEnvironment fromValue(String value) {
    return switch (value) {
      'dev' => AppEnvironment.dev,
      'staging' => AppEnvironment.staging,
      'prod' => AppEnvironment.prod,
      _ => throw ArgumentError.value(
        value,
        'APP_ENV',
        'must be one of: dev, staging, prod',
      ),
    };
  }
}

class AppConfig {
  const AppConfig({required this.environment, required this.baseUrl});

  factory AppConfig.fromEnvironment() {
    const rawEnvironment = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'dev',
    );
    const rawBaseUrl = String.fromEnvironment('APP_BASE_URL', defaultValue: '');

    return AppConfig.fromValues(
      environment: rawEnvironment,
      baseUrl: rawBaseUrl,
    );
  }

  factory AppConfig.fromValues({
    required String environment,
    required String baseUrl,
  }) {
    final normalizedBaseUrl = _normalizeBaseUrl(baseUrl);
    if (normalizedBaseUrl.isEmpty) {
      throw ArgumentError.value(
        baseUrl,
        'APP_BASE_URL',
        'must not be empty. Pass it with --dart-define=APP_BASE_URL=...',
      );
    }

    return AppConfig(
      environment: AppEnvironment.fromValue(environment),
      baseUrl: normalizedBaseUrl,
    );
  }

  final AppEnvironment environment;
  final String baseUrl;

  bool get isProd => environment == AppEnvironment.prod;

  static String _normalizeBaseUrl(String value) {
    if (value.endsWith('/')) {
      return value.substring(0, value.length - 1);
    }

    return value;
  }
}
