class CoinItemModel {
  String? id;
  String? symbol;
  String? name;
  String? webSlug;
  List<String>? categories;
  String? description;
  ImageModel? image;
  int? marketCap;

  CoinItemModel({
    this.id,
    this.symbol,
    this.name,
    this.webSlug,
    this.categories,
    this.description,
    this.image,
    this.marketCap,
  });

  CoinItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    webSlug = json['web_slug'];
    categories = json['categories'].cast<String>();
    description = json['description']['en'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    marketCap = json['market_data']['market_cap']['usd'];
  }
}

class ImageModel {
  String? thumb;
  String? small;
  String? large;

  ImageModel({this.thumb, this.small, this.large});

  ImageModel.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    small = json['small'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumb'] = thumb;
    data['small'] = small;
    data['large'] = large;
    return data;
  }
}
