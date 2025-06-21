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

      // Korean Won
      case 'ko':
        return '₩';

      // Brazilian Real
      case 'br':
        return 'R\$';

      // Russian Ruble
      case 'ru':
        return '₽';

      // Australian Dollar
      case 'au':
        return 'A\$';

      // Canadian Dollar
      case 'ca':
        return 'C\$';

      // Swiss Franc
      case 'ch':
        return 'CHF';

      // Swedish Krona
      case 'sv':
        return 'kr';

      // Norwegian Krone
      case 'nb':
      case 'nn':
        return 'kr';

      // Danish Krone
      case 'da':
        return 'kr';

      // Turkish Lira
      case 'tr':
        return '₺';

      // Polish Złoty
      case 'pl':
        return 'zł';

      // Czech Koruna
      case 'cs':
        return 'Kč';

      // Hungarian Forint
      case 'hu':
        return 'Ft';

      // Romanian Leu
      case 'ro':
        return 'lei';

      // Bulgarian Lev
      case 'bg':
        return 'лв';

      // Croatian Kuna
      case 'hr':
        return 'kn';

      // Serbian Dinar
      case 'sr':
        return 'дин';

      // Ukrainian Hryvnia
      case 'uk':
        return '₴';

      // Thai Baht
      case 'th':
        return '฿';

      // Vietnamese Dong
      case 'vi':
        return '₫';

      // Indonesian Rupiah
      case 'id':
        return 'Rp';

      // Malaysian Ringgit
      case 'ms':
        return 'RM';

      // Singapore Dollar
      case 'sg':
        return 'S\$';

      // Philippine Peso
      case 'tl':
      case 'ph':
        return '₱';

      // Mexican Peso
      case 'mx':
        return '\$';

      // Argentine Peso
      case 'ar':
        return '\$';

      // Chilean Peso
      case 'cl':
        return '\$';

      // Colombian Peso
      case 'co':
        return '\$';

      // Peruvian Sol
      case 'pe':
        return 'S/';

      // Uruguayan Peso
      case 'uy':
        return '\$';

      // Venezuelan Bolívar
      case 've':
        return 'Bs';

      // South African Rand
      case 'za':
      case 'af':
        return 'R';

      // Nigerian Naira
      case 'ng':
        return '₦';

      // Egyptian Pound
      case 'eg':
        return 'E£';

      // Saudi Riyal
      case 'sa':
        return 'ر.س';

      // UAE Dirham
      case 'ae':
        return 'د.إ';

      // Israeli Shekel
      case 'he':
        return '₪';

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

      // Korean Won
      Locale('ko', 'KR'),

      // Brazilian Real
      Locale('pt', 'BR'),

      // Russian Ruble
      Locale('ru', 'RU'),

      // Canadian Dollar
      Locale('en', 'CA'),
      Locale('fr', 'CA'),

      // Swiss Franc
      Locale('de', 'CH'),
      Locale('fr', 'CH'),
      Locale('it', 'CH'),

      // Swedish Krona
      Locale('sv', 'SE'),

      // Norwegian Krone
      Locale('nb', 'NO'),
      Locale('nn', 'NO'),

      // Danish Krone
      Locale('da', 'DK'),

      // Turkish Lira
      Locale('tr', 'TR'),

      // Polish Złoty
      Locale('pl', 'PL'),

      // Czech Koruna
      Locale('cs', 'CZ'),

      // Hungarian Forint
      Locale('hu', 'HU'),

      // Romanian Leu
      Locale('ro', 'RO'),

      // Bulgarian Lev
      Locale('bg', 'BG'),

      // Croatian Kuna
      Locale('hr', 'HR'),

      // Serbian Dinar
      Locale('sr', 'RS'),

      // Ukrainian Hryvnia
      Locale('uk', 'UA'),

      // Thai Baht
      Locale('th', 'TH'),

      // Vietnamese Dong
      Locale('vi', 'VN'),

      // Indonesian Rupiah
      Locale('id', 'ID'),

      // Malaysian Ringgit
      Locale('ms', 'MY'),

      // Philippine Peso
      Locale('tl', 'PH'),
      Locale('en', 'PH'),

      // Mexican Peso
      Locale('es', 'MX'),

      // Argentine Peso
      Locale('es', 'AR'),

      // Chilean Peso
      Locale('es', 'CL'),

      // Colombian Peso
      Locale('es', 'CO'),

      // Peruvian Sol
      Locale('es', 'PE'),

      // Uruguayan Peso
      Locale('es', 'UY'),

      // Venezuelan Bolívar
      Locale('es', 'VE'),

      // South African Rand
      Locale('en', 'ZA'),
      Locale('af', 'ZA'),

      // Nigerian Naira
      Locale('en', 'NG'),

      // Egyptian Pound
      Locale('ar', 'EG'),

      // Saudi Riyal
      Locale('ar', 'SA'),

      // UAE Dirham
      Locale('ar', 'AE'),

      // Israeli Shekel
      Locale('he', 'IL'),
    ];
  }
}
