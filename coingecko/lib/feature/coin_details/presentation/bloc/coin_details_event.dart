part of 'coin_details_bloc.dart';

@immutable
sealed class CoinDetailsEvent {}

class GetCoinDetailsEvent extends CoinDetailsEvent {
  final String id;
  GetCoinDetailsEvent({required this.id});
}

class GetCoinMarketDataEvent extends CoinDetailsEvent {
  final String id;
  GetCoinMarketDataEvent({required this.id});
}
