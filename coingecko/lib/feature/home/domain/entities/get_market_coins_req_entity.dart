class GetMarketCoinsReqEntity {
  String? vsCurrency;
  String? order;
  int? perPage;
  int? page;
  bool? sparkline;

  GetMarketCoinsReqEntity({
    this.vsCurrency,
    this.order,
    this.perPage,
    this.page,
    this.sparkline,
  });

  GetMarketCoinsReqEntity.fromJson(Map<String, dynamic> json) {
    vsCurrency = json['vs_currency'];
    order = json['order'];
    perPage = json['per_page'];
    page = json['page'];
    sparkline = json['sparkline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vs_currency'] = vsCurrency;
    data['order'] = order;
    data['per_page'] = perPage;
    data['page'] = page;
    data['sparkline'] = sparkline;
    return data;
  }
}
