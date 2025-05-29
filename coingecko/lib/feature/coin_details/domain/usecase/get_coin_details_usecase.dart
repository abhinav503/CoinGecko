import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/core/usecase/usecase.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:coingecko/feature/coin_details/domain/repository/coin_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetCoinDetailsUsecase
    extends
        Usecase<Either<ApiFailureModel, CoinItemEntity>, CoinDetailsReqEntity> {
  final CoinDetailsRepository coinDetailsRepository;

  GetCoinDetailsUsecase({required this.coinDetailsRepository});

  @override
  Future<Either<ApiFailureModel, CoinItemEntity>> call(
    CoinDetailsReqEntity params,
  ) => coinDetailsRepository.getCoinDetails(params);
}
