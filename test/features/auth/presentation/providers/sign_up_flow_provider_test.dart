import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revn/features/auth/presentation/providers/sign_up_flow_provider.dart';

void main() {
  test('markBusinessNumberVerified는 현재 입력값과 일치할 때만 인증 상태를 반영한다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(signUpFlowProvider.notifier);

    notifier.updateBusinessNumber('1234567890');
    notifier.updateBusinessNumber('4090000000');
    notifier.markBusinessNumberVerified('1234567890');

    final state = container.read(signUpFlowProvider);

    expect(state.verifiedBusinessNumber, isNull);
    expect(state.isBusinessNumberVerified, isFalse);
  });

  test('markBusinessNumberVerified는 전달받은 번호를 정규화해서 저장한다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(signUpFlowProvider.notifier);

    notifier.updateBusinessNumber('123-45-67890');
    notifier.markBusinessNumberVerified('123-45-67890');

    final state = container.read(signUpFlowProvider);

    expect(state.verifiedBusinessNumber, '1234567890');
    expect(state.isBusinessNumberVerified, isTrue);
  });
}
