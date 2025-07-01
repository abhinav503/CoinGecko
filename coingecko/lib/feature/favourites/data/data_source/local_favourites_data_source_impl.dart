import 'dart:convert';

import 'package:coingecko/core/constants/local_constants.dart';
import 'package:coingecko/core/services/shared_preference/shared_preference_service.dart';
import 'package:coingecko/feature/favourites/data/data_source/local_favourites_data_source.dart';
import 'package:coingecko/feature/mobile_home/data/models/market_coin_model.dart';

class LocalFavouritesDataSourceImpl implements LocalFavouritesDataSource {
  final SharedPreferenceService sharedPreferences;

  LocalFavouritesDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MarketCoinModel>> getFavourites() async {
    final favourites = sharedPreferences.getString(
      LocalConstants.favouritesKey,
    );
    final decodedFavourites = jsonDecode(favourites ?? '[]');
    List<MarketCoinModel> marketCoinModels = [];
    for (var element in decodedFavourites) {
      marketCoinModels.add(MarketCoinModel.fromJson(element));
    }
    return marketCoinModels;
  }

  @override
  Future<void> setFavourites(MarketCoinModel coin) async {
    final favourites = sharedPreferences.getString(
      LocalConstants.favouritesKey,
    );
    final decodedFavourites = jsonDecode(favourites ?? '[]');
    decodedFavourites.add(coin.toJson());
    await sharedPreferences.setString(
      LocalConstants.favouritesKey,
      jsonEncode(decodedFavourites),
    );
  }
}
