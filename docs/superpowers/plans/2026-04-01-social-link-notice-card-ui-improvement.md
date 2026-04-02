# SocialLinkNoticeCard UI 개선 구현 계획

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** SocialLinkNoticeCard 위젯의 UI를 개선하여 디자인 시스템 일관성 확보, 사용성 향상, 애니메이션 추가

**Architecture:** 기존 StatelessWidget을 StatefulWidget으로 변환하고, AnimatedOpacity와 AnimatedSize를 사용한 fade 애니메이션 추가. 버튼 레이아웃을 Row에서 Column으로 변경하고, dismiss 기능을 위한 X 버튼 추가.

**Tech Stack:** Flutter, Material Design 3, AnimatedOpacity, AnimatedSize

---

## 파일 구조

### 수정할 파일
1. `lib/features/auth/presentation/widgets/social_link_notice_card.dart`
   - StatelessWidget → StatefulWidget 변환
   - 애니메이션 상태 관리 추가
   - 레이아웃 및 스타일 업데이트
   - onDismiss 파라미터 추가

2. `lib/features/auth/presentation/pages/sign_in_page.dart`
   - SocialLinkNoticeCard에 onDismiss 파라미터 추가

3. `lib/features/auth/presentation/pages/sign_up_page.dart`
   - SocialLinkNoticeCard에 onDismiss 파라미터 추가

### 생성할 파일
4. `test/features/auth/presentation/widgets/social_link_notice_card_test.dart`
   - 위젯 테스트 (렌더링, 버튼 동작, 애니메이션, dismiss)

---

## Task 1: SocialLinkNoticeCard 위젯 테스트 작성

**Files:**
- Create: `test/features/auth/presentation/widgets/social_link_notice_card_test.dart`

- [ ] **Step 1.1: 기본 테스트 파일 생성 및 기본 렌더링 테스트 작성**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/presentation/widgets/social_link_notice_card.dart';

void main() {
  group('SocialLinkNoticeCard', () {
    testWidgets('renders title and description', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('renders with white background and border radius 24',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SocialLinkNoticeCard),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.white);
      expect(decoration.borderRadius, BorderRadius.circular(24));
    });
  });
}
```

- [ ] **Step 1.2: 테스트 실행하여 실패 확인**

Run: `flutter test test/features/auth/presentation/widgets/social_link_notice_card_test.dart`

Expected: FAIL - 현재 borderRadius가 16이므로 실패

- [ ] **Step 1.3: 버튼 렌더링 및 콜백 테스트 추가**

`test/features/auth/presentation/widgets/social_link_notice_card_test.dart`의 `group` 블록에 추가:

```dart
    testWidgets('renders primary and secondary buttons in column',
        (tester) async {
      var primaryCalled = false;
      var secondaryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
              primaryActionLabel: 'Primary',
              onPrimaryAction: () => primaryCalled = true,
              secondaryActionLabel: 'Secondary',
              onSecondaryAction: () => secondaryCalled = true,
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);

      // 버튼이 Column 안에 세로로 배치되어 있는지 확인
      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(SocialLinkNoticeCard),
          matching: find.byType(Column).last,
        ),
      );
      expect(column.children.whereType<FilledButton>().length, 1);
      expect(column.children.whereType<OutlinedButton>().length, 1);

      // 버튼 클릭 테스트
      await tester.tap(find.text('Primary'));
      expect(primaryCalled, true);

      await tester.tap(find.text('Secondary'));
      expect(secondaryCalled, true);
    });

    testWidgets('does not render buttons when no actions provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsNothing);
      expect(find.byType(OutlinedButton), findsNothing);
    });
