class CoinItemModel {
  String? id;
  String? symbol;
  String? name;
  String? webSlug;
  List<String>? categories;
  String? description;
  ImageModel? image;
  int? marketCap;
  int? marketCapRank;
  double? currentPrice;
  double? priceChange24h;
  double? high24h;
  double? low24h;
  double? totalVolume;
  double? priceChangePercentage24h;
  double? priceChangePercentage7d;
  double? priceChangePercentage30d;
  double? priceChangePercentage1y;
  CoinItemModel({
    this.id,
    this.symbol,
    this.name,
    this.webSlug,
    this.categories,
    this.description,
    this.image,
    this.marketCap,
    this.marketCapRank,
    this.currentPrice,
    this.priceChange24h,
    this.totalVolume,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
    this.priceChangePercentage1y,
  });

  CoinItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    webSlug = json['web_slug'];
    categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
    description = json['description']['en'];
    currentPrice = double.parse(
      json['market_data']['current_price']['usd'].toString(),
    );
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    marketCap = json['market_data']['market_cap']['usd'];
    marketCapRank = json['market_cap_rank'];
    high24h = double.parse(
      double.parse(
        json['market_data']['high_24h']['usd'].toString(),
      ).toStringAsFixed(2),
    );
    low24h = double.parse(
      double.parse(
        json['market_data']['low_24h']['usd'].toString(),
      ).toStringAsFixed(2),
    );
    totalVolume = double.parse(
      double.parse(
        json['market_data']['total_volume']['usd'].toString(),
      ).toStringAsFixed(2),
    );
    priceChange24h = double.parse(
      double.parse(
        json['market_data']['price_change_24h'].toString(),
      ).toStringAsFixed(2),
    );
    priceChangePercentage24h = double.parse(
      double.parse(
        json['market_data']['price_change_percentage_24h'].toString(),
      ).toStringAsFixed(2),
    );
    priceChangePercentage7d = double.parse(
      double.parse(
        json['market_data']['price_change_percentage_7d'].toString(),
      ).toStringAsFixed(2),
    );
    priceChangePercentage30d = double.parse(
      double.parse(
        json['market_data']['price_change_percentage_30d'].toString(),
      ).toStringAsFixed(2),
    );
    priceChangePercentage1y = double.parse(
      double.parse(
        json['market_data']['price_change_percentage_1y'].toString(),
      ).toStringAsFixed(2),
    );
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
