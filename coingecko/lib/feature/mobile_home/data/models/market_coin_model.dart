class MarketCoinModel {
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
  double? high24h;
  double? low24h;
  MarketCoinModel({
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
  });

  MarketCoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
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
    priceChange24h = double.parse(
      (json['price_change_24h'] == null)
          ? "0"
          : json['price_change_24h'].toString(),
    );
    totalSupply = double.parse(
      (json['total_supply'] == null) ? "0" : json['total_supply'].toString(),
    );
    high24h = double.parse(
      (json['high_24h'] == null) ? "0" : json['high_24h'].toString(),
    );
    low24h = double.parse(
      (json['low_24h'] == null) ? "0" : json['low_24h'].toString(),
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
    data['price_change_24h'] = priceChange24h;
    data['total_supply'] = totalSupply;
    return data;
  }
}
