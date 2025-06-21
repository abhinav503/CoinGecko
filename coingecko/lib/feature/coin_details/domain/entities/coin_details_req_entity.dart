class CoinDetailsReqEntity {
  String? id;
  String? localization;
  String? vsCurrency;

  CoinDetailsReqEntity({this.id, this.localization, this.vsCurrency});

  CoinDetailsReqEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localization = json['localization'];
    vsCurrency = json['vs_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['localization'] = localization;
    data['vs_currency'] = vsCurrency;
    return data;
  }
}
