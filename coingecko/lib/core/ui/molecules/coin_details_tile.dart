import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/atoms/profit_loss_text_widget.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinDetailsTile extends StatelessWidget {
  final CoinItemEntity coin;
  const CoinDetailsTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: WebAppbarColors.backgroundColor,
        border: Border(
          left: BorderSide(color: WebAppbarColors.appbarTextColor, width: 0.25),
        ),
      ),
      width: MediaQuery.of(context).size.width - 800.w,
      height: 70.h,
      padding: EdgeInsets.only(left: 50.w, right: 10.w, top: 10.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleCoinDetailsValueTile(
            title: StringConstants.lastTradedPrice,
            value: coin.currentPrice ?? 0,
          ),
          SizedBox(width: 30.w),
          SingleCoinDetailsValueTile(
            title: StringConstants.change24h,
            value: coin.priceChangePercentage24h ?? 0,
            showProfitLoss: true,
          ),
          SizedBox(width: 30.w),
          SingleCoinDetailsValueTile(
            title: StringConstants.change24hHigh,
            value: coin.high24h ?? 0,
          ),
          SizedBox(width: 30.w),
          SingleCoinDetailsValueTile(
            title: StringConstants.change24hLow,
            value: coin.low24h ?? 0,
          ),
        ],
      ),
    );
  }
}

class SingleCoinDetailsValueTile extends StatelessWidget {
  final String title;
  final double value;
  final bool showProfitLoss;
  const SingleCoinDetailsValueTile({
    super.key,
    required this.title,
    required this.value,
    this.showProfitLoss = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: WebAppbarColors.headerSubTextColor,
          ),
        ),
        if (showProfitLoss)
          ProfitLossTextWidget(
            value: value,
            showSign: false,
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: value > 0 ? AppColors.successColor : AppColors.errorColor,
            ),
          ),
        if (!showProfitLoss)
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: WebAppbarColors.headerTextColor,
            ),
          ),
      ],
    );
  }
}
