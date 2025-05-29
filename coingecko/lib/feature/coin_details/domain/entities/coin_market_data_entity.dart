import 'package:coingecko/core/model_to_entity_mapper/mapper.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_market_data_model.dart';

class CoinMarketDataEntity
    extends Mapper<CoinMarketDataModel, CoinMarketDataEntity> {
  List<DataPointEntity>? prices;
  List<DataPointEntity>? marketCaps;
  List<DataPointEntity>? totalVolumes;

  CoinMarketDataEntity({this.prices, this.marketCaps, this.totalVolumes});

  CoinMarketDataEntity.fromJson(Map<String, dynamic> json) {
    if (json['prices'] != null) {
      prices = <DataPointEntity>[];
      json['prices'].forEach((v) {
        prices!.add(DataPointEntity.fromJson(v));
      });
    }
    if (json['market_caps'] != null) {
      marketCaps = <DataPointEntity>[];
      json['market_caps'].forEach((v) {
        marketCaps!.add(DataPointEntity.fromJson(v));
      });
    }
    if (json['total_volumes'] != null) {
      totalVolumes = <DataPointEntity>[];
      json['total_volumes'].forEach((v) {
        totalVolumes!.add(DataPointEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (prices != null) {
      data['prices'] = prices!.map((v) => v.toJson()).toList();
    }
    if (marketCaps != null) {
      data['market_caps'] = marketCaps!.map((v) => v.toJson()).toList();
    }
    if (totalVolumes != null) {
      data['total_volumes'] = totalVolumes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  CoinMarketDataEntity call(CoinMarketDataModel object) {
    return CoinMarketDataEntity(
      prices:
          object.prices
              ?.map((v) => DataPointEntity.fromJson(v.toJson()))
              .toList(),
      marketCaps:
          object.marketCaps
              ?.map((v) => DataPointEntity.fromJson(v.toJson()))
              .toList(),
      totalVolumes:
          object.totalVolumes
              ?.map((v) => DataPointEntity.fromJson(v.toJson()))
              .toList(),
    );
  }
}

class DataPointEntity {
  int? timestamp;
  double? value;

  DataPointEntity({this.timestamp, this.value});

  DataPointEntity.fromJson(List<dynamic> json) {
    timestamp = json[0];
    value = json[1].toDouble();
  }

  List<dynamic> toJson() {
    return [timestamp, value];
  }
}
