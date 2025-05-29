import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/core/usecase/usecase.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/repository/coin_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetCoinMarketDataUsecase
    extends
        Usecase<
          Either<ApiFailureModel, CoinMarketDataEntity>,
          GetCoinMarketDataReqEntity
        > {
  final CoinDetailsRepository coinDetailsRepository;

  GetCoinMarketDataUsecase({required this.coinDetailsRepository});

  @override
  Future<Either<ApiFailureModel, CoinMarketDataEntity>> call(
    GetCoinMarketDataReqEntity params,
  ) => coinDetailsRepository.getCoinMarketData(params);
}
