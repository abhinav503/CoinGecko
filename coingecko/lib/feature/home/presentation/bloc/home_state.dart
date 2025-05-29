part of 'home_bloc.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class FetchMarketCoinsState extends HomeState {}
