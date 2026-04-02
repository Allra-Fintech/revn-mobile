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
  });
}
