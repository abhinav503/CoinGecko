import 'package:coingecko/core/model_to_entity_mapper/mapper.dart';
import 'package:coingecko/feature/coin_details/data/models/coin_item_model.dart';

class CoinItemEntity extends Mapper<CoinItemModel, CoinItemEntity> {
  String? id;
  String? symbol;
  String? name;
  String? webSlug;
  List<String>? categories;
  String? description;
  ImageEntity? image;
  int? marketCap;
  int? marketCapRank;
  double? high24h;
  double? low24h;
  double? totalVolume;
  double? currentPrice;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? priceChangePercentage7d;
  double? priceChangePercentage30d;
  double? priceChangePercentage1y;

  CoinItemEntity({
    this.id,
    this.symbol,
    this.name,
    this.webSlug,
    this.categories,
    this.description,
    this.image,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
    this.currentPrice,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
    this.priceChangePercentage1y,
    this.high24h,
    this.low24h,
  });

  @override
  CoinItemEntity call(CoinItemModel object) {
    return CoinItemEntity(
      id: object.id,
      symbol: object.symbol,
      name: object.name,
      webSlug: object.webSlug,
      categories: object.categories,
      description: object.description,
      image:
          object.image != null
              ? ImageEntity(
                thumb: object.image?.thumb,
                small: object.image?.small,
                large: object.image?.large,
              )
              : null,
      priceChange24h: object.priceChange24h,
      priceChangePercentage24h: object.priceChangePercentage24h,
      priceChangePercentage7d: object.priceChangePercentage7d,
      priceChangePercentage30d: object.priceChangePercentage30d,
      marketCap: object.marketCap,
      marketCapRank: object.marketCapRank,
      currentPrice: object.currentPrice,
      totalVolume: object.totalVolume,
      high24h: object.high24h,
      low24h: object.low24h,
      priceChangePercentage1y: object.priceChangePercentage1y,
    );
  }
}

class ImageEntity {
  String? thumb;
  String? small;
  String? large;

  ImageEntity({this.thumb, this.small, this.large});

  ImageEntity.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    small = json['small'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['small'] = this.small;
    data['large'] = this.large;
    return data;
  }
}