```

- [ ] **Step 1.4: Dismiss 버튼 및 애니메이션 테스트 추가**

`test/features/auth/presentation/widgets/social_link_notice_card_test.dart`의 `group` 블록에 추가:

```dart
    testWidgets('shows dismiss button when onDismiss is provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
              onDismiss: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('does not show dismiss button when onDismiss is null',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('calls onDismiss when dismiss button is tapped',
        (tester) async {
      var dismissCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
              onDismiss: () => dismissCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(dismissCalled, true);
    });

    testWidgets('animates in with fade effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
            ),
          ),
        ),
      );

      // 초기 상태: opacity 0
      expect(
        tester
            .widget<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .opacity,
        0.0,
      );

      // 프레임 진행
      await tester.pump();

      // 애니메이션 시작: opacity가 1로 변경됨
      expect(
        tester
            .widget<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .opacity,
        1.0,
      );

      // 애니메이션 완료까지 대기
      await tester.pumpAndSettle();

      // 최종 상태: opacity 1
      expect(
        tester
            .widget<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .opacity,
        1.0,
      );
    });

    testWidgets('animates out when dismissed', (tester) async {
      var dismissCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLinkNoticeCard(
              title: 'Test Title',
              description: 'Test Description',
              onDismiss: () => dismissCalled = true,
            ),
          ),
        ),
      );

      // 초기 렌더링 완료
      await tester.pumpAndSettle();

      // Dismiss 버튼 탭
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      // Opacity가 0으로 변경됨
      expect(
        tester
            .widget<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .opacity,
        0.0,
      );

      // 애니메이션 완료까지 대기
      await tester.pumpAndSettle();

      // onDismiss 호출됨
      expect(dismissCalled, true);
    });
```

- [ ] **Step 1.5: 모든 테스트 실행하여 실패 확인**

Run: `flutter test test/features/auth/presentation/widgets/social_link_notice_card_test.dart`

Expected: 대부분의 테스트 FAIL (구현이 아직 안 되어 있음)

- [ ] **Step 1.6: 테스트 파일 커밋**

```bash
git add test/features/auth/presentation/widgets/social_link_notice_card_test.dart
git commit -m "test: add SocialLinkNoticeCard widget tests"
```

---

## Task 2: SocialLinkNoticeCard 위젯 구현

**Files:**
- Modify: `lib/features/auth/presentation/widgets/social_link_notice_card.dart`

- [ ] **Step 2.1: StatelessWidget을 StatefulWidget으로 변환**

`lib/features/auth/presentation/widgets/social_link_notice_card.dart` 전체 내용을:

```dart
import 'package:flutter/material.dart';
import 'package:revn/app/theme/app_component_themes.dart';

class SocialLinkNoticeCard extends StatefulWidget {
  const SocialLinkNoticeCard({
    super.key,
    required this.title,
    required this.description,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.onDismiss,
  });

  final String title;
  final String description;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final VoidCallback? onDismiss;

  @override
  State<SocialLinkNoticeCard> createState() => _SocialLinkNoticeCardState();
}

