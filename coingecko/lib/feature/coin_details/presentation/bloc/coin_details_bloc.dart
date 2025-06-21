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
  CoinMarketDataEntity? fullCoinMarketDataEntity;

  MarketChartTimeFilter currentFilter = MarketChartTimeFilter.oneYear;
  CoinDetailsBloc({
    required this.getCoinDetailsUsecase,
    required this.getCoinMarketDataUsecase,
  }) : super(CoinDetailsInitial()) {
    on<GetCoinDetailsEvent>(_onGetCoinDetails);
    on<GetCoinMarketDataEvent>(_onGetCoinMarketData);
    on<UpdateTimeFilterEvent>(_onUpdateTimeFilter);
  }

  void onTimeFilterChanged(MarketChartTimeFilter filter, String id) {
    add(UpdateTimeFilterEvent(filter: filter));
  }

  void _onUpdateTimeFilter(
    UpdateTimeFilterEvent event,
    Emitter<CoinDetailsState> emit,
  ) {
    currentFilter = event.filter;
    coinMarketDataEntity = _extractTimePeriodData(
      fullCoinMarketDataEntity!,
      currentFilter,
    );
    emit(CoinMarketDataApiCallState());
  }

  void _onGetCoinDetails(
    GetCoinDetailsEvent event,
    Emitter<CoinDetailsState> emit,
  ) async {
    final result = await getCoinDetailsUsecase(
      CoinDetailsReqEntity(id: event.id, vsCurrency: event.vsCurrency),
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
        vsCurrency: event.vsCurrency,
        days: currentFilter.days.toString(),
        interval: "daily",
      ),
    );
    result.fold(
      (failure) {
        emit(CoinDetailsApiErrorState(message: failure.message));
      },
      (data) {
        fullCoinMarketDataEntity = data;
        currentFilter = MarketChartTimeFilter.oneDay;
        coinMarketDataEntity = _extractTimePeriodData(
          fullCoinMarketDataEntity!,
          currentFilter,
        );
        emit(CoinMarketDataApiCallState());
      },
    );
  }

  /// Extracts data for a specific time period from the full year data
  CoinMarketDataEntity _extractTimePeriodData(
    CoinMarketDataEntity fullData,
    MarketChartTimeFilter filter,
  ) {
    if (filter == MarketChartTimeFilter.oneMonth) {
      return CoinMarketDataEntity(prices: fullData.prices!.sublist(0, 30));
    } else if (filter == MarketChartTimeFilter.oneWeek) {
      return CoinMarketDataEntity(prices: fullData.prices!.sublist(0, 7));
    } else if (filter == MarketChartTimeFilter.oneDay) {
      return CoinMarketDataEntity(prices: fullData.prices!.sublist(0, 2));
    } else {
      return fullData;
    }
  }
}
