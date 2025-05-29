class CoinMarketDataModel {
  List<DataPointModel>? prices;
  List<DataPointModel>? marketCaps;
  List<DataPointModel>? totalVolumes;

  CoinMarketDataModel({this.prices, this.marketCaps, this.totalVolumes});

  CoinMarketDataModel.fromJson(Map<String, dynamic> json) {
    if (json['prices'] != null) {
      prices = <DataPointModel>[];
      json['prices'].forEach((v) {
        prices!.add(DataPointModel.fromJson(v));
      });
    }
    if (json['market_caps'] != null) {
      marketCaps = <DataPointModel>[];
      json['market_caps'].forEach((v) {
        marketCaps!.add(DataPointModel.fromJson(v));
      });
    }
    if (json['total_volumes'] != null) {
      totalVolumes = <DataPointModel>[];
      json['total_volumes'].forEach((v) {
        totalVolumes!.add(DataPointModel.fromJson(v));
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
}

class DataPointModel {
  int? timestamp;
  double? value;

  DataPointModel({this.timestamp, this.value});

  DataPointModel.fromJson(List<dynamic> json) {
    timestamp = json[0];
    value = json[1].toDouble();
  }

  List<dynamic> toJson() {
    return [timestamp, value];
  }
}
