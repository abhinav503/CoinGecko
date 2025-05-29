import 'dart:async';
import 'package:coingecko/core/ui/atoms/pagination_controller.dart';
import 'package:coingecko/feature/home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/home/domain/usecase/get_market_coins_usecase.dart';
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
  TextEditingController searchController = TextEditingController();

  List<MarketCoinEntity> marketCoins = [];
  HomeBloc({required this.getMarketCoinsUsecase}) : super(HomeInitialState()) {
    on<HomeInitialEvent>((event, emitState) {});

    on<FetchMarketCoinsEvent>((event, emitState) async {
      final response = await getMarketCoinsUsecase(
        GetMarketCoinsReqEntity(
          vsCurrency: 'usd',
          perPage: limit,
          page: page,
          order: 'market_cap_desc',
          sparkline: false,
        ),
      );
      response.fold(
        (failure) {
          emitState(FetchMarketCoinsState());
        },
        (data) {
          marketCoins.addAll(data);
          print(marketCoins.length);
          page++;
          emitState(FetchMarketCoinsState());
        },
      );
    });
  }

  Future<void> _onFetchMarketCoinsEvent(
    FetchMarketCoinsEvent event,
    Emitter<HomeState> emit,
  ) async {}

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    debounce?.cancel();
    return super.close();
  }
}
