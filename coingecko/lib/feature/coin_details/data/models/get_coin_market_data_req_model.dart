import 'package:coingecko/core/model_to_entity_mapper/mapper.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';

class GetCoinMarketDataReqModel
    extends Mapper<GetCoinMarketDataReqEntity, GetCoinMarketDataReqModel> {
  final String? id;
  final String? vsCurrency;
  final String? days;
  final String? interval;

  GetCoinMarketDataReqModel({
    this.id,
    this.vsCurrency,
    this.days,
    this.interval,
  });

  @override
  GetCoinMarketDataReqModel call(GetCoinMarketDataReqEntity object) {
    return GetCoinMarketDataReqModel(
      id: object.id,
      vsCurrency: object.vsCurrency,
      days: object.days,
      interval: object.interval,
    );
  }
}
