import 'package:coingecko/core/model_to_entity_mapper/mapper.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';

class CoinDetailsReqModel
    extends Mapper<CoinDetailsReqEntity, CoinDetailsReqModel> {
  String? id;
  String? localization;

  CoinDetailsReqModel({this.id, this.localization});

  CoinDetailsReqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localization = json['localization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['localization'] = localization;
    return data;
  }

  @override
  CoinDetailsReqModel call(CoinDetailsReqEntity object) {
    return CoinDetailsReqModel(
      id: object.id,
      localization: object.localization,
    );
  }
}
