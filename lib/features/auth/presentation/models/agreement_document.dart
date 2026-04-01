enum AgreementDocument {
  serviceTerms(title: '서비스 이용약관', url: 'https://docs.revn.co.kr/terms'),
  privacyCollection(
    title: '개인정보 수집 및 이용동의',
    url: 'https://docs.revn.co.kr/privacy',
  ),
  privacySharing(
    title: '개인정보 제공 및 위탁동의',
    url: 'https://docs.revn.co.kr/third-party',
  );

  const AgreementDocument({required this.title, required this.url});

  final String title;
  final String url;

  Uri get uri => Uri.parse(url);
}
