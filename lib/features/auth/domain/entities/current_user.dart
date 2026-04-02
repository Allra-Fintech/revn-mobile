import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user.freezed.dart';

@freezed
sealed class CurrentUser with _$CurrentUser {
  const CurrentUser._();

  const factory CurrentUser({
    required String id,
    required String businessNumber,
    String? username,
  }) = _CurrentUser;

  @override
  String toString() {
    return 'CurrentUser('
        'hasId: ${id.isNotEmpty}, '
        'hasBusinessNumber: ${businessNumber.isNotEmpty}, '
        'hasUsername: ${username != null && username!.isNotEmpty}'
        ')';
  }
}
