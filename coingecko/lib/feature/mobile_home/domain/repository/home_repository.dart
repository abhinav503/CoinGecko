import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<ApiFailureModel, List<MarketCoinEntity>>> getMarketCoins({
    required GetMarketCoinsReqEntity params,
  });
}
