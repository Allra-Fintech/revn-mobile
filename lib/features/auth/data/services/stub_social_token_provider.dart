import '../../domain/entities/social_provider.dart';
import '../../domain/services/social_token_provider.dart';
import '../fixtures/auth_mock_fixtures.dart';

class StubSocialTokenProvider implements SocialTokenProvider {
  @override
  Future<String> getAccessToken(SocialProvider provider) async {
    return switch (provider) {
      SocialProvider.kakao => AuthMockFixtures.unlinkedKakaoAccessToken,
    };
  }
}
