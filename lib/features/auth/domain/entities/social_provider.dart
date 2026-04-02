enum SocialProvider {
  kakao(
    id: 'kakao',
    displayName: '카카오',
    buttonLabel: '카카오 로그인',
    iconKey: 'kakao',
  );

  const SocialProvider({
    required this.id,
    required this.displayName,
    required this.buttonLabel,
    required this.iconKey,
  });

  final String id;
  final String displayName;
  final String buttonLabel;
  final String iconKey;

  String get signInPath => '/auth/$id/sign-in';

  String get linkPath => '/auth/$id/link';

  static SocialProvider? fromSignInPath(String path) {
    for (final provider in values) {
      if (provider.signInPath == path) {
        return provider;
      }
    }

    return null;
  }
}
