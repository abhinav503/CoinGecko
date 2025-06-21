import 'package:coingecko/feature/mobile_home/data/models/get_market_coins_req_model.dart';
import 'package:coingecko/feature/mobile_home/data/models/market_coin_model.dart';

abstract class HomeDataSourceRepository {
  Future<List<MarketCoinModel>> getMarketCoins(GetMarketCoinsReqModel params);
}
