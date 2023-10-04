class CPFCaptchaModel {
  final String html;
  final String cookie;
  final String userAgent;

  CPFCaptchaModel({
    required this.html,
    required this.cookie,
    required this.userAgent,
  });

  Map<String, String> get headers => {
        'Cookie': cookie,
        'User-Agent': userAgent,
      };

  factory CPFCaptchaModel.fromJson(
      String body, Map<String, String> requestHeader, Map<String, String> responseHeader) {
    String cookie = '';
    if (responseHeader.isNotEmpty) {
      for (String key in responseHeader.keys) {
        if (key == 'set-cookie') {
          final splitted = (responseHeader[key] ?? '').split(' ');
          if (splitted.length >= 3) {
            cookie = '${splitted[0]}${splitted[2].replaceAll('path=/,', ' ').replaceAll(';', '')}';
            break;
          }
        }
      }
    }
    return CPFCaptchaModel(
      html: body,
      userAgent: requestHeader['User-Agent']!,
      cookie: cookie,
    );
  }
}
// ASPSESSIONIDSGQBQRTB=LDEPCKCADNCIBFIMGPHGGKJA; BIGipServer~WEBREC~POOL_SERVICOS_REC_443=rd1o00000000000000000000ffffa194e747o443