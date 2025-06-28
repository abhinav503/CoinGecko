import 'package:coingecko/core/colors/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NameSymbolWidget extends StatelessWidget {
  final String symbol;
  final String currency;
  final Color? textColor;
  const NameSymbolWidget({
    super.key,
    required this.symbol,
    required this.currency,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${symbol.toUpperCase()} ",
          style: TextStyle(
            fontSize: 12,
            color:
                textColor ??
                (kIsWeb
                    ? WebAppbarColors.appbarTextColor
                    : AppColors.primaryTextColor),
          ),
        ),
        CircleAvatar(
          radius: 3,
          backgroundColor:
              textColor ??
              (kIsWeb
                  ? WebAppbarColors.appbarTextColor
                  : AppColors.primaryTextColor),
        ),
        Text(
          " $currency",
          style: TextStyle(
            fontSize: 12,
            color:
                textColor ??
                (kIsWeb
                    ? WebAppbarColors.appbarTextColor
                    : AppColors.primaryTextColor),
          ),
        ),
      ],
    );
  }
}
