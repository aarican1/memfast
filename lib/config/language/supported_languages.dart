import 'dart:ui';

final class SupportedLanguages {
  SupportedLanguages._init();

  static final SupportedLanguages _instance = SupportedLanguages._init();

  factory SupportedLanguages() {
    return _instance;
  }

  final Locale enLang = const Locale('en', 'US');
  final Locale trLang = const Locale('tr', 'TR');

  Locale getLocale(String languageCode) {
    switch (languageCode) {
      case 'en':
        return enLang;
      case 'tr':
        return trLang;
      default:
        return enLang;
    }
  }

  List<Locale> get supportedLanguages => [enLang, trLang];
}
