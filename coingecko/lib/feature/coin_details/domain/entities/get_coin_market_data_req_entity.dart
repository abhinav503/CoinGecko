class GetCoinMarketDataReqEntity {
  final String id;
  final String vsCurrency;
  final String days;

  GetCoinMarketDataReqEntity({
    required this.id,
    required this.vsCurrency,
    required this.days,
  });
}
