import 'package:coingecko/feature/mobile_home/data/models/market_coin_model.dart';

abstract class LocalFavouritesDataSource {
  Future<List<MarketCoinModel>> getFavourites();
  Future<void> setFavourites(MarketCoinModel coin);
}
