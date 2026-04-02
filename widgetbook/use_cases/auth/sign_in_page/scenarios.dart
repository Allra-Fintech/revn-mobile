import 'package:revn/features/auth/application/states/social_auth_state.dart';
import 'package:revn/features/auth/domain/entities/pending_social_link.dart';
import 'package:revn/features/auth/domain/entities/social_provider.dart';

import '../../../src/preview/auth/auth_preview_config.dart';

const signInPageBasicConfig = AuthPreviewConfig();

const signInPageSocialNotLinkedConfig = AuthPreviewConfig(
  socialAuthState: SocialAuthState(
    pendingLink: PendingSocialLink(
      provider: SocialProvider.kakao,
      accessToken: 'widgetbook-kakao-token',
    ),
  ),
);
