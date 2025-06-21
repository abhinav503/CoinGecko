import 'package:coingecko/core/constants/currency_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(double? price, {BuildContext? context}) {
    if (price == null) return '\$0.00';
    final locale =
        context != null ? Localizations.localeOf(context).toString() : 'en_US';
    final languageCode = locale.split('_')[0];
    final currencySymbol = CurrencyConstants.getCurrencySymbol(languageCode);
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: currencySymbol,
      decimalDigits: 2,
    );

    return formatter.format(price).replaceAll(".00", "");
  }

  static String formatPercentage(double? percentage, {BuildContext? context}) {
    if (percentage == null) return '0.00%';

    // Get the device locale
    final locale =
        context != null ? Localizations.localeOf(context).toString() : 'en_US';

    final formatter = NumberFormat.decimalPattern(locale);
    return '${formatter.format(percentage)}%';
  }

  static String formatNumber(double? number, {BuildContext? context}) {
    if (number == null) return '0';

    // Get the device locale
    final locale =
        context != null ? Localizations.localeOf(context).toString() : 'en_US';

    final formatter = NumberFormat.decimalPattern(locale);
    return formatter.format(number);
  }
}
