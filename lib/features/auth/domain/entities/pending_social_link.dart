import 'package:freezed_annotation/freezed_annotation.dart';

import 'social_provider.dart';

part 'pending_social_link.freezed.dart';

enum SocialLinkStatus { pending, linking, failed }

@freezed
sealed class PendingSocialLink with _$PendingSocialLink {
  const PendingSocialLink._();

  const factory PendingSocialLink({
    required SocialProvider provider,
    required String accessToken,
    @Default(SocialLinkStatus.pending) SocialLinkStatus linkStatus,
    String? lastErrorMessage,
  }) = _PendingSocialLink;

  @override
  String toString() {
    return 'PendingSocialLink('
        'provider: $provider, '
        'hasAccessToken: ${accessToken.isNotEmpty}, '
        'linkStatus: $linkStatus, '
        'hasLastErrorMessage: ${lastErrorMessage != null && lastErrorMessage!.isNotEmpty}'
        ')';
  }
}
