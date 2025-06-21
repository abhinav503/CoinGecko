import 'package:coingecko/core/base/base_screen.dart';
import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/currency_constants.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/core/enums/screen_type.dart';
import 'package:coingecko/core/ui/atoms/primary_button.dart';
import 'package:coingecko/core/ui/atoms/profit_loss_text_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_tabbar.dart';
import 'package:coingecko/core/utils/price_formatter.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_overview.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_price_chart.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinDetailsScreen extends BaseScreen {
  final MarketCoinEntity coin;
  const CoinDetailsScreen({super.key, required this.coin});

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends BaseScreenState<CoinDetailsScreen>
    with TickerProviderStateMixin {
  CoinDetailsBloc get getBloc => context.read<CoinDetailsBloc>();
  late TabController tabController;
  bool isInit = true;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getBloc.coinItemEntity = widget.coin;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      getBloc.add(
        GetCoinMarketDataEvent(
          id: widget.coin.id ?? "",
          vsCurrency: CurrencyConstants.getCurrencyForCoinGecko(
            Localizations.localeOf(context),
          ),
        ),
      );
      isInit = false;
    }
  }

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenType screenType = ScreenType.mobileSmall;
        screenType = screenType.getDeviceType(context);
        if ([ScreenType.desktop, ScreenType.tablet].contains(screenType)) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   Routes.webHome,
            //   arguments: widget.id,
            //   (route) => false,
            // );
          });
        }
        return BlocConsumer<CoinDetailsBloc, CoinDetailsState>(
          listener: (context, state) {
            if (state is CoinDetailsApiErrorState) {
              showToast(state.message);
            }
          },
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
                        PriceFormatter.formatPrice(
                          getBloc.coinItemEntity?.currentPrice,
                          context: context,
                        ),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 5.h),
                      getPriceChangePercentageWidget(),
                      SizedBox(height: 40.h),
                      CoinPriceChart(
                        id: widget.coin.id ?? "",
                        marketData: getBloc.coinMarketDataEntity!,
                        selectedFilter: getBloc.currentFilter,
                        onFilterChanged: getBloc.onTimeFilterChanged,
                        coin: widget.coin,
                      ),
                      SizedBox(height: 20.h),
                      CustomTabbar(
                        showIndicator: false,
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
                      CoinOverview(
                        coinItemEntity: getBloc.coinItemEntity!,
                        tabController: tabController,
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
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: AppColors.primaryButtonTextColor),
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
      },
    );
  }

  getPriceChangePercentageWidget() {
    double? priceChange24h = getBloc.coinItemEntity!.priceChange24h!;
    double? priceChangePercentage24h =
        getBloc.coinItemEntity!.priceChangePercentage24h!;
    switch (getBloc.currentFilter) {
      case MarketChartTimeFilter.oneDay:
        priceChange24h = getBloc.coinItemEntity!.priceChange24h!;
        priceChangePercentage24h =
            getBloc.coinItemEntity!.priceChangePercentage24h!;
        break;
      case MarketChartTimeFilter.oneWeek:
        priceChange24h = getBloc.coinItemEntity!.priceChange24h!;
        priceChangePercentage24h =
            getBloc.coinItemEntity!.priceChangePercentage7d ?? 0.0;
        break;
      case MarketChartTimeFilter.oneMonth:
        priceChange24h = getBloc.coinItemEntity!.priceChange24h!;
        priceChangePercentage24h =
            getBloc.coinItemEntity!.priceChangePercentage30d ?? 0.0;
        break;
      case MarketChartTimeFilter.oneYear:
        priceChange24h = getBloc.coinItemEntity!.priceChange24h!;
        priceChangePercentage24h =
            getBloc.coinItemEntity!.priceChangePercentage1y ?? 0.0;
        break;
    }
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfitLossTextWidget(
            value: double.parse(
              PriceFormatter.formatNumber(
                priceChange24h,
                context: context,
              ).replaceAll(",", ""),
            ),
            showSign: true,
          ),
          VerticalDivider(color: Colors.grey, indent: 10.h, endIndent: 10.h),
          ProfitLossTextWidget(
            value: priceChangePercentage24h,
            showSign: false,
          ),
          VerticalDivider(color: Colors.grey, indent: 10.h, endIndent: 10.h),
          Text(
            getBloc.currentFilter.titleValue,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
