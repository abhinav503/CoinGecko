import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/enums/screen_type.dart';
import 'package:coingecko/core/ui/atoms/primary_button.dart';
import 'package:coingecko/core/ui/atoms/profit_loss_text_widget.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinDetailsTile extends StatelessWidget {
  final CoinItemEntity coin;
  const CoinDetailsTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenType screenType = ScreenType.mobileSmall;
        screenType = screenType.getDeviceType(context);
        print("CoinDetailsTile: $screenType");
        return screenType == ScreenType.mobileSmall
            ? const SizedBox.shrink()
            : Container(
              decoration: const BoxDecoration(
                color: WebAppbarColors.backgroundColor,
                border: Border(
                  left: BorderSide(
                    color: WebAppbarColors.appbarTextColor,
                    width: 0.25,
                  ),
                ),
              ),
              width:
                  [
                        ScreenType.mobileSmall,
                        ScreenType.mobileLarge,
                      ].contains(screenType)
                      ? MediaQuery.of(context).size.width - 400.w
                      : MediaQuery.of(context).size.width - 800.w,
              height: 70.h,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 50.w,
                      right: 50.w,
                      top: 10.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 150.w,
                          child: PrimaryButton(
                            padding: EdgeInsets.zero,
                            text: getBuyButtonText(screenType),
                            onPressed: () {},
                            color: AppColors.successColorLight,
                            textStyle: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: AppColors.primaryColorLight),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        SizedBox(
                          height: 50.h,
                          width: 150.w,
                          child: PrimaryButton(
                            padding: EdgeInsets.zero,
                            text: getSellButtonText(screenType),
                            onPressed: () {},
                            color: AppColors.errorColor,
                            textStyle: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: AppColors.primaryColorLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }

  getBuyButtonText(ScreenType screenType) {
    if (screenType == ScreenType.mobileLarge) {
      return StringConstants.buy;
    }
    if (screenType == ScreenType.mobileSmall) {
      return "B";
    }
    return "${StringConstants.buy} ${coin.symbol?.toUpperCase()}";
  }

  getSellButtonText(ScreenType screenType) {
    if (screenType == ScreenType.mobileLarge) {
      return StringConstants.sell;
    }
    if (screenType == ScreenType.mobileSmall) {
      return "S";
    }
    return "${StringConstants.sell} ${coin.symbol?.toUpperCase()}";
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
