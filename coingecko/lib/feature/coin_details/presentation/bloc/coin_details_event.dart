part of 'coin_details_bloc.dart';

@immutable
sealed class CoinDetailsEvent {}

class GetCoinMarketDataEvent extends CoinDetailsEvent {
  final String id;
  final String vsCurrency;
  GetCoinMarketDataEvent({required this.id, required this.vsCurrency});
}

class UpdateTimeFilterEvent extends CoinDetailsEvent {
  final MarketChartTimeFilter filter;
  UpdateTimeFilterEvent({required this.filter});
}

class ChangeCoinDetailsEvent extends CoinDetailsEvent {
  final MarketCoinEntity coin;
  ChangeCoinDetailsEvent({required this.coin});
}
