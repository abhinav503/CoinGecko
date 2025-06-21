import 'dart:async';
import 'package:coingecko/core/ui/atoms/pagination_controller.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/usecase/get_market_coins_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMarketCoinsUsecase getMarketCoinsUsecase;

  bool isLoading = false;
  int limit = 100;
  int page = 1;
  Timer? debounce;
  PaginationScrollController paginationScrollController =
      PaginationScrollController();
  TabController? tabController;
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
      currentOrder = event.order;
      final response = await getMarketCoinsUsecase(
        GetMarketCoinsReqEntity(
          vsCurrency: 'usd',
          perPage: limit,
          page: page,
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
      onTapMarketCoinsTab(currentTabIndex);
      emitState(FetchMarketCoinsState());
    });
  }

  void onNextPageCall() async {
    paginationScrollController.isLoading = true;
    add(FetchMarketCoinsEvent(order: currentOrder));
  }

  onTapMarketCoinsTab(int index) {
    if (currentTabIndex != index) {
      currentOrder = index == 1 ? "volume_desc" : "market_cap_desc";
      _sortMarketCoins();
    } else {
      if (index == 0) {
        currentOrder =
            currentOrder == "market_cap_desc"
                ? "market_cap_asc"
                : "market_cap_desc";
        _sortMarketCoins();
      }
      if (index == 1) {
        if (currentOrder == "volume_desc") {
          currentOrder = "volume_asc";
          _sortMarketCoins();
        } else {
          if (currentOrder == "market_cap_desc" ||
              currentOrder == "market_cap_asc") {
            currentOrder = "volume_desc";
            _sortMarketCoins();
          }
        }
      }
    }
    currentTabIndex = index;
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
      case "volume_desc":
        // Since volume data is not available in the entity, we'll sort by price change percentage as a proxy
        marketCoins.sort(
          (a, b) => (b.priceChangePercentage24h ?? 0).compareTo(
            a.priceChangePercentage24h ?? 0,
          ),
        );
        break;
      case "volume_asc":
        marketCoins.sort(
          (a, b) => (a.priceChangePercentage24h ?? 0).compareTo(
            b.priceChangePercentage24h ?? 0,
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    debounce?.cancel();
    tabController?.dispose();
    return super.close();
  }
}
