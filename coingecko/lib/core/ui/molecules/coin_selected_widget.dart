import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/atoms/name_symbol_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinSelectedWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final double? height;
  final String currency;
  const CoinSelectedWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.symbol,
    this.height,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 70.h,
      width: kIsWeb ? 400.w : 330.h,
      decoration: const BoxDecoration(
        color:
            kIsWeb ? WebAppbarColors.appbarBackgroundColor : Colors.transparent,
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        leading: CustomNetworkImage(imageUrl: imageUrl),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 15,
            color:
                kIsWeb
                    ? WebAppbarColors.appbarTextColor
                    : AppColors.primaryTextColor,
          ),
        ),
        subtitle: NameSymbolWidget(symbol: symbol, currency: currency),
      ),
    );
  }
}
