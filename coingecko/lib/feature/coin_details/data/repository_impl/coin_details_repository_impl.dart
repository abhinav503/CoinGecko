import 'package:coingecko/feature/coin_details/data/data_source/coin_details_data_source_repository.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_details_req_model.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_item_model.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_market_data_model.dart';
import 'package:coingecko/feature/coin_details/data/models/get_coin_market_data_req_model.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/repository/coin_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:coingecko/core/base/base_exception_model.dart';
import 'package:coingecko/core/models/api_failure_model.dart';

class CoinDetailsRepositoryImpl implements CoinDetailsRepository {
  final CoinDetailsDataSource coinDetailsDataSource;

  CoinDetailsRepositoryImpl({required this.coinDetailsDataSource});

  @override
  Future<Either<ApiFailureModel, CoinItemEntity>> getCoinDetails(
    CoinDetailsReqEntity params,
  ) => baseMethodExceptions(() => getCoinDetailsApi(params: params));

  Future<Either<ApiFailureModel, CoinItemEntity>> getCoinDetailsApi({
    required CoinDetailsReqEntity params,
  }) async {
    CoinDetailsReqModel coinDetailsReqModel = CoinDetailsReqModel();
    CoinItemModel response = await coinDetailsDataSource.getCoinDetails(
      coinDetailsReqModel(params),
    );
    CoinItemEntity coinItemEntity = CoinItemEntity();
    return Right(coinItemEntity(response));
  }

  @override
  Future<Either<ApiFailureModel, CoinMarketDataEntity>> getCoinMarketData(
    GetCoinMarketDataReqEntity getCoinMarketDataReqEntity,
  ) => baseMethodExceptions(
    () => getCoinMarketDataApi(
      getCoinMarketDataReqEntity: getCoinMarketDataReqEntity,
    ),
  );

  Future<Either<ApiFailureModel, CoinMarketDataEntity>> getCoinMarketDataApi({
    required GetCoinMarketDataReqEntity getCoinMarketDataReqEntity,
  }) async {
    GetCoinMarketDataReqModel getCoinMarketDataReqModel =
        GetCoinMarketDataReqModel();
    CoinMarketDataModel response = await coinDetailsDataSource
        .getCoinMarketData(
          getCoinMarketDataReqModel(getCoinMarketDataReqEntity),
        );
    CoinMarketDataEntity coinMarketDataEntity = CoinMarketDataEntity();
    return Right(coinMarketDataEntity(response));
  }
}
