class MarketCoinModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? priceChangePercentage24h;
  MarketCoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.priceChangePercentage24h,
  });

  MarketCoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    print("json['current_price']: ${json['current_price']}");
    currentPrice = double.parse(
      (json['current_price'] == null) ? "0" : json['current_price'].toString(),
    );
    marketCap = double.parse(
      (json['market_cap'] == null) ? "0" : json['market_cap'].toString(),
    );
    marketCapRank = json['market_cap_rank'];
    priceChangePercentage24h = double.parse(
      double.parse(
        (json['price_change_percentage_24h'] == null)
            ? "0"
            : json['price_change_percentage_24h'].toString(),
      ).toStringAsFixed(2),
    );
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
    return data;
  }
}
