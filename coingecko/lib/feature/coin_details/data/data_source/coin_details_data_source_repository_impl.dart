import 'dart:convert';

import 'package:coingecko/core/network_repository/network_repository.dart';
import 'package:coingecko/feature/coin_details/data/data_source/coin_details_data_source_repository.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_details_req_model.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_item_model.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_market_data_model.dart';
import 'package:coingecko/feature/coin_details/data/models/get_coin_market_data_req_model.dart';

class CoinDetailsDataSourceImpl implements CoinDetailsDataSource {
  final NetworkRepository networkRepository;

  CoinDetailsDataSourceImpl({required this.networkRepository});

  @override
  Future<CoinItemModel> getCoinDetails(
    CoinDetailsReqModel coinDetailsReqModel,
  ) async {
    final response = await networkRepository.getRequest(
      urlSuffix: 'coins/${coinDetailsReqModel.id}',
      queries: {
        'localization': "false",
        'precision': '2',
        'vs_currency': coinDetailsReqModel.vsCurrency ?? 'usd',
      },
    );
    CoinItemModel coinItemModel = CoinItemModel.fromJson({
      ...jsonDecode(response.body),
      'vs_currency': coinDetailsReqModel.vsCurrency ?? 'usd',
    });
    return coinItemModel;
  }

  @override
  Future<CoinMarketDataModel> getCoinMarketData(
    GetCoinMarketDataReqModel getCoinMarketDataReqModel,
  ) async {
    final response = await networkRepository.getRequest(
      urlSuffix: 'coins/${getCoinMarketDataReqModel.id}/market_chart',
      queries: {
        'vs_currency': getCoinMarketDataReqModel.vsCurrency ?? 'usd',
        'days': getCoinMarketDataReqModel.days ?? '30',
        if (getCoinMarketDataReqModel.interval != null)
          'interval': getCoinMarketDataReqModel.interval!,
        'precision': '2',
      },
    );
    return CoinMarketDataModel.fromJson(jsonDecode(response.body));
  }
}
