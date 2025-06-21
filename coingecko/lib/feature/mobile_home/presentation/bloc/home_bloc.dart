import 'dart:async';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/usecase/get_market_coins_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMarketCoinsUsecase getMarketCoinsUsecase;

  bool isLoading = false;
  int limit = 100;
  int page = 1;
  Timer? debounce;
  TabController? tabController;
  List<Map> tabbarData = [
    {
      "name": StringConstants.marketCapDesc,
      "icon": HugeIcons.strokeRoundedArrowDown05,
      "order": "market_cap_desc",
    },
    {
      "name": StringConstants.currentPrice,
      "icon": HugeIcons.strokeRoundedArrowDown05,
      "order": "current_price_desc",
    },
    {
      "name": StringConstants.aZ,
      "icon": HugeIcons.strokeRoundedArrowDown05,
      "order": "a_z",
    },
  ];
  TextEditingController searchController = TextEditingController();

  List<MarketCoinEntity> marketCoins = [];
  String currentOrder = 'market_cap_desc';
  int currentTabIndex = 0;
  HomeBloc({required this.getMarketCoinsUsecase}) : super(HomeInitialState()) {
    on<HomeInitialEvent>((event, emitState) {});

    on<FetchMarketCoinsEvent>((event, emitState) async {
      if (event.reset) {
        page = 1;
        marketCoins.clear();
      }
      final response = await getMarketCoinsUsecase(
        GetMarketCoinsReqEntity(
          vsCurrency: event.vsCurrency,
          perPage: limit,
          page: page,
          order: currentOrder,
          sparkline: false,
        ),
      );
      response.fold(
        (failure) {
          emitState(FetchMarketCoinsErrorState(message: failure.message));
        },
        (data) {
          marketCoins.addAll(data);
          emitState(FetchMarketCoinsState());
        },
      );
    });

    on<UpdateMarketCoinsOrderEvent>((event, emitState) {
      int index = event.index;
      _getNextSortOrderFromIndex(index);
      _sortMarketCoins();
      currentTabIndex = index;
      emitState(FetchMarketCoinsState());
    });
  }

  _getNextSortOrderFromIndex(int index) {
    if (currentTabIndex != index) {
      currentOrder = tabbarData[index]["order"];
      return;
    }
    switch (index) {
      case 0:
        currentOrder =
            currentOrder == "market_cap_desc"
                ? "market_cap_asc"
                : "market_cap_desc";
        tabbarData[index]["icon"] =
            currentOrder == "market_cap_desc"
                ? HugeIcons.strokeRoundedArrowDown05
                : HugeIcons.strokeRoundedArrowUp05;
      case 1:
        currentOrder =
            currentOrder == "current_price_desc"
                ? "current_price_asc"
                : "current_price_desc";
        tabbarData[index]["icon"] =
            currentOrder == "current_price_desc"
                ? HugeIcons.strokeRoundedArrowDown05
                : HugeIcons.strokeRoundedArrowUp05;
      case 2:
        currentOrder = currentOrder == "a_z" ? "z_a" : "a_z";
        tabbarData[index]["icon"] =
            currentOrder == "a_z"
                ? HugeIcons.strokeRoundedArrowDown05
                : HugeIcons.strokeRoundedArrowUp05;
    }
  }

  void _sortMarketCoins() {
    switch (currentOrder) {
      case "market_cap_desc":
        marketCoins.sort(
          (a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0),
        );
        break;
      case "market_cap_asc":
        marketCoins.sort(
          (a, b) => (a.marketCap ?? 0).compareTo(b.marketCap ?? 0),
        );
        break;
      case "current_price_desc":
        marketCoins.sort(
          (a, b) => (b.currentPrice ?? 0).compareTo(a.currentPrice ?? 0),
        );
        break;
      case "current_price_asc":
        marketCoins.sort(
          (a, b) => (a.currentPrice ?? 0).compareTo(b.currentPrice ?? 0),
        );
        break;
      case "a_z":
        marketCoins.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case "z_a":
        marketCoins.sort((a, b) => b.name!.compareTo(a.name!));
        break;
    }
  }

  @override
  Future<void> close() {
    debounce?.cancel();
    tabController?.dispose();
    return super.close();
  }
}
