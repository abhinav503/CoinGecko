import 'package:coingecko/core/model_to_entity_mapper/mapper.dart';
import 'package:coingecko/feature/mobile_home/data/models/market_coin_model.dart';

class MarketCoinEntity extends Mapper<MarketCoinModel, MarketCoinEntity> {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? priceChangePercentage24h;
  double? priceChange24h;
  double? totalSupply;
  double? priceChangePercentage7d;
  double? priceChangePercentage30d;
  double? priceChangePercentage1y;
  double? high24h;
  double? low24h;

  MarketCoinEntity({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.priceChangePercentage24h,
    this.priceChange24h,
    this.totalSupply,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
    this.priceChangePercentage1y,
    this.high24h,
    this.low24h,
  });

  MarketCoinEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    priceChange24h = json['price_change_24h'];
    totalSupply = json['total_supply'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['image'] = image;
    data['current_price'] = currentPrice;
    data['market_cap'] = marketCap;
    data['market_cap_rank'] = marketCapRank;
    data['price_change_percentage_24h'] = priceChangePercentage24h;
    data['price_change_24h'] = priceChange24h;
    data['total_supply'] = totalSupply;
    data['price_change_percentage_7d'] = priceChangePercentage7d;
    data['price_change_percentage_30d'] = priceChangePercentage30d;
    data['price_change_percentage_1y'] = priceChangePercentage1y;
    data['high_24h'] = high24h;
    data['low_24h'] = low24h;
    return data;
  }

  @override
  MarketCoinEntity call(MarketCoinModel object) {
    return MarketCoinEntity(
      id: object.id,
      symbol: object.symbol,
      name: object.name,
      image: object.image,
      currentPrice: object.currentPrice,
      marketCap: object.marketCap,
      marketCapRank: object.marketCapRank,
      priceChangePercentage24h: object.priceChangePercentage24h,
      priceChange24h: object.priceChange24h,
      totalSupply: object.totalSupply,
      high24h: object.high24h,
      low24h: object.low24h,
    );
  }
}
