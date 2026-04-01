import 'package:freezed_annotation/freezed_annotation.dart';

import 'social_provider.dart';

part 'pending_social_link.freezed.dart';

enum SocialLinkStatus { pending, linking, failed }

@freezed
sealed class PendingSocialLink with _$PendingSocialLink {
  const factory PendingSocialLink({
    required SocialProvider provider,
    required String accessToken,
    @Default(SocialLinkStatus.pending) SocialLinkStatus linkStatus,
    String? lastErrorMessage,
  }) = _PendingSocialLink;
}
