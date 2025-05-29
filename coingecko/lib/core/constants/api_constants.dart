class ApiConstants {
  static const String apiPrefix = String.fromEnvironment("BASE_URL");
  static const String coingeckoApiKey = String.fromEnvironment(
    "COINGECKO_API_KEY",
  );

  static const String marketCoinsApi = "coins/markets";
}
