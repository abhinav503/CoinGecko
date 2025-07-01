import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FavouritesRepository {
  Future<Either<ApiFailureModel, List<MarketCoinEntity>>> getFavourites();
  Future<Either<ApiFailureModel, void>> setFavourites(MarketCoinEntity coin);
}
