import 'package:bloc/bloc.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/usecase/get_coin_details_usecase.dart';
import 'package:coingecko/feature/coin_details/domain/usecase/get_coin_market_data_usecase.dart';
import 'package:meta/meta.dart';

part 'coin_details_event.dart';
part 'coin_details_state.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final GetCoinDetailsUsecase getCoinDetailsUsecase;
  final GetCoinMarketDataUsecase getCoinMarketDataUsecase;
  CoinItemEntity? coinItemEntity;
  CoinMarketDataEntity? coinMarketDataEntity;

  MarketChartTimeFilter currentFilter = MarketChartTimeFilter.oneDay;
  CoinDetailsBloc({
    required this.getCoinDetailsUsecase,
    required this.getCoinMarketDataUsecase,
  }) : super(CoinDetailsInitial()) {
    on<GetCoinDetailsEvent>(_onGetCoinDetails);
    on<GetCoinMarketDataEvent>(_onGetCoinMarketData);
    on<UpdateTimeFilterEvent>(_onUpdateTimeFilter);
  }

  void _onUpdateTimeFilter(
    UpdateTimeFilterEvent event,
    Emitter<CoinDetailsState> emit,
  ) {
    currentFilter = event.filter;
    emit(CoinDetailsInitial());
  }

  void _onGetCoinDetails(
    GetCoinDetailsEvent event,
    Emitter<CoinDetailsState> emit,
  ) async {
    final result = await getCoinDetailsUsecase(
      CoinDetailsReqEntity(id: event.id),
    );
    result.fold(
      (failure) {
        emit(CoinDetailsApiErrorState(message: failure.message));
      },
      (data) {
        coinItemEntity = data;
        emit(CoinDetailsApiCallState());
      },
    );
  }

  void _onGetCoinMarketData(
    GetCoinMarketDataEvent event,
    Emitter<CoinDetailsState> emit,
  ) async {
    final result = await getCoinMarketDataUsecase(
      GetCoinMarketDataReqEntity(
        id: event.id,
        vsCurrency: "usd",
        days: currentFilter.days.toString(),
        interval: currentFilter.interval,
      ),
    );
    result.fold(
      (failure) {
        emit(CoinDetailsApiErrorState(message: failure.message));
      },
      (data) {
        coinMarketDataEntity = data;
        emit(CoinMarketDataApiCallState());
      },
    );
  }
}
