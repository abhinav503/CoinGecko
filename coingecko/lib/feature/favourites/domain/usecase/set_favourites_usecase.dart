import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/core/usecase/usecase.dart';
import 'package:coingecko/feature/favourites/domain/repository/favourites_repository.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:dartz/dartz.dart';

class SetFavouritesUsecase
    extends Usecase<Either<ApiFailureModel, void>, MarketCoinEntity> {
  final FavouritesRepository favouritesRepository;

  SetFavouritesUsecase(this.favouritesRepository);

  @override
  Future<Either<ApiFailureModel, void>> call(MarketCoinEntity params) async {
    return await favouritesRepository.setFavourites(params);
  }
}
