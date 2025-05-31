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
  double? currentPrice;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? priceChangePercentage7d;
  double? priceChangePercentage30d;

  CoinItemEntity({
    this.id,
    this.symbol,
    this.name,
    this.webSlug,
    this.categories,
    this.description,
    this.image,
    this.marketCap,
    this.currentPrice,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
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
      currentPrice: object.currentPrice,
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
