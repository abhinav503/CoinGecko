import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CoinDetailsRepository {
  Future<Either<ApiFailureModel, CoinItemEntity>> getCoinDetails(
    CoinDetailsReqEntity coinDetailsReqEntity,
  );
  Future<Either<ApiFailureModel, CoinMarketDataEntity>> getCoinMarketData(
    GetCoinMarketDataReqEntity getCoinMarketDataReqEntity,
  );
}
