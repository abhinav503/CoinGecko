class GetCoinMarketDataReqEntity {
  final String id;
  final String vsCurrency;
  final String days;
  final String? interval;

  GetCoinMarketDataReqEntity({
    required this.id,
    required this.vsCurrency,
    required this.days,
    this.interval,
  });
}
