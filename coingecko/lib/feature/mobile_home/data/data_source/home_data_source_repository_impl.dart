import 'dart:convert';
import 'package:coingecko/core/constants/api_constants.dart';
import 'package:coingecko/core/network_repository/network_repository.dart';
import 'package:coingecko/feature/mobile_home/data/data_source/home_data_source_repository.dart';
import 'package:coingecko/feature/mobile_home/data/models/get_market_coins_req_model.dart';
import 'package:coingecko/feature/mobile_home/data/models/market_coin_model.dart';
import 'package:http/http.dart';

class HomeDataSourceRepositoryImpl extends HomeDataSourceRepository {
  final NetworkRepository networkRepository;

  HomeDataSourceRepositoryImpl({required this.networkRepository});

  @override
  Future<List<MarketCoinModel>> getMarketCoins(
    GetMarketCoinsReqModel params,
  ) async {
    Response response = await networkRepository.getRequest(
      urlSuffix: ApiConstants.marketCoinsApi,
      queries: params.toJsonForQuery(),
      headers: {
        "Content-Type": "application/json",
        "x-cg-demo-api-key": ApiConstants.coingeckoApiKey,
      },
    );
    List<MarketCoinModel> marketCoins = [];
    for (var coin in jsonDecode(response.body)) {
      marketCoins.add(MarketCoinModel.fromJson(coin));
    }
    return marketCoins;
  }
}
