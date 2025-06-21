import 'dart:ui';

class CurrencyConstants {
  static String getCurrencySymbol(String languageCode) {
    switch (languageCode.toLowerCase()) {
      // US Dollar (default)
      case 'en':
        return '\$';

      // Euro
      case 'de':
      case 'fr':
      case 'it':
      case 'es':
      case 'pt':
      case 'nl':
      case 'be':
      case 'at':
      case 'fi':
      case 'ie':
      case 'lu':
      case 'mt':
      case 'si':
      case 'sk':
      case 'ee':
      case 'lv':
      case 'lt':
      case 'cy':
        return '€';

      // British Pound
      case 'gb':
        return '£';

      // Japanese Yen
      case 'ja':
        return '¥';

      // Chinese Yuan
      case 'zh':
        return '¥';

      // Indian Rupee
      case 'hi':
      case 'bn':
      case 'te':
      case 'mr':
      case 'ta':
      case 'gu':
      case 'kn':
      case 'ml':
      case 'pa':
      case 'or':
        return '₹';

      // Default to US Dollar
      default:
        return '\$';
    }
  }

  static List<Locale> getSupportedLocales() {
    return const [
      // US Dollar locales
      Locale('en', 'US'),
      Locale('en', 'CA'),
      Locale('en', 'AU'),
      Locale('en', 'SG'),
      Locale('en', 'ZA'),
      Locale('en', 'NG'),
      Locale('en', 'PH'),

      // Euro locales
      Locale('de', 'DE'),
      Locale('de', 'AT'),
      Locale('de', 'CH'),
      Locale('fr', 'FR'),
      Locale('fr', 'BE'),
      Locale('fr', 'CH'),
      Locale('fr', 'LU'),
      Locale('it', 'IT'),
      Locale('it', 'CH'),
      Locale('es', 'ES'),
      Locale('pt', 'PT'),
      Locale('nl', 'NL'),
      Locale('nl', 'BE'),
      Locale('fi', 'FI'),
      Locale('ie', 'IE'),
      Locale('mt', 'MT'),
      Locale('si', 'SI'),
      Locale('sk', 'SK'),
      Locale('ee', 'EE'),
      Locale('lv', 'LV'),
      Locale('lt', 'LT'),
      Locale('cy', 'GB'),

      // British Pound
      Locale('en', 'GB'),

      // Japanese Yen
      Locale('ja', 'JP'),

      // Chinese Yuan
      Locale('zh', 'CN'),
      Locale('zh', 'HK'),
      Locale('zh', 'TW'),

      // Indian Rupee
      Locale('hi', 'IN'),
      Locale('en', 'IN'),
      Locale('bn', 'IN'),
      Locale('te', 'IN'),
      Locale('mr', 'IN'),
      Locale('ta', 'IN'),
      Locale('gu', 'IN'),
      Locale('kn', 'IN'),
      Locale('ml', 'IN'),
      Locale('pa', 'IN'),
      Locale('or', 'IN'),
    ];
  }

  static String getCurrencyForCoinGecko(Locale locale) {
    switch (locale.languageCode) {
      // US
      case 'en':
        return 'usd';
      // Euro
      case 'de':
      case 'fr':
      case 'it':
      case 'es':
      case 'pt':
      case 'nl':
      case 'fi':
      case 'ie':
      case 'lv':
      case 'lt':
      case 'cy':
        return 'eur';
      // British Pound
      case 'gb':
        return 'gbp';
      // Japanese Yen
      case 'ja':
        return 'jpy';
      // Chinese Yuan
      case 'zh':
        return 'cny';
      // Indian Rupee
      case 'hi':
      case 'bn':
      case 'te':
      case 'mr':
      case 'ta':
      case 'gu':
      case 'kn':
      case 'ml':
      case 'pa':
      case 'or':
        return 'inr';

      default:
        return 'usd';
    }
  }
}
