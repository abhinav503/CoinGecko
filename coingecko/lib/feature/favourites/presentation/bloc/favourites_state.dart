part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

final class FavouritesInitial extends FavouritesState {}

final class GetFavouritesState extends FavouritesState {}

final class AddFavouritesState extends FavouritesState {}
