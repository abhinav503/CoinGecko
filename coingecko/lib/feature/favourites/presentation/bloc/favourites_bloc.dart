import 'package:bloc/bloc.dart';
import 'package:coingecko/core/models/no_param_model.dart';
import 'package:coingecko/feature/favourites/domain/usecase/get_favourites_usecase.dart';
import 'package:coingecko/feature/favourites/domain/usecase/set_favourites_usecase.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:meta/meta.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetFavouritesUsecase getFavouritesUsecase;
  final SetFavouritesUsecase setFavouritesUsecase;

  List<MarketCoinEntity> coins = [];
  FavouritesBloc({
    required this.getFavouritesUsecase,
    required this.setFavouritesUsecase,
  }) : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) {});

    on<GetFavouritesEvent>((event, emit) async {
      final result = await getFavouritesUsecase(NoParamsModel());
      result.fold(
        (failure) {
          print(failure);
          // emit(GetFavouritesState(error: failure));
        },
        (data) {
          coins = data;
          emit(GetFavouritesState());
        },
      );
    });

    on<AddFavouritesEvent>((event, emit) async {
      final result = await setFavouritesUsecase(event.coin);
      result.fold(
        (failure) {
          // emit(AddFavouritesState(error: failure));
        },
        (data) {
          emit(AddFavouritesState());
        },
      );
    });
  }
}
