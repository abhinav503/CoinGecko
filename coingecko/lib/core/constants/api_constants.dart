class ApiConstants {
  static const String coinGeckoApiUrl = "https://api.coingecko.com/api/v3/";
  static const String apiPrefix = String.fromEnvironment(
    "BASE_URL",
    defaultValue: coinGeckoApiUrl,
  );
  static const String coingeckoApiKey = String.fromEnvironment(
    "COINGECKO_API_KEY",
  );

  static const String marketCoinsApi = "coins/markets";
  static const String coinDetailsApi = "coins/";
}
