import 'package:coingecko/core/base/base_web_screen.dart';
import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/molecules/coin_details_tile.dart';
import 'package:coingecko/core/ui/molecules/custom_web_tabbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_overview.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_price_chart.dart';
import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/web_home/presentation/bloc/web_home_bloc.dart';
import 'package:coingecko/feature/web_home/presentation/widgets/web_coin_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebHomeScreen extends BaseWebScreen {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends BaseWebScreenState<WebHomeScreen>
    with TickerProviderStateMixin {
  late HomeBloc homeBloc;
  late WebHomeBloc webHomeBloc;
  late CoinDetailsBloc coinDetailsBloc;
  late TabController tabController;
  late TabController infoTabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    infoTabController = TabController(length: 2, vsync: this);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    webHomeBloc = BlocProvider.of<WebHomeBloc>(context);
    coinDetailsBloc = BlocProvider.of<CoinDetailsBloc>(context);
    homeBloc.add(FetchMarketCoinsEvent());
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is FetchMarketCoinsState) {
              webHomeBloc.add(SelectCoinEvent(index: 0));
              coinDetailsBloc.add(
                GetCoinDetailsEvent(id: homeBloc.marketCoins[0].id ?? ""),
              );
              coinDetailsBloc.add(
                GetCoinMarketDataEvent(id: homeBloc.marketCoins[0].id ?? ""),
              );
            } else if (state is FetchMarketCoinsErrorState) {
              showToast(state.message);
            }
          },
          builder: (context, state) {
            if (homeBloc.marketCoins.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WebCoinListview(
                    coins: homeBloc.marketCoins,
                    controller: ScrollController(),
                    tabController: tabController,
                  ),
                  BlocConsumer<CoinDetailsBloc, CoinDetailsState>(
                    listener: (context, state) {
                      if (state is CoinDetailsApiErrorState) {
                        showToast(state.message);
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
                                      MediaQuery.of(context).size.width - 800.w,
                                  child: CoinPriceChart(
                                    height:
                                        MediaQuery.of(context).size.height -
                                        300.h,
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
                                    ).textTheme.titleLarge!.copyWith(
                                      color: WebAppbarColors.headerTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 400.w,
                                  child: CustomWebTabbar(
                                    backgroundColor:
                                        AppColors.primaryColorLight,
                                    tabAlignment: TabAlignment.fill,
                                    isScrollable: false,
                                    textStyle: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                    height: 50,
                                    tabs: const [
                                      StringConstants.overview,
                                      StringConstants.myInvestments,
                                    ],
                                    onTabChanged: (index) {
                                      // tabController.animateTo(index);
                                    },
                                    tabController: infoTabController,
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
