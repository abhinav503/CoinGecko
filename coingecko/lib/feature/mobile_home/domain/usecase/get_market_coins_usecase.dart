import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/core/usecase/usecase.dart';
import 'package:coingecko/feature/mobile_home/data/models/get_market_coins_req_model.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/get_market_coins_req_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetMarketCoinsUsecase
    extends
        Usecase<
          Either<ApiFailureModel, List<MarketCoinEntity>>,
          GetMarketCoinsReqEntity
        > {
  final HomeRepository homeRepository;

  GetMarketCoinsUsecase({required this.homeRepository});

  @override
  Future<Either<ApiFailureModel, List<MarketCoinEntity>>> call(
    GetMarketCoinsReqEntity params,
  ) => homeRepository.getMarketCoins(params: params);
}
