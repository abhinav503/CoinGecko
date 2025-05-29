class CoinDetailsReqEntity {
  String? id;
  String? localization;

  CoinDetailsReqEntity({this.id, this.localization});

  CoinDetailsReqEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localization = json['localization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['localization'] = localization;
    return data;
  }
}
