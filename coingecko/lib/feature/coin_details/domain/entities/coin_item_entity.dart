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

  CoinItemEntity({
    this.id,
    this.symbol,
    this.name,
    this.webSlug,
    this.categories,
    this.description,
    this.image,
    this.marketCap,
  });

  CoinItemEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    webSlug = json['web_slug'];
    categories = json['categories'].cast<String>();
    description = json['description']['en'];
    image = json['image'] != null ? ImageEntity.fromJson(json['image']) : null;
    marketCap = json['market_cap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['web_slug'] = this.webSlug;
    data['categories'] = this.categories;

    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['market_cap'] = this.marketCap;
    return data;
  }

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
      marketCap: object.marketCap,
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
