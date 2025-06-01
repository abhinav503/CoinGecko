import 'package:coingecko/core/base/base_web_screen.dart';
import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/enums/screen_type.dart';
import 'package:coingecko/core/ui/molecules/coin_details_tile.dart';
import 'package:coingecko/core/ui/molecules/custom_web_tabbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_overview.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_price_chart.dart';
import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/home/presentation/view/home_screen.dart';
import 'package:coingecko/feature/web_home/presentation/bloc/web_home_bloc.dart';
import 'package:coingecko/feature/web_home/presentation/widgets/web_coin_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebHomeScreen extends BaseWebScreen {
  final String? selectedCoin;
  const WebHomeScreen({super.key, required this.selectedCoin});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends BaseWebScreenState<WebHomeScreen> {
  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenType screenType = ScreenType.mobileSmall;
        screenType = screenType.getDeviceType(context);
        return screenType == ScreenType.mobileSmall
            ? const HomeScreen()
            : WebHomeScreenWidget(
              screenType: screenType,
              showToast: showToast,
              selectedCoin: widget.selectedCoin,
            );
      },
    );
  }
}

class WebHomeScreenWidget extends StatefulWidget {
  final ScreenType screenType;
  final Function(String) showToast;
  final String? selectedCoin;
  const WebHomeScreenWidget({
    super.key,
    required this.screenType,
    required this.showToast,
    this.selectedCoin,
  });

  @override
  State<WebHomeScreenWidget> createState() => _WebHomeScreenWidgetState();
}

class _WebHomeScreenWidgetState extends State<WebHomeScreenWidget>
    with TickerProviderStateMixin {
  late HomeBloc homeBloc;
  late WebHomeBloc webHomeBloc;
  late CoinDetailsBloc coinDetailsBloc;
  late TabController tabController;
  late TabController infoTabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    infoTabController = TabController(length: 2, vsync: this);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    webHomeBloc = BlocProvider.of<WebHomeBloc>(context);
    coinDetailsBloc = BlocProvider.of<CoinDetailsBloc>(context);
    homeBloc.paginationScrollController.init(
      loadAction: homeBloc.onNextPageCall,
    );
    homeBloc.add(FetchMarketCoinsEvent(order: homeBloc.currentOrder));
  }

  @override
  void dispose() {
    infoTabController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is FetchMarketCoinsState) {
              homeBloc.paginationScrollController.isLoading = false;
              if (widget.screenType != ScreenType.mobileSmall) {
                int seletedCoinindex = homeBloc.marketCoins.indexWhere(
                  (element) => element.id == widget.selectedCoin,
                );
                if (seletedCoinindex == -1) {
                  seletedCoinindex = 0;
                }
                coinDetailsBloc.add(
                  GetCoinDetailsEvent(
                    id: homeBloc.marketCoins[seletedCoinindex].id ?? "",
                  ),
                );
                coinDetailsBloc.add(
                  GetCoinMarketDataEvent(
                    id: homeBloc.marketCoins[seletedCoinindex].id ?? "",
                  ),
                );
              }
            } else if (state is FetchMarketCoinsErrorState) {
              widget.showToast(state.message);
            }
          },
          builder: (context, state) {
            if (homeBloc.marketCoins.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WebCoinListview(
                    coins: homeBloc.marketCoins,
                    paginationController: homeBloc.paginationScrollController,
                    tabController: tabController,
                  ),
                  BlocConsumer<CoinDetailsBloc, CoinDetailsState>(
                    listener: (context, state) {
                      if (state is CoinDetailsApiErrorState) {
                        widget.showToast(state.message);
                      }
                    },
                    builder: (context, state) {
                      if (coinDetailsBloc.coinItemEntity != null &&
                          coinDetailsBloc.coinMarketDataEntity != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CoinDetailsTile(
                                  coin: coinDetailsBloc.coinItemEntity!,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 40.w,
                                    top: 50.h,
                                  ),
                                  width:
                                      [
                                            ScreenType.mobileSmall,
                                            ScreenType.mobileLarge,
                                          ].contains(widget.screenType)
                                          ? MediaQuery.of(context).size.width -
                                              400.w
                                          : MediaQuery.of(context).size.width -
                                              800.w,
                                  child: CoinPriceChart(
                                    padding: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.w,
                                      top: 40.h,
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height -
                                        340.h,
                                    marketData:
                                        coinDetailsBloc.coinMarketDataEntity!,
                                    selectedFilter:
                                        coinDetailsBloc.currentFilter,
                                    onFilterChanged:
                                        coinDetailsBloc.onTimeFilterChanged,
                                    id:
                                        coinDetailsBloc.coinItemEntity!.id ??
                                        "",
                                    tooltipTextStyle: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!.copyWith(
                                      color: WebAppbarColors.headerTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            [
                                  ScreenType.mobileSmall,
                                  ScreenType.mobileLarge,
                                ].contains(widget.screenType)
                                ? const SizedBox.shrink()
                                : Column(
                                  children: [
                                    SizedBox(
                                      width: 400.w,
                                      child: CustomWebTabbar(
                                        backgroundColor:
                                            AppColors.primaryColorLight,
                                        tabAlignment: TabAlignment.fill,
                                        isScrollable: false,
                                        showIndicator: false,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                        height: 60,
                                        tabs: const [
                                          StringConstants.overview,
                                          StringConstants.myInvestments,
                                        ],
                                        onTabChanged: (index) {
                                          // tabController.animateTo(index);
                                        },
                                        tabController: infoTabController,
                                        tabWidth: kIsWeb ? 120.w : null,
                                      ),
                                    ),
                                    CoinOverview(
                                      width: 400.w,
                                      coinItemEntity:
                                          coinDetailsBloc.coinItemEntity!,
                                      tabController: infoTabController,
                                    ),
                                  ],
                                ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
