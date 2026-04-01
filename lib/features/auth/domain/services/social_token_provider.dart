import '../entities/social_provider.dart';

abstract interface class SocialTokenProvider {
  Future<String> getAccessToken(SocialProvider provider);
}
