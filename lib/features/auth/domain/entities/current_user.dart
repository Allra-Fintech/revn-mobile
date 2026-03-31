import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user.freezed.dart';

@freezed
sealed class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    required String id,
    required String businessNumber,
    String? nickname,
    String? profileImageUrl,
  }) = _CurrentUser;
}
