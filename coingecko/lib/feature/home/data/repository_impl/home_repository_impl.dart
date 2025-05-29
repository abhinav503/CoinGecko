import 'package:coingecko/feature/home/data/models/get_market_coins_req_model.dart';
import 'package:coingecko/feature/home/data/models/market_coin_model.dart';
import 'package:coingecko/feature/home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:coingecko/core/base/base_exception_model.dart';
import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/feature/home/data/data_source/home_data_source_repository.dart';
import 'package:coingecko/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSourceRepository homeDataSourceRepository;

  HomeRepositoryImpl({required this.homeDataSourceRepository});

  @override
  Future<Either<ApiFailureModel, List<MarketCoinEntity>>> getMarketCoins({
    required GetMarketCoinsReqEntity params,
  }) => baseMethodExceptions(() => getMarketCoinsApi(params: params));

  Future<Either<ApiFailureModel, List<MarketCoinEntity>>> getMarketCoinsApi({
    required GetMarketCoinsReqEntity params,
  }) async {
    GetMarketCoinsReqModel getMarketCoinsReqModel = GetMarketCoinsReqModel();
    List<MarketCoinModel> response = await homeDataSourceRepository
        .getMarketCoins(getMarketCoinsReqModel(params));
    List<MarketCoinEntity> marketCoinEntities = [];
    MarketCoinEntity marketCoinEntity = MarketCoinEntity();
    for (MarketCoinModel coin in response) {
      marketCoinEntities.add(marketCoinEntity(coin));
    }
    return Right(marketCoinEntities);
  }
}
