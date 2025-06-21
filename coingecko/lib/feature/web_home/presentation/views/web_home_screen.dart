import 'package:coingecko/core/base/base_web_screen.dart';
import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/currency_constants.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/enums/screen_type.dart';
import 'package:coingecko/core/ui/molecules/coin_details_tile.dart';
import 'package:coingecko/core/ui/molecules/custom_web_tabbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_overview.dart';
import 'package:coingecko/feature/coin_details/presentation/widgets/coin_price_chart.dart';
import 'package:coingecko/feature/mobile_home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/mobile_home/presentation/view/home_screen.dart';
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
  bool isInit = true;
  late HomeBloc homeBloc;
  late WebHomeBloc webHomeBloc;
  late CoinDetailsBloc coinDetailsBloc;

  @override
  void didChangeDependencies() {
    if (isInit) {
      homeBloc = BlocProvider.of<HomeBloc>(context);
      webHomeBloc = BlocProvider.of<WebHomeBloc>(context);
      coinDetailsBloc = BlocProvider.of<CoinDetailsBloc>(context);
      Future.delayed(const Duration(seconds: 2), () {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

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
              isInit: isInit,
              homeBloc: homeBloc,
              webHomeBloc: webHomeBloc,
              coinDetailsBloc: coinDetailsBloc,
            );
      },
    );
  }
}

class WebHomeScreenWidget extends StatefulWidget {
  final ScreenType screenType;
  final Function(String) showToast;
  final String? selectedCoin;
  final bool isInit;
  final HomeBloc homeBloc;
  final WebHomeBloc webHomeBloc;
  final CoinDetailsBloc coinDetailsBloc;
  const WebHomeScreenWidget({
    super.key,
    required this.screenType,
    required this.showToast,
    this.selectedCoin,
    required this.isInit,
    required this.homeBloc,
    required this.webHomeBloc,
    required this.coinDetailsBloc,
  });

  @override
  State<WebHomeScreenWidget> createState() => _WebHomeScreenWidgetState();
}

