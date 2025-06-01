import 'dart:async';
import 'package:coingecko/core/ui/atoms/pagination_controller.dart';
import 'package:coingecko/feature/home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/home/domain/usecase/get_market_coins_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMarketCoinsUsecase getMarketCoinsUsecase;

  bool isLoading = false;
  int limit = 25;
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
          page++;
          emitState(FetchMarketCoinsState());
        },
      );
    });
  }

  void onNextPageCall() async {
    paginationScrollController.isLoading = true;
    add(FetchMarketCoinsEvent(order: currentOrder));
  }

  onTapMarketCoinsTab(int index) {
    if (currentTabIndex != index) {
      currentOrder = index == 1 ? "volume_desc" : "market_cap_desc";
      add(FetchMarketCoinsEvent(order: currentOrder, reset: true));
    } else {
      if (index == 0) {
        currentOrder =
            currentOrder == "market_cap_desc"
                ? "market_cap_asc"
                : "market_cap_desc";
        add(FetchMarketCoinsEvent(order: currentOrder, reset: true));
      }
      if (index == 1) {
        if (currentOrder == "volume_desc") {
          currentOrder = "volume_asc";
          add(FetchMarketCoinsEvent(order: currentOrder, reset: true));
        } else {
          if (currentOrder == "market_cap_desc" ||
              currentOrder == "market_cap_asc") {
            currentOrder = "volume_desc";
            add(FetchMarketCoinsEvent(order: currentOrder, reset: true));
          }
        }
      }
    }
    currentTabIndex = index;
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    debounce?.cancel();
    return super.close();
  }
}
