enum FlavorEnv { prod, test }

class Flavor {
  static FlavorEnv? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case FlavorEnv.prod:
        return 'Coingecko';
      case FlavorEnv.test:
        return 'Coingecko Test';
      default:
        return 'Coingecko';
    }
  }
}
