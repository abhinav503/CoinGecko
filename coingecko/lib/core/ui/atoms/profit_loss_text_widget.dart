import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/utils/price_formatter.dart';
import 'package:flutter/material.dart';

class ProfitLossTextWidget extends StatelessWidget {
  final double value;
  final bool showSign;
  final TextStyle? textStyle;
  const ProfitLossTextWidget({
    super.key,
    required this.value,
    this.showSign = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      showSign
          ? value > 0
              ? "+${PriceFormatter.formatPrice(value, context: context)}"
              : PriceFormatter.formatPrice(value, context: context)
          : "${value > 0 ? "+" : ""} ${PriceFormatter.formatPrice(value, context: context)} %",
      style:
          textStyle ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: value > 0 ? AppColors.successColor : AppColors.errorColor,
          ),
    );
  }
}
