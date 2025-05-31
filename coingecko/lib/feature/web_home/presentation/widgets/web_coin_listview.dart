import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/core/ui/molecules/coin_selected_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_web_tabbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/web_home/presentation/bloc/web_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebCoinListview extends StatefulWidget {
  final List<MarketCoinEntity> coins;
  final ScrollController controller;
  final TabController tabController;
  const WebCoinListview({
    super.key,
    required this.coins,
    required this.controller,
    required this.tabController,
  });

  @override
  State<WebCoinListview> createState() => _WebCoinListviewState();
}

class _WebCoinListviewState extends State<WebCoinListview> {
  late WebHomeBloc webHomeBloc;
  late CoinDetailsBloc coinDetailsBloc;
  @override
  void initState() {
    super.initState();
    webHomeBloc = BlocProvider.of<WebHomeBloc>(context);
    coinDetailsBloc = BlocProvider.of<CoinDetailsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WebHomeBloc, WebHomeState>(
      listener: (context, state) {
        if (state is SelectedCoinState) {
          coinDetailsBloc.add(
            GetCoinDetailsEvent(
              id: widget.coins[webHomeBloc.selectedIndex].id ?? "",
            ),
          );
          coinDetailsBloc.add(
            GetCoinMarketDataEvent(
              id: widget.coins[webHomeBloc.selectedIndex].id ?? "",
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 400.w,
          height: MediaQuery.of(context).size.height - 120.h,
          child: Column(
            children: [
              CoinSelectedWidget(
                imageUrl: widget.coins[webHomeBloc.selectedIndex].image ?? "",
                name: widget.coins[webHomeBloc.selectedIndex].name ?? "",
                symbol: widget.coins[webHomeBloc.selectedIndex].symbol ?? "",
              ),
              CustomWebTabbar(
                height: 64.h,
                tabs: const [
                  StringConstants.all,
                  StringConstants.marketCap,
                  StringConstants.price,
                  StringConstants.change24h,
                ],
                onTabChanged: (index) {},
                tabController: widget.tabController,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: widget.coins.length,
                  controller: widget.controller,
                  itemBuilder: (context, index) {
                    return CoinItemWidget(
                      showLeading: false,
                      isSelected: webHomeBloc.selectedIndex == index,
                      coin: widget.coins[index],
                      onTap: () {
                        webHomeBloc.add(SelectCoinEvent(index: index));
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
