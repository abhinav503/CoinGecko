part of 'home_bloc.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class FetchMarketCoinsState extends HomeState {}

class FetchMarketCoinsErrorState extends HomeState {
  final String message;
  FetchMarketCoinsErrorState({required this.message});
}
