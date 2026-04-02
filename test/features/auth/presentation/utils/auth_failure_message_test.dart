import 'package:flutter_test/flutter_test.dart';
import 'package:revn/core/errors/common_failure.dart';
import 'package:revn/features/auth/domain/failures/auth_failure.dart';
import 'package:revn/features/auth/presentation/utils/auth_failure_message.dart';

void main() {
  group('authFailureMessage', () {
    test('server failure message is sanitized for users', () {
      final message = authFailureMessage(
        const AuthFailure.common(CommonFailure.server('internal-db-trace')),
      );

      expect(message, '요청 처리 중 오류가 발생했습니다.');
    });

    test('unknown failure message is sanitized for users', () {
      final message = authFailureMessage(
        const AuthFailure.common(CommonFailure.unknown('raw exception')),
      );

      expect(message, '알 수 없는 오류가 발생했습니다.');
    });
  });
}
