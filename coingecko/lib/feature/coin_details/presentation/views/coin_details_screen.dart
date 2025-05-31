import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/core/ui/atoms/primary_button.dart';
import 'package:coingecko/core/ui/atoms/primary_text_button.dart';
import 'package:coingecko/core/ui/atoms/profit_loss_text_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_tabbar.dart';
import 'package:coingecko/core/ui/molecules/info_tile.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_price_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class CoinDetailsScreen extends StatefulWidget {
  final String id;
  const CoinDetailsScreen({super.key, required this.id});

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen>
    with TickerProviderStateMixin {
  CoinDetailsBloc get getBloc => context.read<CoinDetailsBloc>();
  late TabController tabController;
  bool isDescriptionExpanded = false;
  final int maxDescriptionLines = 3;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getBloc.add(GetCoinDetailsEvent(id: widget.id));
    getBloc.add(GetCoinMarketDataEvent(id: widget.id));
    super.initState();
  }

  void _onTimeFilterChanged(MarketChartTimeFilter filter) {
    getBloc.add(UpdateTimeFilterEvent(filter: filter));
    getBloc.add(GetCoinMarketDataEvent(id: widget.id));
  }

  void _toggleDescription() {
    setState(() {
      isDescriptionExpanded = !isDescriptionExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
      builder: (context, state) {
        if (getBloc.coinItemEntity == null ||
            getBloc.coinMarketDataEntity == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    "\$${getBloc.coinItemEntity?.currentPrice.toString() ?? ""}",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfitLossTextWidget(
                          value: getBloc.coinItemEntity!.priceChange24h!,
                          showSign: true,
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          indent: 10.h,
                          endIndent: 10.h,
                        ),
                        if (getBloc.coinItemEntity!.priceChangePercentage24h !=
                            null)
                          ProfitLossTextWidget(
                            value:
                                getBloc
                                    .coinItemEntity!
                                    .priceChangePercentage24h!,
                            showSign: false,
                          ),
                        VerticalDivider(
                          color: Colors.grey,
                          indent: 10.h,
                          endIndent: 10.h,
                        ),
                        Text(
                          getBloc.currentFilter.titleValue,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CoinPriceChart(
                    marketData: getBloc.coinMarketDataEntity!,
                    selectedFilter: getBloc.currentFilter,
                    onFilterChanged: _onTimeFilterChanged,
                  ),
                  SizedBox(height: 20.h),
                  CustomTabbar(
                    tabAlignment: TabAlignment.fill,
                    isScrollable: false,
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: AppColors.primaryColor),
                    height: 50,
                    tabs: const [
                      StringConstants.overview,
                      StringConstants.myInvestments,
                    ],
                    onTabChanged: (index) {
                      // tabController.animateTo(index);
                    },
                    tabController: tabController,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.h),
                    height:
                        isDescriptionExpanded
                            ? (getBloc.coinItemEntity!.description!.length /
                                    300) *
                                200
                            : 250.h,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getBloc.coinItemEntity!.description!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    maxLines:
                                        isDescriptionExpanded
                                            ? null
                                            : maxDescriptionLines,
                                    overflow:
                                        isDescriptionExpanded
                                            ? null
                                            : TextOverflow.ellipsis,
                                  ),
                                  if (getBloc
                                          .coinItemEntity!
                                          .description!
                                          .length >
                                      150)
                                    PrimaryTextButton(
                                      onPressed: _toggleDescription,
                                      text:
                                          isDescriptionExpanded
                                              ? StringConstants.showLess
                                              : StringConstants.showMore,
                                    ),
                                ],
                              ),
                            ),
                            InfoTile(
                              leading: HugeIcons.strokeRoundedRanking,
                              title: "Rank",
                              trailing:
                                  getBloc.coinItemEntity!.marketCapRank
                                      .toString(),
                            ),
                            InfoTile(
                              leading:
                                  HugeIcons.strokeRoundedPresentationBarChart01,
                              title: "Market Cap",
                              trailingWidget: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${(getBloc.coinItemEntity!.marketCap! / 10000000).toStringAsFixed(2)} Cr",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    " (${getBloc.coinItemEntity!.priceChangePercentage24h!}%)",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.copyWith(
                                      color:
                                          getBloc.coinItemEntity!.marketCap! > 0
                                              ? AppColors.successColor
                                              : AppColors.errorColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InfoTile(
                              title: "Total Volume",
                              trailing:
                                  "${(getBloc.coinItemEntity!.totalVolume! / 1000000).toStringAsFixed(2)} M",
                              leading: HugeIcons.strokeRoundedDatabase,
                            ),
                          ],
                        ),
                        const Text("My Investments"),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
            Positioned(
              bottom: 0.h,
              left: 20.w,
              child: Container(
                color: Colors.white,
                width: 340.w,
                height: 80.h,
                padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                child: PrimaryButton(
                  text: StringConstants.buy,
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primaryButtonTextColor,
                  ),
                  color: AppColors.successColorLight,
                  onPressed: () {},
                  width: double.infinity,
                  radius: 5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
