part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class FetchMarketCoinsEvent extends HomeEvent {}
