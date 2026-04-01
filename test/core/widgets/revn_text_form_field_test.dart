import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/app/theme/app_theme.dart';
import 'package:revn/core/widgets/revn_text_form_field.dart';

void main() {
  Widget buildTestApp({required Widget child}) {
    return MaterialApp(
      theme: RevnTheme.light,
      home: Scaffold(body: Form(child: child)),
    );
  }

  testWidgets('label, hint, helper, suffixIcon을 TextFormField에 전달한다', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        child: const RevnTextFormField(
          labelText: '사업자번호',
          hintText: '123-45-67890',
          helperText: '숫자 10자리를 입력해주세요.',
          suffixIcon: Icon(Icons.business),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    final decoration = textField.decoration!;

    expect(find.byType(TextFormField), findsOneWidget);
    expect(decoration.labelText, '사업자번호');
    expect(decoration.hintText, '123-45-67890');
    expect(decoration.helperText, '숫자 10자리를 입력해주세요.');
    expect(decoration.suffixIcon, isA<Icon>());
  });

  testWidgets('전달한 key를 내부 TextFormField에 연결하고 validator를 실행한다', (
    tester,
  ) async {
    final fieldKey = GlobalKey<FormFieldState<String>>();

    await tester.pumpWidget(
      buildTestApp(
        child: RevnTextFormField(
          key: fieldKey,
          labelText: '비밀번호',
          validator: (value) {
            if ((value ?? '').isEmpty) {
              return '필수값입니다.';
            }

            return null;
          },
        ),
      ),
    );

    final field = tester.widget<TextFormField>(find.byType(TextFormField));

    expect(field.key, same(fieldKey));
    expect(fieldKey.currentState, isNotNull);
    expect(fieldKey.currentState!.validate(), isFalse);

    await tester.pump();

    expect(find.text('필수값입니다.'), findsOneWidget);
  });
}
