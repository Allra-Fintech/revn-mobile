# Auth API Contract (Draft)

프론트 선개발을 위한 인증 API 초안입니다. 실제 백엔드가 준비되기 전까지 DTO와 mock data source는 이 문서를 기준으로 유지합니다.

## Endpoints

### `POST /auth/business-number/verify`

Request:

```json
{
  "businessNumber": "1234567890"
}
```

Success response:

```json
{}
```

Failure response examples:

```json
{
  "message": "이미 가입된 사업자번호입니다."
}
```

### `POST /auth/sign-in`

Request:

```json
{
  "businessNumber": "1234567890",
  "password": "1234"
}
```

Success response:

```json
{
  "accessToken": "mock-access-token",
  "refreshToken": "mock-refresh-token",
  "user": {
    "id": "mock-user-1",
    "businessNumber": "1234567890",
    "username": "Mock Owner"
  }
}
```

Failure response examples:

```json
{
  "message": "Mock invalid credentials."
}
```

### `POST /auth/sign-up`

Request:

```json
{
  "businessNumber": "1234567890",
  "password": "1234"
}
```

Success response:

```json
{
  "accessToken": "mock-sign-up-access-token",
  "refreshToken": "mock-sign-up-refresh-token",
  "user": {
    "id": "mock-user-sign-up",
    "businessNumber": "1234567890",
    "username": "New Owner"
  }
}
```

Failure response examples:

```json
{
  "message": "이미 가입된 사업자번호입니다."
}
```

### `GET /auth/me`

Success response:

```json
{
  "id": "mock-user-1",
  "businessNumber": "1234567890",
  "username": "Mock Owner"
}
```

## Mock Scenario Credentials

`MockAuthRemoteDataSource`는 아래 사업자번호로 시나리오를 전환합니다. 비밀번호는 모두 `1234`를 사용합니다.

- 사업자번호 인증 성공: `1234567890`
- 사업자번호 인증 성공 후 회원가입 중복: `4090000000`
- `1234567890`: 로그인 성공
- `2000000000`: 빈 프로필 상태 성공
- `4000000000`: validation error (`400`)
- `4010000000`: unauthorized (`401`)
- `4080000000`: connection timeout
- `4030000000` 또는 그 외 값: invalid credentials (`403`)

## Run Modes

- 개발 기본값: `APP_ENV=dev`이면 `APP_API_MODE=mock`
- 스테이징/프로덕션 기본값: `APP_API_MODE=real`
- `real` 모드에서는 `APP_BASE_URL`이 필수입니다.
