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

enum AppApiMode {
  mock('mock'),
  real('real');

  const AppApiMode(this.value);

  final String value;

  static AppApiMode fromValue(String value) {
    return switch (value) {
      'mock' => AppApiMode.mock,
      'real' => AppApiMode.real,
      _ => throw ArgumentError.value(
        value,
        'APP_API_MODE',
        'must be one of: mock, real',
      ),
    };
  }
}

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.baseUrl,
    required this.apiMode,
  });

  factory AppConfig.fromEnvironment() {
    const rawEnvironment = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'dev',
    );
    const rawBaseUrl = String.fromEnvironment('APP_BASE_URL', defaultValue: '');
    const rawApiMode = String.fromEnvironment('APP_API_MODE', defaultValue: '');

    return AppConfig.fromValues(
      environment: rawEnvironment,
      baseUrl: rawBaseUrl,
      apiMode: rawApiMode,
    );
  }

  factory AppConfig.fromValues({
    required String environment,
    required String baseUrl,
    String apiMode = '',
  }) {
    final parsedEnvironment = AppEnvironment.fromValue(environment);
    final normalizedBaseUrl = _normalizeBaseUrl(baseUrl);
    final parsedApiMode = apiMode.isEmpty
        ? _defaultApiModeFor(parsedEnvironment)
        : AppApiMode.fromValue(apiMode);

    if (parsedApiMode == AppApiMode.real && normalizedBaseUrl.isEmpty) {
      throw ArgumentError.value(
        baseUrl,
        'APP_BASE_URL',
        'must not be empty in real mode. Pass it with '
            '--dart-define=APP_BASE_URL=...',
      );
    }

    return AppConfig(
      environment: parsedEnvironment,
      baseUrl: normalizedBaseUrl,
      apiMode: parsedApiMode,
    );
  }

  final AppEnvironment environment;
  final String baseUrl;
  final AppApiMode apiMode;

  bool get isProd => environment == AppEnvironment.prod;
  bool get usesMockApi => apiMode == AppApiMode.mock;

  static String _normalizeBaseUrl(String value) {
    if (value.endsWith('/')) {
      return value.substring(0, value.length - 1);
    }

    return value;
  }

  static AppApiMode _defaultApiModeFor(AppEnvironment environment) {
    return switch (environment) {
      AppEnvironment.dev => AppApiMode.mock,
      AppEnvironment.staging || AppEnvironment.prod => AppApiMode.real,
    };
  }
}
