import 'package:coingecko/core/model_to_entity_mapper/mapper.dart';
import 'package:coingecko/feature/home/domain/entities/get_market_coins_req_entity.dart';

class GetMarketCoinsReqModel
    extends Mapper<GetMarketCoinsReqEntity, GetMarketCoinsReqModel> {
  String? vsCurrency;
  String? order;
  int? perPage;
  int? page;
  bool? sparkline;

  GetMarketCoinsReqModel({
    this.vsCurrency,
    this.order,
    this.perPage,
    this.page,
    this.sparkline,
  });

  GetMarketCoinsReqModel.fromJson(Map<String, dynamic> json) {
    vsCurrency = json['vs_currency'];
    order = json['order'];
    perPage = json['per_page'];
    page = json['page'];
    sparkline = json['sparkline'];
  }

  Map<String, String> toJsonForQuery() {
    final Map<String, String> data = <String, String>{};
    data['vs_currency'] = vsCurrency ?? "";
    data['order'] = order ?? "";
    data['per_page'] = perPage.toString();
    data['page'] = page.toString();
    data['sparkline'] = sparkline.toString();
    return data;
  }

  @override
  GetMarketCoinsReqModel call(GetMarketCoinsReqEntity object) {
    return GetMarketCoinsReqModel(
      vsCurrency: object.vsCurrency,
      order: object.order,
      perPage: object.perPage,
      page: object.page,
      sparkline: object.sparkline,
    );
  }
}
