import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/molecules/custom_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinSelectedWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final double? height;
  const CoinSelectedWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.symbol,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 70.h,
      color:
          kIsWeb ? WebAppbarColors.appbarBackgroundColor : Colors.transparent,
      child: ListTile(
        dense: true,
        leading: CustomNetworkImage(imageUrl: imageUrl),
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color:
                kIsWeb
                    ? WebAppbarColors.appbarTextColor
                    : AppColors.primaryTextColor,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              "${symbol.toUpperCase()} ",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color:
                    kIsWeb
                        ? WebAppbarColors.appbarTextColor
                        : AppColors.primaryTextColor,
              ),
            ),
            CircleAvatar(
              radius: 3.r,
              backgroundColor:
                  kIsWeb
                      ? WebAppbarColors.appbarTextColor
                      : AppColors.primaryTextColor,
            ),
            Text(
              " ${StringConstants.usd}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color:
                    kIsWeb
                        ? WebAppbarColors.appbarTextColor
                        : AppColors.primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
