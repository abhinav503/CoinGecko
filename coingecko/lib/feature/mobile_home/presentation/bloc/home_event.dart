part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class FetchMarketCoinsEvent extends HomeEvent {
  final String order;
  final bool reset;
  FetchMarketCoinsEvent({required this.order, this.reset = false});
}

class UpdateMarketCoinsOrderEvent extends HomeEvent {}
