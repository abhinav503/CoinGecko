import 'package:bloc/bloc.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/usecase/get_coin_market_data_usecase.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:meta/meta.dart';

part 'coin_details_event.dart';
part 'coin_details_state.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final GetCoinMarketDataUsecase getCoinMarketDataUsecase;

  MarketCoinEntity? coinItemEntity;
  CoinMarketDataEntity? coinMarketDataEntity;
  CoinMarketDataEntity? fullCoinMarketDataEntity;
  bool isLoading = false;

  MarketChartTimeFilter currentFilter = MarketChartTimeFilter.oneYear;
  CoinDetailsBloc({required this.getCoinMarketDataUsecase})
    : super(CoinDetailsInitial()) {
    on<GetCoinMarketDataEvent>(_onGetCoinMarketData);
    on<UpdateTimeFilterEvent>(_onUpdateTimeFilter);
    on<ChangeCoinDetailsEvent>(_onChangeCoinDetails);
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

  void _onChangeCoinDetails(
    ChangeCoinDetailsEvent event,
    Emitter<CoinDetailsState> emit,
  ) {
    coinItemEntity = event.coin;
    emit(CoinMarketDataApiCallState());
  }

  void _onGetCoinMarketData(
    GetCoinMarketDataEvent event,
    Emitter<CoinDetailsState> emit,
  ) async {
    print("GetCoinMarketDataEvent =========>");
    isLoading = true;
    emit(CoinMarketDataApiCallState());
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
        isLoading = false;
        emit(CoinDetailsApiErrorState(message: failure.message));
      },
      (data) {
        isLoading = false;
        fullCoinMarketDataEntity = data;
        coinMarketDataEntity = fullCoinMarketDataEntity;
        coinItemEntity!
            .priceChangePercentage1y = _calculatePriceChangePercentage(
          fullCoinMarketDataEntity!,
          MarketChartTimeFilter.oneYear,
        );
        coinItemEntity!
            .priceChangePercentage30d = _calculatePriceChangePercentage(
          fullCoinMarketDataEntity!,
          MarketChartTimeFilter.oneMonth,
        );
        coinItemEntity!
            .priceChangePercentage7d = _calculatePriceChangePercentage(
          fullCoinMarketDataEntity!,
          MarketChartTimeFilter.oneWeek,
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
      return CoinMarketDataEntity(
        prices: fullData.prices!.skip(fullData.prices!.length - 30).toList(),
      );
    } else if (filter == MarketChartTimeFilter.oneWeek) {
      return CoinMarketDataEntity(
        prices: fullData.prices!.skip(fullData.prices!.length - 7).toList(),
      );
    } else if (filter == MarketChartTimeFilter.oneDay) {
      return CoinMarketDataEntity(
        prices: fullData.prices!.skip(fullData.prices!.length - 2).toList(),
      );
    } else {
      return fullData;
    }
  }

  double _calculatePriceChangePercentage(
    CoinMarketDataEntity marketData,
    MarketChartTimeFilter timeFilter,
  ) {
    if (marketData.prices == null || marketData.prices!.isEmpty) {
      return 0.0;
    }
    final prices = marketData.prices!;
    final currentPrice = prices.last.value ?? 0.0;
    int historicalIndex;
    switch (timeFilter) {
      case MarketChartTimeFilter.oneDay:
        historicalIndex = prices.length >= 2 ? prices.length - 2 : 0;
        break;
      case MarketChartTimeFilter.oneWeek:
        historicalIndex = prices.length >= 8 ? prices.length - 8 : 0;
        break;
      case MarketChartTimeFilter.oneMonth:
        historicalIndex = prices.length >= 31 ? prices.length - 31 : 0;
        break;
      case MarketChartTimeFilter.oneYear:
        historicalIndex = prices.length >= 366 ? prices.length - 366 : 0;
        break;
    }
    final historicalPrice = prices[historicalIndex].value ?? 0.0;
    if (historicalPrice == 0.0) {
      return 0.0;
    }
    final percentageChange =
        ((currentPrice - historicalPrice) / historicalPrice) * 100;
    return double.parse(percentageChange.toStringAsFixed(2));
  }
}