class _SocialLinkNoticeCardState extends State<SocialLinkNoticeCard> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  void _handleDismiss() {
    setState(() => _visible = false);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        widget.onDismiss?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasActions =
        (widget.primaryActionLabel != null && widget.onPrimaryAction != null) ||
        (widget.secondaryActionLabel != null &&
            widget.onSecondaryAction != null);

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
        child: _visible
            ? Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppComponentThemes.cardBorderRadius,
                  ),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (widget.onDismiss != null)
                          IconButton(
                            onPressed: _handleDismiss,
                            icon: const Icon(Icons.close, size: 20),
                            color: colorScheme.onSurfaceVariant,
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                    if (hasActions) ...[
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (widget.primaryActionLabel != null &&
                              widget.onPrimaryAction != null)
                            FilledButton(
                              onPressed: widget.onPrimaryAction,
                              child: Text(widget.primaryActionLabel!),
                            ),
                          if (widget.primaryActionLabel != null &&
                              widget.onPrimaryAction != null &&
                              widget.secondaryActionLabel != null &&
                              widget.onSecondaryAction != null)
                            const SizedBox(height: 12),
                          if (widget.secondaryActionLabel != null &&
                              widget.onSecondaryAction != null)
                            OutlinedButton(
                              onPressed: widget.onSecondaryAction,
                              child: Text(widget.secondaryActionLabel!),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
```

- [ ] **Step 2.2: 테스트 실행하여 통과 확인**

Run: `flutter test test/features/auth/presentation/widgets/social_link_notice_card_test.dart`

Expected: 모든 테스트 PASS

- [ ] **Step 2.3: 린터 확인**

Run: `flutter analyze lib/features/auth/presentation/widgets/social_link_notice_card.dart`

Expected: No issues found

- [ ] **Step 2.4: 위젯 구현 커밋**

```bash
git add lib/features/auth/presentation/widgets/social_link_notice_card.dart
git commit -m "feat: improve SocialLinkNoticeCard UI with animations and dismiss"
```

---

## Task 3: sign_in_page와 sign_up_page 업데이트

**Files:**
- Modify: `lib/features/auth/presentation/pages/sign_in_page.dart:68-98`
- Modify: `lib/features/auth/presentation/pages/sign_up_page.dart:123-152`

- [ ] **Step 3.1: sign_in_page에 onDismiss 파라미터 추가**

`lib/features/auth/presentation/pages/sign_in_page.dart`의 68-98 라인을:

```dart
                  if (pendingLink != null) ...[
                    SocialLinkNoticeCard(
                      title: shouldShowLinkFailureActions
                          ? '${pendingLink.provider.displayName} 연동을 완료하지 못했습니다'
                          : '${pendingLink.provider.displayName} 로그인은 완료되었습니다',
                      description: shouldShowLinkFailureActions
                          ? pendingLink.lastErrorMessage ??
                                '${pendingLink.provider.displayName} 계정 연동에 실패했습니다.'
                          : '${pendingLink.provider.displayName} 토큰은 이미 확보되었습니다.\n'
                                '사업자번호로 로그인하면 계정이 자동으로 연동됩니다.',
                      primaryActionLabel: shouldShowLinkFailureActions
                          ? '다시 시도'
                          : null,
                      onPrimaryAction: shouldShowLinkFailureActions
                          ? ref
                                .read(signInControllerProvider.notifier)
                                .retryPendingSocialLink
                          : null,
                      secondaryActionLabel: shouldShowLinkFailureActions
                          ? '나중에'
                          : '취소',
                      onSecondaryAction: shouldShowLinkFailureActions
                          ? ref
                                .read(signInControllerProvider.notifier)
                                .completeSignInWithoutSocialLink
                          : ref
                                .read(socialAuthControllerProvider.notifier)
                                .clearPendingLink,
                      onDismiss: shouldShowLinkFailureActions
                          ? ref
                                .read(signInControllerProvider.notifier)
                                .completeSignInWithoutSocialLink
                          : ref
                                .read(socialAuthControllerProvider.notifier)
                                .clearPendingLink,
                    ),
                    const SizedBox(height: 24),
                  ],
```

- [ ] **Step 3.2: sign_up_page에 onDismiss 파라미터 추가**

`lib/features/auth/presentation/pages/sign_up_page.dart`의 123-152 라인을:

```dart
                  if (pendingLink != null) ...[
                    SocialLinkNoticeCard(
                      title: shouldShowRetryActions
                          ? '${pendingLink.provider.displayName} 연동을 완료하지 못했습니다'
                          : '${pendingLink.provider.displayName} 계정을 연결하는 중입니다',
                      description: shouldShowRetryActions
                          ? pendingLink.lastErrorMessage ??
                                '${pendingLink.provider.displayName} 계정 연동에 실패했습니다.'
                          : '${pendingLink.provider.displayName} 로그인 후 회원가입이 완료되면 계정이 자동으로 연동됩니다.',
                      primaryActionLabel: shouldShowRetryActions
                          ? '다시 시도'
                          : null,
                      onPrimaryAction: shouldShowRetryActions
                          ? ref
                                .read(signUpControllerProvider.notifier)
                                .retryPendingSocialLink
                          : null,
                      secondaryActionLabel: shouldShowRetryActions
                          ? '나중에'
                          : '취소',
                      onSecondaryAction: shouldShowRetryActions
                          ? ref
                                .read(socialAuthControllerProvider.notifier)
                                .clearPendingLink
                          : ref
                                .read(socialAuthControllerProvider.notifier)
                                .clearPendingLink,
                      onDismiss: ref
                          .read(socialAuthControllerProvider.notifier)
                          .clearPendingLink,
                    ),
                    const SizedBox(height: 24),
                  ],
```

- [ ] **Step 3.3: 린터 확인**

Run: `flutter analyze lib/features/auth/presentation/pages/`

Expected: No issues found

- [ ] **Step 3.4: 페이지 업데이트 커밋**

```bash
git add lib/features/auth/presentation/pages/sign_in_page.dart lib/features/auth/presentation/pages/sign_up_page.dart
git commit -m "feat: add dismiss functionality to social link notice cards"
```

---

## Task 4: 통합 테스트 및 검증

**Files:**
- Test: All modified files

- [ ] **Step 4.1: 전체 위젯 테스트 실행**

Run: `flutter test`

Expected: 모든 테스트 PASS

- [ ] **Step 4.2: 앱 실행하여 시각적 확인 (dev 환경)**

Run: `flutter run --flavor dev --dart-define=APP_ENV=dev`

**확인 사항:**
1. SocialLinkNoticeCard가 부드럽게 페이드 인되어 나타나는지
2. 배경이 흰색이고 border radius가 24인지
3. 버튼이 세로로 배치되어 있는지
4. X 버튼을 클릭하면 부드럽게 사라지는지
5. 버튼 간격이 12px인지
6. 패딩이 20인지

- [ ] **Step 4.3: Hot reload로 변경사항 확인**

앱이 실행 중인 상태에서 sign_in 페이지 또는 sign_up 페이지로 이동하여 카드 동작 확인

- [ ] **Step 4.4: 린터 최종 확인**

Run: `flutter analyze`

Expected: No issues found

- [ ] **Step 4.5: 성공 기준 체크리스트 검증**

**체크리스트:**
- [ ] 카드가 부드럽게 페이드 인되어 나타남
- [ ] X 버튼 클릭 시 부드럽게 사라지고 `onDismiss` 콜백 호출
- [ ] 버튼이 세로로 배치되어 터치 영역이 넉넉함
- [ ] 배경이 흰색이고 border radius가 24
- [ ] `AppComponentThemes` 상수와 일관성 유지
- [ ] 기존 사용처에서 정상 동작
- [ ] 린터 에러 없음

- [ ] **Step 4.6: 최종 커밋 (검증 완료 표시)**

```bash
git add .
git commit -m "test: verify SocialLinkNoticeCard UI improvements" --allow-empty
```

---

## 완료 조건

✅ 모든 테스트 통과  
✅ 린터 에러 없음  
✅ 앱 실행 시 시각적으로 정상 동작 확인  
✅ 성공 기준 7가지 모두 충족  
✅ 커밋 4개 생성 완료

## 참고 사항

- **TDD 원칙:** 테스트 먼저 작성 → 구현 → 검증 → 커밋
- **DRY:** 중복 코드 없음 (AnimatedOpacity와 AnimatedSize로 애니메이션 재사용)
- **YAGNI:** 불필요한 기능 추가 안 함 (상태별 색상 구분은 제외)
- **Frequent commits:** 각 주요 단계마다 커밋

## 리뷰 시 주의사항

- `AppComponentThemes.cardBorderRadius` 사용 여부 확인
- 애니메이션 duration과 curve가 spec대로 구현되었는지 확인
- `onDismiss`가 null일 때 X 버튼이 숨겨지는지 확인
- 버튼이 Column으로 세로 배치되었는지 확인
