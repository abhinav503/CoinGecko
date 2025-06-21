part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class FetchMarketCoinsEvent extends HomeEvent {
  final String order;
  final String vsCurrency;
  FetchMarketCoinsEvent({required this.order, required this.vsCurrency});
}

class UpdateMarketCoinsOrderEvent extends HomeEvent {
  final int index;
  UpdateMarketCoinsOrderEvent({required this.index});
}
