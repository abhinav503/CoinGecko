class MarketCoinModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;

  MarketCoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
  });

  MarketCoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = double.parse(json['current_price'].toString());
    marketCap = double.parse(json['market_cap'].toString());
    marketCapRank = json['market_cap_rank'];
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