class _WebHomeScreenWidgetState extends State<WebHomeScreenWidget>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TabController infoTabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    infoTabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    if (widget.isInit) {
      widget.homeBloc.add(
        FetchMarketCoinsEvent(
          order: widget.homeBloc.currentOrder,
          vsCurrency: CurrencyConstants.getCurrencyForCoinGecko(
            Localizations.localeOf(context),
          ),
        ),
      );
    }
    super.didChangeDependencies();
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
          buildWhen:
              (previous, current) => current is! UpdateMarketCoinsOrderState,
          listener: (context, state) {
            if (state is FetchMarketCoinsState) {
              if (widget.screenType != ScreenType.mobileSmall) {
                int seletedCoinindex = widget.homeBloc.marketCoins.indexWhere(
                  (element) => element.id == widget.selectedCoin,
                );
                if (seletedCoinindex == -1) {
                  seletedCoinindex = 0;
                }
                widget.coinDetailsBloc.coinItemEntity =
                    widget.homeBloc.marketCoins[seletedCoinindex];
                widget.coinDetailsBloc.add(
                  GetCoinMarketDataEvent(
                    id: widget.homeBloc.marketCoins[seletedCoinindex].id ?? "",
                    vsCurrency: CurrencyConstants.getCurrencyForCoinGecko(
                      Localizations.localeOf(context),
                    ),
                  ),
                );
              }
            } else if (state is FetchMarketCoinsErrorState) {
              widget.showToast(state.message);
            }
          },
          builder: (context, state) {
            if (widget.homeBloc.marketCoins.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WebCoinListview(
                    coins: widget.homeBloc.marketCoins,
                    tabController: tabController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocConsumer<CoinDetailsBloc, CoinDetailsState>(
                            listener: (context, state) {
                              if (state is CoinDetailsApiErrorState) {
                                widget.showToast(state.message);
                              }
                            },
                            builder: (context, state) {
                              if (widget.coinDetailsBloc.coinItemEntity !=
                                  null) {
                                return CoinDetailsTile(
                                  coin: widget.coinDetailsBloc.coinItemEntity!,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          WebCoinChart(
                            screenType: widget.screenType,
                            coinDetailsBloc: widget.coinDetailsBloc,
                            showToast: widget.showToast,
                          ),
                        ],
                      ),
                      [
                            ScreenType.mobileSmall,
                            ScreenType.mobileLarge,
                          ].contains(widget.screenType)
                          ? const SizedBox.shrink()
                          : CoinInfoWidget(
                            infoTabController: infoTabController,
                            coinDetailsBloc: widget.coinDetailsBloc,
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
}

class WebCoinChart extends StatelessWidget {
  const WebCoinChart({
    super.key,
    required this.screenType,
    required this.coinDetailsBloc,
    required this.showToast,
  });
  final ScreenType screenType;
  final CoinDetailsBloc coinDetailsBloc;
  final Function(String) showToast;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinDetailsBloc, CoinDetailsState>(
      listener: (context, state) {
        if (state is CoinDetailsApiErrorState) {
          showToast(state.message);
        }
      },
      bloc: coinDetailsBloc,
      builder: (context, state) {
        if (state is CoinDetailsApiErrorState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 340.h,
            width:
                [
                      ScreenType.mobileSmall,
                      ScreenType.mobileLarge,
                    ].contains(screenType)
                    ? MediaQuery.of(context).size.width - 400.w
                    : MediaQuery.of(context).size.width - 800.w,
            child: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        }
        if (coinDetailsBloc.isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 340.h,
            width:
                [
                      ScreenType.mobileSmall,
                      ScreenType.mobileLarge,
                    ].contains(screenType)
                    ? MediaQuery.of(context).size.width - 400.w
                    : MediaQuery.of(context).size.width - 800.w,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (coinDetailsBloc.coinMarketDataEntity!.prices!.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 340.h,
            width:
                [
                      ScreenType.mobileSmall,
                      ScreenType.mobileLarge,
                    ].contains(screenType)
                    ? MediaQuery.of(context).size.width - 400.w
                    : MediaQuery.of(context).size.width - 800.w,
            child: const Center(child: Text("No data available")),
          );
        }
        if (coinDetailsBloc.coinMarketDataEntity == null ||
            coinDetailsBloc.coinItemEntity == null) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: EdgeInsets.only(left: 40.w, top: 50.h),
          width:
              [
                    ScreenType.mobileSmall,
                    ScreenType.mobileLarge,
                  ].contains(screenType)
                  ? MediaQuery.of(context).size.width - 400.w
                  : MediaQuery.of(context).size.width - 800.w,
          child: CoinPriceChart(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
            height: MediaQuery.of(context).size.height - 340.h,
            marketData: coinDetailsBloc.coinMarketDataEntity!,
            selectedFilter: coinDetailsBloc.currentFilter,
            onFilterChanged: coinDetailsBloc.onTimeFilterChanged,
            id: coinDetailsBloc.coinItemEntity!.id ?? "",
            tooltipTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: WebAppbarColors.headerTextColor,
            ),
            coin: coinDetailsBloc.coinItemEntity!,
          ),
        );
      },
    );
  }
}

class CoinInfoWidget extends StatelessWidget {
  const CoinInfoWidget({
    super.key,
    required this.infoTabController,
    required this.coinDetailsBloc,
  });

  final TabController infoTabController;
  final CoinDetailsBloc coinDetailsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
      bloc: coinDetailsBloc,
      builder: (context, state) {
        if (coinDetailsBloc.coinItemEntity == null) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            SizedBox(
              width: 400.w,
              child: CustomWebTabbar(
                backgroundColor: AppColors.primaryColorLight,
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                showIndicator: false,
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
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
              coinItemEntity: coinDetailsBloc.coinItemEntity!,
              tabController: infoTabController,
            ),
          ],
        );
      },
    );
  }
}
