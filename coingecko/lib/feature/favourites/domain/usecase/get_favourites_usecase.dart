import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/core/models/no_param_model.dart';
import 'package:coingecko/core/usecase/usecase.dart';
import 'package:coingecko/feature/favourites/domain/repository/favourites_repository.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:dartz/dartz.dart';

class GetFavouritesUsecase
    extends
        Usecase<
          Either<ApiFailureModel, List<MarketCoinEntity>>,
          NoParamsModel
        > {
  final FavouritesRepository favouritesRepository;

  GetFavouritesUsecase(this.favouritesRepository);

  @override
  Future<Either<ApiFailureModel, List<MarketCoinEntity>>> call(
    NoParamsModel params,
  ) async {
    return await favouritesRepository.getFavourites();
  }
}
