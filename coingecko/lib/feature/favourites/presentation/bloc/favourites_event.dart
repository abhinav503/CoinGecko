part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class GetFavouritesEvent extends FavouritesEvent {}

class AddFavouritesEvent extends FavouritesEvent {
  final MarketCoinEntity coin;

  AddFavouritesEvent(this.coin);
}
