part of 'coin_details_bloc.dart';

@immutable
sealed class CoinDetailsState {}

final class CoinDetailsInitial extends CoinDetailsState {}

class CoinDetailsApiCallState extends CoinDetailsState {}

class CoinMarketDataApiCallState extends CoinDetailsState {}
