import 'package:coingecko/core/constants/currency_constants.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/core/ui/atoms/custom_text_field.dart';
import 'package:coingecko/core/ui/atoms/pagination_controller.dart';
import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/core/ui/molecules/coin_selected_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_web_tabbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/mobile_home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/web_home/presentation/bloc/web_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebCoinListview extends StatefulWidget {
  final List<MarketCoinEntity> coins;
  final TabController tabController;
  final bool isEmptyState;
  final PaginationScrollController? paginationController;
  const WebCoinListview({
    super.key,
    required this.coins,
    required this.tabController,
    this.paginationController,
    this.isEmptyState = false,
  });

  @override
  State<WebCoinListview> createState() => _WebCoinListviewState();
}

class _WebCoinListviewState extends State<WebCoinListview> {
  late WebHomeBloc webHomeBloc;
  late CoinDetailsBloc coinDetailsBloc;
  late HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    webHomeBloc = BlocProvider.of<WebHomeBloc>(context);
    coinDetailsBloc = BlocProvider.of<CoinDetailsBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebHomeBloc, WebHomeState>(
      listener: (context, state) {
        if (state is SelectedCoinState) {
          if (state.runApis) {
            if (widget.isEmptyState) {
              return;
            }
            coinDetailsBloc.add(
              GetCoinMarketDataEvent(
                id: widget.coins[webHomeBloc.selectedIndex].id ?? "",
                vsCurrency: CurrencyConstants.getCurrencyForCoinGecko(
                  Localizations.localeOf(context),
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        print("widget.isEmptyState =========> ${widget.isEmptyState}");
        MarketCoinEntity? selectedCoin;
        if (widget.isEmptyState) {
          selectedCoin = coinDetailsBloc.coinItemEntity;
        } else {
          selectedCoin = widget.coins[webHomeBloc.selectedIndex];
        }
        return SizedBox(
          width: 400.w,
          height: MediaQuery.of(context).size.height - 120.h,
          child: Column(
            children: [
              CoinSelectedWidget(
                imageUrl: selectedCoin?.image ?? "",
                name: selectedCoin?.name ?? "",
                symbol: selectedCoin?.symbol ?? "",
                currency: CurrencyConstants.getCurrencyForCoinGecko(
                  Localizations.localeOf(context),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 50.h,
                child: CustomTextField(
                  hintText: StringConstants.searchCoin,
                  controller: homeBloc.searchController,
                  onChanged: (value) {
                    homeBloc.add(SearchMarketCoinsEvent());
                  },
                ),
              ),
              CustomWebTabbar(
                height: 64.h,
                icons:
                    homeBloc.tabbarData
                        .map<IconData>((e) => e["icon"])
                        .toList(),
                tabs: const [
                  StringConstants.marketCapDesc,
                  StringConstants.currentPrice,
                  StringConstants.aZ,
                ],
                onTap: (index) {
                  homeBloc.add(UpdateMarketCoinsOrderEvent(index: index));
                  webHomeBloc.add(SelectCoinEvent(index: 0, runApis: true));
                },
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                tabController: widget.tabController,
                isScrollable: true,
                onTabChanged: (index) {},
              ),
              if (widget.isEmptyState) SizedBox(height: 20.h),
              if (widget.isEmptyState)
                Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: widget.coins.length,
                  itemBuilder: (context, index) {
                    return CoinItemWidget(
                      showLeading: false,
                      isSelected: webHomeBloc.selectedIndex == index,
                      coin: widget.coins[index],
                      onTap: () {
                        bool runApis = true;
                        if (webHomeBloc.selectedIndex == index) {
                          runApis = false;
                        }
                        coinDetailsBloc.currentFilter =
                            MarketChartTimeFilter.oneYear;
                        webHomeBloc.add(
                          SelectCoinEvent(index: index, runApis: runApis),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
