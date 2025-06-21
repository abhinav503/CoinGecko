part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class FetchMarketCoinsEvent extends HomeEvent {
  final String order;
  final bool reset;
  final String vsCurrency;
  FetchMarketCoinsEvent({
    required this.order,
    this.reset = false,
    required this.vsCurrency,
  });
}

class UpdateMarketCoinsOrderEvent extends HomeEvent {
  final int index;
  UpdateMarketCoinsOrderEvent({required this.index});
}
