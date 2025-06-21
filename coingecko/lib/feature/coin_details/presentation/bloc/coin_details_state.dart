part of 'coin_details_bloc.dart';

@immutable
sealed class CoinDetailsState {}

final class CoinDetailsInitial extends CoinDetailsState {}

class CoinDetailsApiErrorState extends CoinDetailsState {
  final String message;
  CoinDetailsApiErrorState({required this.message});
}

class CoinMarketDataApiCallState extends CoinDetailsState {}
