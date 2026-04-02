# revn-mobile

런타임 설정 주입에는 `dart-define`을,
앱 전역 의존성 연결에는 Riverpod을, 환경별 앱 식별 분리에는 모바일 flavor를 사용합니다.

## 개요

- 런타임 설정은 `--dart-define`으로 전달합니다.
- 앱 식별(이름·번들 등)은 Android/iOS flavor로 구분합니다.
- 앱 코드는 `AppConfig`와 `appConfigProvider`를 통해서만 설정을 읽습니다.

지원 환경:

- `dev`
- `staging`
- `prod`

## 환경 전략

환경 관련 책임을 두 층으로 나눕니다.

- **flavor**
  - 앱 이름, 번들 ID, 패키지 ID 등 플랫폼 수준 식별에 사용합니다.
  - Android·iOS에 구현되어 있습니다.
- **dart-define**
  - API 베이스 URL 등 런타임 값에 사용합니다.
  - `AppConfig.fromEnvironment()`에서 읽습니다.

실행·빌드 시 flavor와 dart-define을 함께 맞춰 사용하세요.

## 설정이 주입되는 방식

흐름은 다음과 같습니다.

`--dart-define` → `AppConfig.fromEnvironment()` → 부트스트랩에서 `appConfigProvider` 오버라이드

관련 코드:

- `lib/core/config/app_config.dart`
- `lib/app/bootstrap.dart`
- `lib/app/providers/app_providers.dart`

`AppConfig`가 노출하는 값:

- `environment: AppEnvironment`
- `baseUrl: String`
- `apiMode: AppApiMode`

`APP_ENV` 허용 값:

- `dev`
- `staging`
- `prod`

`APP_API_MODE` 허용 값:

- `mock`
- `real`

기본값:

- `APP_ENV=dev`면 `APP_API_MODE=mock`
- `APP_ENV=staging|prod`면 `APP_API_MODE=real`

`APP_BASE_URL`은 `real` 모드에서만 필수입니다. `mock` 모드에서는 비워둘 수 있습니다.

## 실행 명령

```bash
flutter run --flavor dev \
  --dart-define=APP_ENV=dev
```

```bash
flutter run --flavor dev \
  --dart-define=APP_ENV=dev \
  --dart-define=APP_API_MODE=real \
  --dart-define=APP_BASE_URL=https://dev-api.example.com
```

```bash
flutter run --flavor staging \
  --dart-define=APP_ENV=staging \
  --dart-define=APP_API_MODE=real \
  --dart-define=APP_BASE_URL=https://staging-api.example.com
```

```bash
flutter run --flavor prod \
  --dart-define=APP_ENV=prod \
  --dart-define=APP_API_MODE=real \
  --dart-define=APP_BASE_URL=https://api.example.com
```

### Flavor 동작

- Android 앱 이름: `Revn Dev`, `Revn Staging`, `Revn`
- Android 패키지 ID: `com.example.revn.dev`, `com.example.revn.staging`, `com.example.revn`
- iOS 표시 이름: `Revn Dev`, `Revn Staging`, `Revn`
- iOS 번들 ID: `com.example.revn.dev`, `com.example.revn.staging`, `com.example.revn`

## 런타임 설정 값 추가

새 런타임 설정을 넣을 때:

1. `AppConfig`에 필드를 추가합니다.
2. `AppConfig.fromEnvironment()`에서 읽습니다.
3. `AppConfig`에서 검증·정규화합니다.
4. 다른 곳에서 define을 직접 읽지 말고 `ref.watch(appConfigProvider)`로 사용합니다.
5. 파싱과 영향받는 UI·서비스 동작에 대한 테스트를 갱신합니다.
6. 필수 값이면 README 실행 예시도 함께 수정합니다.

패턴 예시:

```dart
const rawExample = String.fromEnvironment(
  'APP_EXAMPLE',
  defaultValue: '',
);
```

## 규칙과 주의사항

- `String.fromEnvironment`는 `AppConfig` 밖에서 읽지 마세요.
- flavor만으로 런타임 설정을 대체하지 마세요.
- 비밀 값을 Flutter 앱 번들에 넣지 마세요.
- `dart-define` 값이 숨겨진다고 가정하지 마세요. 검사 가능한 값으로 취급하세요.
- `APP_ENV`와 `--flavor`를 맞추세요.
  - 예: `--flavor staging`이면 `APP_ENV=staging`과 짝을 맞춥니다.
- `real` 모드에서 필수 설정이 없을 때 조용히 샘플 값을 쓰기보다, 빠르게 실패하는 편을 권장합니다.

Mock 인증 시나리오와 DTO 예시는 [docs/api-contracts/auth.md](/Users/allra_sangmin/Documents/github/revn-mobile/docs/api-contracts/auth.md)에 정리되어 있습니다.

## Build Runner (코드 생성)

이 프로젝트는 **build_runner**와 다음 생성기를 사용합니다.

- **riverpod_generator** — `@riverpod` 등 Riverpod 관련 코드
- **freezed** — 불변 모델·유니온 등
- **json_serializable** — `json_serializable` 어노테이션 기반 직렬화
- **widgetbook_generator** — Widgetbook use case 디렉터리 생성

### 한 번 생성

```bash
dart run build_runner build
```

기존 생성 파일과 충돌할 때(예: 재생성 필요) `--delete-conflicting-outputs`를 붙일 수 있습니다.

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 감시 모드 (저장 시 재생성)

개발 중에는 파일 변경을 감지해 자동으로 다시 생성합니다.

```bash
dart run build_runner watch --delete-conflicting-outputs
```

어노테이션이나 수동으로 편집한 `*.g.dart` / `*.freezed.dart` 등 생성물은 Git에 커밋하는지 팀 규칙에 맞추면 됩니다. 모델·프로바이더 시그니처를 바꾼 뒤에는 위 명령으로 생성 코드를 다시 맞추세요.

## Widgetbook

로컬 전용 Widgetbook 파일럿은 최상위 `widgetbook/` 디렉터리에 있습니다. 운영 엔트리포인트, 운영 라우터, 운영 부트스트랩에는 Widgetbook 전용 분기나 route를 추가하지 않습니다.

### 생성

```bash
dart run build_runner build --delete-conflicting-outputs
```

위 명령은 `widgetbook/widgetbook.directories.g.dart`까지 함께 생성합니다.

### 실행

```bash
flutter run -t widgetbook/main.dart
```

Widgetbook preview shell은 `RevnTheme.light`, dev/mock `AppConfig`, preview용 `Talker`, preview 라우터를 직접 주입하므로 flavor나 `--dart-define` 없이 실행할 수 있습니다.

### 파일 구성

- 엔트리포인트: `widgetbook/main.dart`
- 루트 앱 정의: `widgetbook/widgetbook.dart`
- preview state / override: `widgetbook/src/preview/`
- auth use case: `widgetbook/use_cases/auth/`

### use case 추가 규칙

- 새 페이지가 생기면 해당 페이지의 Widgetbook use case도 같이 추가합니다.
- 같은 페이지에서 큰 상태 변화가 생기면 기존 use case를 갱신하거나 새 use case를 추가합니다.
- Widgetbook preview state는 `widgetbook/src/preview/` 아래 dev-only override로 유지하고, `test/` helper를 재사용하지 않습니다.

## 테스트

```bash
flutter test
```

위젯 테스트에서는 `appConfigProvider`를 직접 오버라이드하고, `AppConfig`의 파싱·검증 로직은 단위 테스트로 다루는 것을 권장합니다.
