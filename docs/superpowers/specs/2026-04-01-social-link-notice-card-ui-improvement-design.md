# SocialLinkNoticeCard UI 개선 디자인

**날짜:** 2026-04-01  
**작성자:** AI Assistant  
**상태:** 승인됨

## 개요

소셜 로그인 후 계정 연동 상태를 사용자에게 알려주는 `SocialLinkNoticeCard` 위젯의 UI를 전체적으로 개선합니다. 디자인 시스템과의 일관성을 확보하고, 사용성을 향상시키며, 세련된 애니메이션을 추가합니다.

## 목표

1. 앱 디자인 시스템(`AppComponentThemes`)과의 일관성 확보
2. 사용자 경험 개선 (dismiss 기능, 버튼 레이아웃)
3. 부드러운 진입/퇴장 애니메이션 추가
4. 코드 품질 유지 및 기존 사용처 호환성

## 설계 결정사항

### 1. 상태 표현 방식
- **결정:** 상태에 관계없이 일관된 스타일 유지
- **근거:** 카드는 정보 전달이 주 목적이며, 텍스트 내용으로 충분히 성공/실패를 구분 가능

### 2. 버튼 레이아웃
- **결정:** 세로 배치 (Column)
- **근거:** 
  - 더 넉넉한 터치 영역 확보 (모바일 UX 개선)
  - 긴 버튼 레이블 수용 가능
  - 시각적 계층 구조 명확화

### 3. 디자인 시스템 일관성
- **결정:** `AppComponentThemes` 상수 사용
- **변경사항:**
  - Border radius: `16` → `24` (`AppComponentThemes.cardBorderRadius`)
  - Padding: `16` → `20` (더 넉넉한 여백)
  - 배경색: `surfaceContainerHighest` → `Colors.white`

### 4. Dismiss 기능
- **결정:** 완전 제거 방식
- **동작:** X 버튼 클릭 시 애니메이션과 함께 카드 제거 및 상태 초기화
- **조건부 표시:** `onDismiss` 콜백이 제공된 경우에만 X 버튼 표시

### 5. 애니메이션
- **결정:** Fade Only (단순 페이드 인/아웃)
- **진입:** 300ms, `Curves.easeOut`, 투명도 0.0 → 1.0
- **퇴장:** 250ms, `Curves.easeIn`, 투명도 1.0 → 0.0 + size transition

## 컴포넌트 구조

```
SocialLinkNoticeCard (StatefulWidget)
├─ AnimatedOpacity (fade 애니메이션)
│  └─ AnimatedSize (dismiss 애니메이션)
│     └─ Container (카드 컨테이너)
│        └─ Column
│           ├─ Row (상단 행)
│           │  ├─ Expanded
│           │  │  └─ Text (title, FontWeight.bold)
│           │  └─ IconButton (X 버튼, onDismiss가 있을 때만)
│           ├─ SizedBox(height: 8)
│           ├─ Text (description)
│           └─ if (hasActions)
│              ├─ SizedBox(height: 16)
│              └─ Column (액션 영역)
│                 ├─ FilledButton (primary, 전체 너비)
│                 ├─ SizedBox(height: 12)
│                 └─ OutlinedButton (secondary, 전체 너비)
```

## API 명세

### Constructor 파라미터

**기존 파라미터 (유지):**
- `String title` - 카드 제목
- `String description` - 카드 본문
- `String? primaryActionLabel` - Primary 버튼 레이블
- `VoidCallback? onPrimaryAction` - Primary 버튼 콜백
- `String? secondaryActionLabel` - Secondary 버튼 레이블
- `VoidCallback? onSecondaryAction` - Secondary 버튼 콜백

**새로운 파라미터:**
- `VoidCallback? onDismiss` - X 버튼 클릭 시 호출될 콜백 (null이면 X 버튼 미표시)

## 스타일 상세

### Container
- `padding`: `EdgeInsets.all(20)`
- `decoration`:
  - `color`: `Colors.white`
  - `borderRadius`: `BorderRadius.circular(24)` (from `AppComponentThemes.cardBorderRadius`)
  - `border`: `Border.all(color: colorScheme.outlineVariant)`

### Title (상단 행)
- `Text`: `Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)`
- X 버튼과 함께 Row로 배치, Expanded로 감싸기

### Close Button
- `IconButton`
- `icon`: `Icon(Icons.close, size: 20)`
- `color`: `colorScheme.onSurfaceVariant`
- `constraints`: `BoxConstraints()` (최소 크기 제약 제거)
- `padding`: `EdgeInsets.zero`
- `visualDensity`: `VisualDensity.compact`

### Description
- `Text`: `Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)`
- Title 아래 8px 여백

### Action Buttons
- **세로 배치:** Column으로 감싸기
- **버튼 간 여백:** 12px
- **버튼 너비:** 전체 너비 차지 (기본 FilledButton/OutlinedButton 동작)
- **상단 여백:** Description과 16px 간격

## 애니메이션 상세

### 상태 관리
```dart
bool _visible = false;

@override
void initState() {
  super.initState();
  // 다음 프레임에서 애니메이션 시작
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) setState(() => _visible = true);
  });
}
```

### Fade In 애니메이션
```dart
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOut,
  child: ...
)
```

### Dismiss 애니메이션
```dart
AnimatedSize(
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeIn,
  child: _visible ? actualContent : SizedBox.shrink(),
)
```

**Dismiss 플로우:**
1. X 버튼 클릭
2. `setState(() => _visible = false)`
3. AnimatedOpacity가 fade out 시작
4. AnimatedSize가 높이 축소 시작
5. 250ms 후 `onDismiss?.call()` 호출

## 영향 받는 파일

### 1. 수정할 파일
- `lib/features/auth/presentation/widgets/social_link_notice_card.dart`
  - StatelessWidget → StatefulWidget 변환
  - 애니메이션 로직 추가
  - 레이아웃 및 스타일 업데이트
  - `onDismiss` 파라미터 추가

### 2. 업데이트할 사용처
- `lib/features/auth/presentation/pages/sign_in_page.dart`
  - `onDismiss` 파라미터 추가 (Secondary 액션과 동일한 동작 연결)
  
- `lib/features/auth/presentation/pages/sign_up_page.dart`
  - `onDismiss` 파라미터 추가 (Secondary 액션과 동일한 동작 연결)

## 테스트 고려사항

- 위젯 테스트: 애니메이션 완료 후 콜백 호출 확인
- 통합 테스트: `sign_in_page`와 `sign_up_page`에서 dismiss 동작 확인
- 시각적 회귀 테스트: 골든 테스트 업데이트 필요 가능성

## 성공 기준

1. ✅ 카드가 부드럽게 페이드 인되어 나타남
2. ✅ X 버튼 클릭 시 부드럽게 사라지고 `onDismiss` 콜백 호출
3. ✅ 버튼이 세로로 배치되어 터치 영역이 넉넉함
4. ✅ 배경이 흰색이고 border radius가 24
5. ✅ `AppComponentThemes` 상수와 일관성 유지
6. ✅ 기존 사용처에서 정상 동작
7. ✅ 린터 에러 없음

## 구현 노트

- `StatefulWidget` 변환 시 `_SocialLinkNoticeCardState` 클래스 생성
- `addPostFrameCallback`을 사용하여 초기 렌더링 후 애니메이션 시작
- `AnimatedOpacity`와 `AnimatedSize`를 조합하여 부드러운 dismiss 효과
- X 버튼은 `onDismiss != null` 조건으로 표시 여부 결정
- 버튼 간격은 기존 16px에서 12px로 조정 (세로 배치 시 더 적절)
