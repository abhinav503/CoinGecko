import 'package:coingecko/feature/coin_details/data/models/coin_details_req_model.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_item_model.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_market_data_model.dart';
import 'package:coingecko/feature/coin_details/data/models/get_coin_market_data_req_model.dart';

abstract class CoinDetailsDataSource {
  Future<CoinItemModel> getCoinDetails(CoinDetailsReqModel coinDetailsReqModel);
  Future<CoinMarketDataModel> getCoinMarketData(
    GetCoinMarketDataReqModel getCoinMarketDataReqModel,
  );
}
