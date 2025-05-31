import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/molecules/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinSelectedWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  const CoinSelectedWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      color: WebAppbarColors.appbarBackgroundColor,
      child: ListTile(
        dense: true,
        leading: CustomNetworkImage(imageUrl: imageUrl),
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: WebAppbarColors.appbarTextColor,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              "${symbol.toUpperCase()} ",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: WebAppbarColors.appbarTextColor,
              ),
            ),
            CircleAvatar(
              radius: 3.r,
              backgroundColor: WebAppbarColors.appbarTextColor,
            ),
            Text(
              " USD",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: WebAppbarColors.appbarTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
