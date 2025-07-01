import 'package:coingecko/core/base/base_exception_model.dart';
import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/feature/favourites/data/data_source/local_favourites_data_source.dart';
import 'package:coingecko/feature/favourites/domain/repository/favourites_repository.dart';
import 'package:coingecko/feature/mobile_home/data/models/market_coin_model.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:dartz/dartz.dart';

class FavouritesRepoImpl implements FavouritesRepository {
  final LocalFavouritesDataSource localFavouritesDataSource;

  FavouritesRepoImpl({required this.localFavouritesDataSource});

  @override
  Future<Either<ApiFailureModel, List<MarketCoinEntity>>>
  getFavourites() async {
    return baseMethodExceptions(() async {
      final result = await localFavouritesDataSource.getFavourites();
      print("hjasgdkhjsagdkas => ${result.length}");
      MarketCoinEntity marketCoinEntity = MarketCoinEntity();
      return Right(result.map((e) => marketCoinEntity(e)).toList());
    });
  }

  @override
  Future<Either<ApiFailureModel, void>> setFavourites(
    MarketCoinEntity coin,
  ) async {
    return baseMethodExceptions(() async {
      MarketCoinModel marketCoinEntity = MarketCoinModel();
      await localFavouritesDataSource.setFavourites(marketCoinEntity(coin));
      return const Right(null);
    });
  }
}
